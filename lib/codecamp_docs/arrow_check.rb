# frozen_string_literal: true

require 'prism'
require 'stringio'
require_relative 'error'
require_relative 'markdown_sync'
require_relative 'regions'

module CodecampDocs
  # コード例の `# => 値` を、式を実際に評価した値と照合する
  module ArrowCheck
    # verify が false のブロックは評価だけして `# =>` は照合しない（解答ファイル側で照合するため）
    Block = Data.define(:code, :label, :line, :verify)
    Result = Data.define(:failures, :skipped, :checked)
    Arrow = Data.define(:index, :column, :expected, :own_line)

    SKIP_MARKER = '<!-- docs:skip -->'
    ARROW = /\A#\s*=>\s*(.+?)\s*\z/
    NONDETERMINISTIC = /または|など|\bor\b/
    NOT_A_VALUE = /\A(end|\}|do\b|def\b|class\b|if\b|elsif\b|else\b|when\b|return\b)/
    OPENER_SUFFIXES = [' do', '{', '|', ',', '(', '['].freeze

    def self.blocks_from_markdown(md_text, md_path:)
      blocks = []
      open = nil
      previous = ''
      md_text.each_line.with_index(1) do |line, number|
        if open
          open = close_or_collect(open, line, blocks, md_path)
        elsif MarkdownSync::OPEN_FENCE.match?(line)
          open = { line: number + 1, previous: previous.strip, lines: [] }
        end
        previous = line
      end
      raise Error, "#{md_path}:#{open[:line] - 1}: ruby ブロックが閉じていない" if open

      blocks
    end

    def self.close_or_collect(open, line, blocks, md_path)
      if MarkdownSync::CLOSE_FENCE.match?(line)
        blocks << markdown_block(open, md_path) unless open[:previous] == SKIP_MARKER
        nil
      else
        open[:lines] << line
        open
      end
    end

    def self.markdown_block(open, md_path)
      verify = !MarkdownSync::MARKER.match?(open[:previous])
      Block.new(code: open[:lines].join, label: md_path, line: open[:line], verify:)
    end

    def self.blocks_from_regions(rb_text, path:)
      Regions.parse(rb_text, path:).map do |name, body|
        Block.new(code: body, label: "#{path}##{name}", line: region_line(rb_text, name), verify: true)
      end
    end

    def self.region_line(rb_text, name)
      begin_index = rb_text.lines.index { |l| Regions::MARKER.match(l)&.captures == ['begin', name] }
      begin_index + 2
    end

    def self.check(blocks)
      session = Session.new
      blocks.each { |block| session.run(block) }
      Result.new(failures: session.failures, skipped: session.skipped, checked: session.checked)
    end

    # root 直下の `[0-9]*.md` と `solutions/**/*.rb` を 1 ファイル 1 環境で照合し、結果を合算する
    def self.check_repo(root)
      md = Dir.glob(File.join(root, '[0-9]*.md')).map do |file|
        check(blocks_from_markdown(File.read(file), md_path: relative(root, file)))
      end
      rb = Dir.glob(File.join(root, 'solutions/**/*.rb')).map do |file|
        check(blocks_from_regions(File.read(file), path: relative(root, file)))
      end
      merge(md + rb)
    end

    def self.merge(results)
      Result.new(failures: results.flat_map(&:failures), skipped: results.sum(&:skipped),
                 checked: results.sum(&:checked))
    end

    def self.relative(root, file)
      file.delete_prefix("#{root}/")
    end

    # `check` を呼ぶたびに新しい評価環境を作る。ブロック間の定義はこの環境の中でだけ引き継ぐ
    class Session
      attr_reader :failures, :skipped

      def checked = @compared_total

      def initialize
        @failures = []
        @skipped = 0
        @compared_total = 0
        @label = nil
        @env = Object.new
        session = self
        @env.define_singleton_method(:__chk) do |line, mode, expected, value|
          session.compare(line, mode, expected, value)
          value
        end
      end

      def run(block)
        @label = block.label
        @rewritten = []
        @compared = Set.new
        code = block.verify ? instrument(block) : block.code
        report_unevaluated if evaluate(code, block)
        @compared_total += @compared.size
      end

      def compare(line, mode, expected, value)
        @compared << line
        actual = mode == :puts ? puts_text(value) : value.inspect
        @failures << "#{@label}:#{line} expected=#{expected} actual=#{actual}" unless actual == expected
      end

      private

      # puts は配列を平らにして 1 要素 1 行で出す
      def puts_text(value)
        value.is_a?(Array) ? value.flatten.join("\n") : value.to_s
      end

      # 例外なく終わったときだけ true を返す。例外の後は未到達の矢印を重ねて報告しない
      def evaluate(code, block)
        original = $stdout
        $stdout = StringIO.new
        @env.instance_eval(code, block.label, block.line)
        true
      rescue StandardError, ScriptError, SystemExit, SystemStackError => e
        @failures << "#{block.label}:#{block.line} #{e.class}: #{e.message[0, 150]}"
        false
      ensure
        $stdout = original
      end

      def report_unevaluated
        (@rewritten - @compared.to_a).each { |line| @failures << "#{@label}:#{line} # => が評価されなかった" }
      end

      # 元のコードが構文エラーなら書き換えず、評価側の SyntaxError 1 件だけを報告させる
      def instrument(block)
        parsed = Prism.parse(block.code)
        return block.code unless parsed.success?

        code = rewrite_arrows(block, parsed.comments)
        return code if Prism.parse(code).success?

        @failures << "#{block.label}:#{block.line} instrument に失敗した（# => の対象を式として書き換えられない）"
        @rewritten = []
        block.code
      end

      def rewrite_arrows(block, comments)
        lines = block.code.lines
        @comment_columns = comments.to_h { |c| [c.location.start_line - 1, c.location.start_column] }
        arrows = find_arrows(comments, lines)
        out = lines.dup
        arrows.each_value { |arrow| rewrite(out, lines, arrows, arrow, block.line) }
        out.join
      end

      # 文字列の中の `# =>` を拾わないよう、Prism のコメント位置で探す。列はバイト単位
      def find_arrows(comments, lines)
        found = comments.filter_map do |comment|
          match = ARROW.match(comment.slice) or next
          index = comment.location.start_line - 1
          column = comment.location.start_column
          expected = match[1].split('（', 2).first.to_s.strip
          Arrow.new(index:, column:, expected:, own_line: lines[index].byteslice(0, column).strip.empty?)
        end
        found.to_h { |arrow| [arrow.index, arrow] }
      end

      def rewrite(out, lines, arrows, arrow, start)
        return @skipped += 1 if NONDETERMINISTIC.match?(arrow.expected)

        target, code = target_of(lines, arrows, arrow)
        return unless target && checkable?(code.strip)

        @rewritten << (start + arrow.index)
        mode, expr = mode_and_expr(code.strip)
        tail = arrow.own_line ? "\n" : " #{lines[arrow.index].byteslice(arrow.column..)}"
        call = "__chk(#{start + arrow.index}, :#{mode}, #{arrow.expected.inspect}, (#{expr}))"
        out[target] = "#{code[/\A\s*/]}#{call}#{tail}"
      end

      # 行末の `# =>` は同じ行の式、単独行の `# =>` は直前の式を対象にする
      def target_of(lines, arrows, arrow)
        return [arrow.index, lines[arrow.index].byteslice(0, arrow.column).rstrip] unless arrow.own_line

        index = arrow.index - 1
        index -= 1 while index >= 0 && (lines[index].strip.empty? || lines[index].strip.start_with?('#'))
        return if index.negative? || arrows.key?(index)

        [index, lines[index].byteslice(0, @comment_columns.fetch(index, lines[index].bytesize)).rstrip]
      end

      def checkable?(body)
        !NOT_A_VALUE.match?(body) && !body.end_with?(*OPENER_SUFFIXES)
      end

      def mode_and_expr(body)
        case body
        when /\Ap\s+(.+)\z/ then [:inspect, ::Regexp.last_match(1)]
        when /\A(?:puts|print)\((.+)\)\z/, /\A(?:puts|print)\s+(.+)\z/ then [:puts, ::Regexp.last_match(1)]
        else [:inspect, body]
        end
      end
    end
  end
end
