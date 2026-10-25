# frozen_string_literal: true

require_relative 'error'

module CodecampDocs
  module Regions
    MARKER = /\A\s*# docs:(begin|end)\b ?(\S*)/

    # 範囲名 => 目印行を除いた中身（末尾は改行1つ）を返す
    def self.parse(text, path:)
      regions = {}
      current = nil # { name:, line:, body: }

      text.each_line.with_index(1) do |line, lineno|
        kind, name = line.match(MARKER)&.captures
        where = "#{path}:#{lineno}"
        case kind
        when 'begin' then current = open_region(regions, current, name, lineno, where)
        when 'end' then current = close_region(regions, current, where)
        else current[:body] << line if current
        end
      end

      raise Error, "#{path}:#{current[:line]}: 範囲 #{current[:name]} が閉じていない" if current

      regions
    end

    def self.open_region(regions, current, name, lineno, where)
      raise Error, "#{where}: 範囲 #{current[:name]} が閉じる前に begin がある" if current
      raise Error, "#{where}: begin に範囲名がない" if name.empty?
      raise Error, "#{where}: 範囲名 #{name} が重複している" if regions.key?(name)

      { name:, line: lineno, body: +'' }
    end

    def self.close_region(regions, current, where)
      raise Error, "#{where}: begin のない end がある" unless current

      regions[current[:name]] = current[:body]
      nil
    end

    private_class_method :open_region, :close_region
  end
end
