#!/usr/bin/env ruby
# frozen_string_literal: true

def digit_sum(n)
  sum = 0

  while n > 0
    sum += n % 10
    n /= 10
  end

  sum
end

def digit_sum_string(n)
  n.to_s.chars.map(&:to_i).sum
end

def digit_sum_digits(n)
  n.digits.sum
end

def digit_sum_reduce(n)
  n.digits.reduce(0, :+)
end

def digit_sum_recursive(n)
  return n if n < 10

  n % 10 + digit_sum_recursive(n / 10)
end

def digital_root(n)
  return 0 if n == 0

  1 + (n - 1) % 9
end

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
