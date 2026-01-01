#!/usr/bin/env ruby
# frozen_string_literal: true

def fibonacci(n)
  return n if n <= 1

  prev_prev = 0
  prev = 1

  (2..n).each do
    current = prev + prev_prev
    prev_prev = prev
    prev = current
  end

  prev
end

def fibonacci_array(n)
  return n if n <= 1

  fib = [0, 1]
  (2..n).each { |i| fib[i] = fib[i - 1] + fib[i - 2] }
  fib[n]
end

def fibonacci_memo(n, memo = {})
  return n if n <= 1
  return memo[n] if memo.key?(n)

  memo[n] = fibonacci_memo(n - 1, memo) + fibonacci_memo(n - 2, memo)
end

def fibonacci_matrix(n)
  return n if n <= 1

  matrix_power([[1, 1], [1, 0]], n)[0][1]
end

def matrix_multiply(a, b)
  [
    [a[0][0] * b[0][0] + a[0][1] * b[1][0], a[0][0] * b[0][1] + a[0][1] * b[1][1]],
    [a[1][0] * b[0][0] + a[1][1] * b[1][0], a[1][0] * b[0][1] + a[1][1] * b[1][1]]
  ]
end

def matrix_power(matrix, n)
  result = [[1, 0], [0, 1]]

  while n > 0
    result = matrix_multiply(result, matrix) if n.odd?
    matrix = matrix_multiply(matrix, matrix)
    n /= 2
  end

  result
end

def fibonacci_enumerator(n)
  fib = Enumerator.new do |y|
    a = 0
    b = 1
    loop do
      y << a
      a, b = b, a + b
    end
  end

  fib.take(n + 1).last
end

if __FILE__ == $PROGRAM_NAME
  puts '=== フィボナッチ数列 テスト ==='
  puts

  result1 = fibonacci(10)
  puts 'Test 1: fibonacci(10)'
  puts "結果: #{result1}"
  puts '期待値: 55'
  puts "判定: #{result1 == 55 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = fibonacci(0)
  puts 'Test 2: fibonacci(0)'
  puts "結果: #{result2}"
  puts '期待値: 0'
  puts "判定: #{result2 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = fibonacci(1)
  puts 'Test 3: fibonacci(1)'
  puts "結果: #{result3}"
  puts '期待値: 1'
  puts "判定: #{result3 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = fibonacci(20)
  puts 'Test 4: fibonacci(20)'
  puts "結果: #{result4}"
  puts '期待値: 6765'
  puts "判定: #{result4 == 6765 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
