#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin compress_string
# 解法1: ループで実装（推奨）
def compress_string(str)
  return str if str.empty?

  result = ''
  current_char = str[0]
  count = 1

  # 2文字目から走査
  (1...str.length).each do |i|
    if str[i] == current_char
      # 同じ文字が続いている
      count += 1
    else
      # 異なる文字に遭遇
      result += "#{current_char}#{count}"
      current_char = str[i]
      count = 1
    end
  end

  # 最後のグループを追加
  result += "#{current_char}#{count}"

  # 圧縮が効果的な場合のみ圧縮結果を返す
  result.length < str.length ? result : str
end

# 解法2: chunk_whileを使用
def compress_string_chunk(str)
  return str if str.empty?

  # 連続する同じ文字をグループ化
  groups = str.chars.chunk_while { |a, b| a == b }

  # 各グループを文字と長さに変換
  result = groups.map { |group| "#{group[0]}#{group.length}" }.join

  result.length < str.length ? result : str
end

# 解法3: 正規表現を使用
def compress_string_regex(str)
  return str if str.empty?

  # 連続する同じ文字にマッチ
  result = str.gsub(/(.)\1*/) { |match| "#{match[0]}#{match.length}" }

  result.length < str.length ? result : str
end

# 解法4: each_cons的アプローチ
def compress_string_functional(str)
  return str if str.empty?

  result = []
  char = str[0]
  count = 0

  str.each_char do |c|
    if c == char
      count += 1
    else
      result << "#{char}#{count}"
      char = c
      count = 1
    end
  end

  result << "#{char}#{count}"
  compressed = result.join

  compressed.length < str.length ? compressed : str
end

# テストケース
p compress_string('aabcccccaaa')  # => "a2b1c5a3"
p compress_string('abc')          # => "abc"（圧縮しても短くならない）
p compress_string('aaa')          # => "a3"
p compress_string('')             # => ""
p compress_string('a')            # => "a"
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 文字列の圧縮 テスト ==='
  puts

  result1 = compress_string('aabcccccaaa')
  puts "Test 1: compress_string('aabcccccaaa')"
  puts "結果: '#{result1}'"
  puts "期待値: 'a2b1c5a3'"
  puts "判定: #{result1 == 'a2b1c5a3' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = compress_string('abc')
  puts "Test 2: compress_string('abc')"
  puts "結果: '#{result2}'"
  puts "期待値: 'abc' (圧縮しても短くならない)"
  puts "判定: #{result2 == 'abc' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = compress_string('aaa')
  puts "Test 3: compress_string('aaa')"
  puts "結果: '#{result3}'"
  puts "期待値: 'a3'"
  puts "判定: #{result3 == 'a3' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = compress_string('')
  puts "Test 4: compress_string('')"
  puts "結果: '#{result4}'"
  puts "期待値: ''"
  puts "判定: #{result4 == '' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = compress_string('a')
  puts "Test 5: compress_string('a')"
  puts "結果: '#{result5}'"
  puts "期待値: 'a'"
  puts "判定: #{result5 == 'a' ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
