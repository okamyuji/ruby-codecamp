#!/usr/bin/env ruby
# frozen_string_literal: true

def maximal_square(matrix)
  return 0 if matrix.empty?

  m = matrix.length
  n = matrix[0].length

  dp = Array.new(m + 1) { Array.new(n + 1, 0) }
  max_side = 0

  (1..m).each do |i|
    (1..n).each do |j|
      next unless matrix[i - 1][j - 1] == '1'

      dp[i][j] = 1 + [
        dp[i - 1][j],
        dp[i][j - 1],
        dp[i - 1][j - 1]
      ].min

      max_side = [max_side, dp[i][j]].max
    end
  end

  max_side * max_side
end

def maximal_square_1d(matrix)
  return 0 if matrix.empty?

  m = matrix.length
  n = matrix[0].length

  prev = Array.new(n + 1, 0)
  max_side = 0

  (1..m).each do |i|
    curr = Array.new(n + 1, 0)

    (1..n).each do |j|
      if matrix[i - 1][j - 1] == '1'
        curr[j] = 1 + [prev[j], curr[j - 1], prev[j - 1]].min
        max_side = [max_side, curr[j]].max
      end
    end

    prev = curr
  end

  max_side * max_side
end

def maximal_square_with_position(matrix)
  return [0, nil] if matrix.empty?

  m = matrix.length
  n = matrix[0].length

  dp = Array.new(m + 1) { Array.new(n + 1, 0) }
  max_side = 0
  max_i = 0
  max_j = 0

  (1..m).each do |i|
    (1..n).each do |j|
      next unless matrix[i - 1][j - 1] == '1'

      dp[i][j] = 1 + [dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]].min

      next unless dp[i][j] > max_side

      max_side = dp[i][j]
      max_i = i
      max_j = j
    end
  end

  top_left = [max_i - max_side, max_j - max_side]

  [max_side * max_side, top_left]
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 最大正方形（Maximal Square） テスト ==='
  puts

  matrix1 = [
    ['1', '0', '1', '0', '0'],
    ['1', '0', '1', '1', '1'],
    ['1', '1', '1', '1', '1'],
    ['1', '0', '0', '1', '0']
  ]

  result1 = maximal_square(matrix1)
  puts 'Test 1: maximal_square(matrix1)'
  puts "結果: #{result1}"
  puts '期待値: 4'
  puts "判定: #{result1 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  matrix2 = [
    ['0', '1'],
    ['1', '0']
  ]

  result2 = maximal_square(matrix2)
  puts 'Test 2: maximal_square(matrix2)'
  puts "結果: #{result2}"
  puts '期待値: 1'
  puts "判定: #{result2 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  matrix3 = [['0']]

  result3 = maximal_square(matrix3)
  puts 'Test 3: maximal_square(matrix3)'
  puts "結果: #{result3}"
  puts '期待値: 0'
  puts "判定: #{result3 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
