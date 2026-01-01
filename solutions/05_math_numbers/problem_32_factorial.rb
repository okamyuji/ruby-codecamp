#!/usr/bin/env ruby
# frozen_string_literal: true

def factorial(n)
  return 1 if n <= 1

  result = 1
  (2..n).each { |i| result *= i }
  result
end

def factorial_reduce(n)
  return 1 if n <= 1

  (1..n).reduce(:*)
end

def factorial_recursive(n)
  return 1 if n <= 1

  n * factorial_recursive(n - 1)
end

def factorial_tail_recursive(n, acc = 1)
  return acc if n <= 1

  factorial_tail_recursive(n - 1, acc * n)
end

def factorial_inject(n)
  (1..n).inject(1, :*)
end

class Factorial
  def initialize
    @cache = { 0 => 1, 1 => 1 }
  end

  def calculate(n)
    return @cache[n] if @cache.key?(n)

    @cache[n] = n * calculate(n - 1)
  end
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 階乗の計算 テスト ==='
  puts

  result1 = factorial(5)
  puts 'Test 1: factorial(5)'
  puts "結果: #{result1}"
  puts '期待値: 120'
  puts "判定: #{result1 == 120 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = factorial(0)
  puts 'Test 2: factorial(0)'
  puts "結果: #{result2}"
  puts '期待値: 1'
  puts "判定: #{result2 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = factorial(1)
  puts 'Test 3: factorial(1)'
  puts "結果: #{result3}"
  puts '期待値: 1'
  puts "判定: #{result3 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = factorial(10)
  puts 'Test 4: factorial(10)'
  puts "結果: #{result4}"
  puts '期待値: 3628800'
  puts "判定: #{result4 == 3_628_800 ? '✓ PASS' : '✗ FAIL'}"
  puts

  fact = Factorial.new
  result5 = fact.calculate(20)
  puts "fact.calculate(20) = #{result5}"
  puts '期待値: 2432902008176640000'
  puts "判定: #{result5 == 2_432_902_008_176_640_000 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
