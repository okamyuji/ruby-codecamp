#!/usr/bin/env ruby
# frozen_string_literal: true

def sum_of_squares_recursive(n)
  return 0 if n == 0

  n * n + sum_of_squares_recursive(n - 1)
end

def sum_of_squares_tail(n, acc = 0)
  return acc if n == 0

  sum_of_squares_tail(n - 1, acc + n * n)
end

def sum_of_squares_iterative(n)
  sum = 0
  (1..n).each { |i| sum += i * i }
  sum
end

def sum_of_squares_reduce(n)
  (1..n).reduce(0) { |sum, i| sum + i * i }
end

def sum_of_squares_sum(n)
  (1..n).sum { |i| i * i }
end

def sum_of_squares_formula(n)
  n * (n + 1) * (2 * n + 1) / 6
end

def sum_of_powers(n, k)
  (1..n).sum { |i| i**k }
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 再帰的な累乗和 テスト ==='
  puts

  result1 = sum_of_squares_recursive(5)
  puts 'Test 1: sum_of_squares_recursive(5)'
  puts "結果: #{result1}"
  puts '期待値: 55'
  puts "判定: #{result1 == 55 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = sum_of_squares_tail(5)
  puts 'Test 2: sum_of_squares_tail(5)'
  puts "結果: #{result2}"
  puts '期待値: 55'
  puts "判定: #{result2 == 55 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = sum_of_squares_formula(5)
  puts 'Test 3: sum_of_squares_formula(5)'
  puts "結果: #{result3}"
  puts '期待値: 55'
  puts "判定: #{result3 == 55 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = sum_of_squares_recursive(10)
  puts 'Test 4: sum_of_squares_recursive(10)'
  puts "結果: #{result4}"
  puts '期待値: 385'
  puts "判定: #{result4 == 385 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = sum_of_squares_formula(100)
  puts 'Test 5: sum_of_squares_formula(100)'
  puts "結果: #{result5}"
  puts '期待値: 338350'
  puts "判定: #{result5 == 338_350 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result6 = sum_of_powers(5, 3)
  puts "sum_of_powers(5, 3) = #{result6}"
  puts '期待値: 225'
  puts "判定: #{result6 == 225 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
