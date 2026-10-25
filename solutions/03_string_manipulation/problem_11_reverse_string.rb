#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin reverse_string
# 解法1: reverseメソッドを使用（推奨）
def reverse_string(str)
  str.reverse
end

# 解法2: 手動で逆順に構築
def reverse_string_manual(str)
  result = ''

  # 最後の文字から最初の文字まで逆順にイテレート
  (str.length - 1).downto(0) do |i|
    result += str[i]
  end

  result
end

# 解法3: 配列に変換して反転
def reverse_string_array(str)
  # 文字列を文字の配列に変換し、反転して結合
  str.chars.reverse.join
end

# 解法4: reduceを使用
def reverse_string_reduce(str)
  # 各文字を逆順に結合
  str.chars.reduce('') { |acc, char| char + acc }
end

# テストケース
p reverse_string('hello')      # => "olleh"
p reverse_string('Ruby')       # => "ybuR"
p reverse_string('a')          # => "a"
p reverse_string('')           # => ""
p reverse_string('12345')      # => "54321"
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 文字列の反転 テスト ==='
  puts

  result1 = reverse_string('hello')
  puts "Test 1: reverse_string('hello')"
  puts "結果: '#{result1}'"
  puts "期待値: 'olleh'"
  puts "判定: #{result1 == 'olleh' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = reverse_string('Ruby')
  puts "Test 2: reverse_string('Ruby')"
  puts "結果: '#{result2}'"
  puts "期待値: 'ybuR'"
  puts "判定: #{result2 == 'ybuR' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = reverse_string('a')
  puts "Test 3: reverse_string('a')"
  puts "結果: '#{result3}'"
  puts "期待値: 'a'"
  puts "判定: #{result3 == 'a' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = reverse_string('')
  puts "Test 4: reverse_string('')"
  puts "結果: '#{result4}'"
  puts "期待値: ''"
  puts "判定: #{result4 == '' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = reverse_string('12345')
  puts "Test 5: reverse_string('12345')"
  puts "結果: '#{result5}'"
  puts "期待値: '54321'"
  puts "判定: #{result5 == '54321' ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
