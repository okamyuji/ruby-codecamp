#!/usr/bin/env ruby
# frozen_string_literal: true

def climb_stairs(n)
  return n if n <= 2

  prev_prev = 1
  prev = 2

  (3..n).each do
    current = prev + prev_prev
    prev_prev = prev
    prev = current
  end

  prev
end

def climb_stairs_dp(n)
  return n if n <= 2

  dp = Array.new(n + 1)
  dp[1] = 1
  dp[2] = 2

  (3..n).each do |i|
    dp[i] = dp[i - 1] + dp[i - 2]
  end

  dp[n]
end

def climb_stairs_memo(n, memo = {})
  return n if n <= 2
  return memo[n] if memo.key?(n)

  memo[n] = climb_stairs_memo(n - 1, memo) + climb_stairs_memo(n - 2, memo)
end

def climb_stairs_naive(n)
  return n if n <= 2

  climb_stairs_naive(n - 1) + climb_stairs_naive(n - 2)
end

def climb_stairs_matrix(n)
  return n if n <= 2

  matrix_power([[1, 1], [1, 0]], n)[0][0]
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

if __FILE__ == $PROGRAM_NAME
  puts '=== 階段の上り方 テスト ==='
  puts

  result1 = climb_stairs(2)
  puts 'Test 1: climb_stairs(2)'
  puts "結果: #{result1}"
  puts '期待値: 2'
  puts "判定: #{result1 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = climb_stairs(3)
  puts 'Test 2: climb_stairs(3)'
  puts "結果: #{result2}"
  puts '期待値: 3'
  puts "判定: #{result2 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = climb_stairs(4)
  puts 'Test 3: climb_stairs(4)'
  puts "結果: #{result3}"
  puts '期待値: 5'
  puts "判定: #{result3 == 5 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = climb_stairs(5)
  puts 'Test 4: climb_stairs(5)'
  puts "結果: #{result4}"
  puts '期待値: 8'
  puts "判定: #{result4 == 8 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = climb_stairs(10)
  puts 'Test 5: climb_stairs(10)'
  puts "結果: #{result5}"
  puts '期待値: 89'
  puts "判定: #{result5 == 89 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
