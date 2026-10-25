#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin palindrome_number?
# 解法1: 数値を反転して比較（推奨）
def palindrome_number?(x)
  # 負の数は回文ではない
  return false if x < 0

  original = x
  reversed = 0

  while x > 0
    reversed = reversed * 10 + x % 10
    x /= 10
  end

  original == reversed
end

# 解法2: 文字列に変換
def palindrome_number_string?(x)
  return false if x < 0

  x.to_s == x.to_s.reverse
end

# 解法3: 半分だけ反転（オーバーフロー対策）
def palindrome_number_half?(x)
  # 負の数、または10の倍数（0を除く）は回文ではない
  return false if x < 0 || (x != 0 && x % 10 == 0)

  reversed_half = 0

  # 半分だけ反転
  while x > reversed_half
    reversed_half = reversed_half * 10 + x % 10
    x /= 10
  end

  # 桁数が偶数または奇数の場合を考慮
  x == reversed_half || x == reversed_half / 10
end

# 解法4: 配列を使用
def palindrome_number_array?(x)
  return false if x < 0

  digits = []
  temp = x

  while temp > 0
    digits << temp % 10
    temp /= 10
  end

  digits == digits.reverse
end

# テストケース
puts palindrome_number?(121)    # => true
puts palindrome_number?(-121)   # => false
puts palindrome_number?(10)     # => false
puts palindrome_number?(12_321) # => true
puts palindrome_number?(0) # => true
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 回文数 テスト ==='
  puts

  result1 = palindrome_number?(121)
  puts 'Test 1: palindrome_number?(121)'
  puts "結果: #{result1}"
  puts '期待値: true'
  puts "判定: #{result1 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = palindrome_number?(-121)
  puts 'Test 2: palindrome_number?(-121)'
  puts "結果: #{result2}"
  puts '期待値: false'
  puts "判定: #{result2 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = palindrome_number?(10)
  puts 'Test 3: palindrome_number?(10)'
  puts "結果: #{result3}"
  puts '期待値: false'
  puts "判定: #{result3 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = palindrome_number?(12_321)
  puts 'Test 4: palindrome_number?(12321)'
  puts "結果: #{result4}"
  puts '期待値: true'
  puts "判定: #{result4 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = palindrome_number?(0)
  puts 'Test 5: palindrome_number?(0)'
  puts "結果: #{result5}"
  puts '期待値: true'
  puts "判定: #{result5 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
