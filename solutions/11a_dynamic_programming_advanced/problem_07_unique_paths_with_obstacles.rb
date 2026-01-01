#!/usr/bin/env ruby
# frozen_string_literal: true

def unique_paths_with_obstacles(obstacle_grid)
  return 0 if obstacle_grid[0][0] == 1

  m = obstacle_grid.length
  n = obstacle_grid[0].length

  dp = Array.new(m) { Array.new(n, 0) }
  dp[0][0] = 1

  (0...m).each do |i|
    (0...n).each do |j|
      next if i == 0 && j == 0

      if obstacle_grid[i][j] == 1
        dp[i][j] = 0
      else
        dp[i][j] = 0
        dp[i][j] += dp[i - 1][j] if i > 0
        dp[i][j] += dp[i][j - 1] if j > 0
      end
    end
  end

  dp[m - 1][n - 1]
end

def unique_paths_with_obstacles_1d(obstacle_grid)
  return 0 if obstacle_grid[0][0] == 1

  m = obstacle_grid.length
  n = obstacle_grid[0].length

  dp = Array.new(n, 0)
  dp[0] = 1

  (0...m).each do |i|
    (0...n).each do |j|
      if obstacle_grid[i][j] == 1
        dp[j] = 0
      elsif j > 0
        dp[j] += dp[j - 1]
      end
    end
  end

  dp[n - 1]
end

def unique_paths_with_obstacles_inplace(obstacle_grid)
  return 0 if obstacle_grid[0][0] == 1

  m = obstacle_grid.length
  n = obstacle_grid[0].length

  obstacle_grid[0][0] = 1

  (1...n).each do |j|
    obstacle_grid[0][j] = obstacle_grid[0][j] == 0 && obstacle_grid[0][j - 1] == 1 ? 1 : 0
  end

  (1...m).each do |i|
    obstacle_grid[i][0] = obstacle_grid[i][0] == 0 && obstacle_grid[i - 1][0] == 1 ? 1 : 0
  end

  (1...m).each do |i|
    (1...n).each do |j|
      if obstacle_grid[i][j] == 0
        obstacle_grid[i][j] = obstacle_grid[i - 1][j] + obstacle_grid[i][j - 1]
      else
        obstacle_grid[i][j] = 0
      end
    end
  end

  obstacle_grid[m - 1][n - 1]
end

if __FILE__ == $PROGRAM_NAME
  puts '=== ユニークなパスII（障害物あり） テスト ==='
  puts

  grid1 = [
    [0, 0, 0],
    [0, 1, 0],
    [0, 0, 0]
  ]

  result1 = unique_paths_with_obstacles(grid1.map(&:dup))
  puts 'Test 1: unique_paths_with_obstacles(grid1)'
  puts "結果: #{result1}"
  puts '期待値: 2'
  puts "判定: #{result1 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  grid2 = [[0, 1], [0, 0]]

  result2 = unique_paths_with_obstacles(grid2.map(&:dup))
  puts 'Test 2: unique_paths_with_obstacles(grid2)'
  puts "結果: #{result2}"
  puts '期待値: 1'
  puts "判定: #{result2 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  grid3 = [[1]]

  result3 = unique_paths_with_obstacles(grid3.map(&:dup))
  puts 'Test 3: unique_paths_with_obstacles(grid3)'
  puts "結果: #{result3}"
  puts '期待値: 0'
  puts "判定: #{result3 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
