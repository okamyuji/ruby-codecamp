#!/usr/bin/env ruby
# frozen_string_literal: true

def power(x, n)
  x**n
end

def power_fast(x, n)
  if n < 0
    x = 1.0 / x
    n = -n
  end

  result = 1.0

  while n > 0
    result *= x if n.odd?
    x *= x
    n /= 2
  end

  result
end

def power_recursive(x, n)
  return 1.0 if n == 0

  if n < 0
    x = 1.0 / x
    n = -n
  end

  half = power_recursive(x, n / 2)

  if n.even?
    half * half
  else
    half * half * x
  end
end

def power_simple(x, n)
  return 1.0 if n == 0

  if n < 0
    x = 1.0 / x
    n = -n
  end

  result = 1.0
  n.times { result *= x }
  result
end

if __FILE__ == $PROGRAM_NAME
  puts '=== べき乗の計算 テスト ==='
  puts

  result1 = power(2.0, 10)
  puts 'Test 1: power(2.0, 10)'
  puts "結果: #{result1}"
  puts '期待値: 1024.0'
  puts "判定: #{result1 == 1024.0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = power(2.1, 3)
  puts 'Test 2: power(2.1, 3)'
  puts "結果: #{result2.round(3)}"
  puts '期待値: 9.261'
  puts "判定: #{result2.round(3) == 9.261 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = power(2.0, -2)
  puts 'Test 3: power(2.0, -2)'
  puts "結果: #{result3}"
  puts '期待値: 0.25'
  puts "判定: #{result3 == 0.25 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = power(0.0, 1)
  puts 'Test 4: power(0.0, 1)'
  puts "結果: #{result4}"
  puts '期待値: 0.0'
  puts "判定: #{result4 == 0.0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = power(1.0, 1000)
  puts 'Test 5: power(1.0, 1000)'
  puts "結果: #{result5}"
  puts '期待値: 1.0'
  puts "判定: #{result5 == 1.0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
