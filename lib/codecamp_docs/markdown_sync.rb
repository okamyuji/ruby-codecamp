# frozen_string_literal: true

require_relative 'error'
require_relative 'regions'

module CodecampDocs
  module MarkdownSync
    MARKER = /\A<!-- source: (?<path>\S+)#(?<name>\S+) -->\s*\z/
    OPEN_FENCE = /\A```ruby\s*\z/
    CLOSE_FENCE = /\A```\s*\z/

    # 目印の直後の ruby ブロックの中身を、解答ファイルの範囲で置き換えた全文を返す
    def self.sync(md_text, md_path:, root:)
      lines = md_text.lines
      out = +''
      index = 0
      while index < lines.size
        out << lines[index]
        marker = MARKER.match(lines[index])
        index += 1
        next unless marker

        where = "#{md_path}:#{index}"
        close = closing_index(lines, index, where)
        out << lines[index] << region_body(root, marker[:path], marker[:name], where)
        index = close
      end
      out
    end

    # 開きフェンスの次の行から閉じフェンスを探し、その行番号（0 始まり）を返す
    def self.closing_index(lines, index, where)
      raise Error, "#{where}: source 目印の次の行が ```ruby ではない" unless OPEN_FENCE.match?(lines[index].to_s)

      close = ((index + 1)...lines.size).find { |i| CLOSE_FENCE.match?(lines[i]) }
      raise Error, "#{where}: ruby ブロックが閉じていない" unless close

      close
    end

    def self.region_body(root, path, name, where)
      file = File.join(root, path)
      raise Error, "#{where}: 解答ファイル #{path} がない（#{path}##{name}）" unless File.file?(file)

      regions = Regions.parse(File.read(file), path:)
      regions.fetch(name) { raise Error, "#{where}: 範囲がない（#{path}##{name}）" }
    end

    private_class_method :closing_index, :region_body
  end
end
