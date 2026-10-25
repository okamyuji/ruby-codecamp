#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin digit_sum
# 解法1: 数学的アプローチ（推奨）
def digit_sum(n)
  sum = 0

  while n > 0
    sum += n % 10  # 最下位の桁を取得
    n /= 10        # 次の桁へ移動
  end

  sum
end

# 解法2: 文字列に変換
def digit_sum_string(n)
  n.to_s.chars.map(&:to_i).sum
end

# 解法3: digitsメソッドを使用
def digit_sum_digits(n)
  # digitsは各桁を配列として返す（最下位から）
  n.digits.sum
end

# 解法4: reduceを使用
def digit_sum_reduce(n)
  n.digits.reduce(0, :+)
end

# 解法5: 再帰
def digit_sum_recursive(n)
  return n if n < 10

  n % 10 + digit_sum_recursive(n / 10)
end

# 発展: 桁の合計を繰り返して1桁にする
def digital_root(n)
  return 0 if n == 0

  # 数学的な公式: 1 + (n - 1) % 9
  1 + (n - 1) % 9
end

# テストケース
puts digit_sum(12_345) # => 15
puts digit_sum(0)       # => 0
puts digit_sum(9999)    # => 36
puts digit_sum(100)     # => 1

puts digital_root(38)   # => 2（3 + 8 = 11, 1 + 1 = 2）
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 数字の桁の合計 テスト ==='
  puts

  result1 = digit_sum(12_345)
  puts 'Test 1: digit_sum(12345)'
  puts "結果: #{result1}"
  puts '期待値: 15'
  puts "判定: #{result1 == 15 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = digit_sum(0)
  puts 'Test 2: digit_sum(0)'
  puts "結果: #{result2}"
  puts '期待値: 0'
  puts "判定: #{result2 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = digit_sum(9999)
  puts 'Test 3: digit_sum(9999)'
  puts "結果: #{result3}"
  puts '期待値: 36'
  puts "判定: #{result3 == 36 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = digit_sum(100)
  puts 'Test 4: digit_sum(100)'
  puts "結果: #{result4}"
  puts '期待値: 1'
  puts "判定: #{result4 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = digital_root(38)
  puts "digital_root(38) = #{result5}"
  puts '期待値: 2 (3 + 8 = 11, 1 + 1 = 2)'
  puts "判定: #{result5 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
