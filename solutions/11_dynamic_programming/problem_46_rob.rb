#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin rob
# 解法1: 動的計画法（空間最適化、推奨）
def rob(nums)
  return 0 if nums.empty?
  return nums[0] if nums.length == 1

  # prev_prev: 2つ前までの最大金額
  # prev: 1つ前までの最大金額
  prev_prev = nums[0]
  prev = [nums[0], nums[1]].max

  nums[2..].each do |num|
    # この家を盗む場合と盗まない場合の最大
    current = [prev, prev_prev + num].max
    prev_prev = prev
    prev = current
  end

  prev
end

# 解法2: 動的計画法（配列使用）
def rob_dp(nums)
  return 0 if nums.empty?
  return nums[0] if nums.length == 1

  n = nums.length
  # dp[i]はi番目までの家での最大金額
  dp = Array.new(n)
  dp[0] = nums[0]
  dp[1] = [nums[0], nums[1]].max

  (2...n).each do |i|
    dp[i] = [dp[i - 1], dp[i - 2] + nums[i]].max
  end

  dp[n - 1]
end

# 解法3: メモ化再帰
def rob_memo(nums, i = nil, memo = {})
  i ||= nums.length - 1

  return 0 if i < 0
  return nums[0] if i == 0
  return memo[i] if memo.key?(i)

  # この家を盗むか盗まないか
  memo[i] = [
    rob_memo(nums, i - 1, memo),           # 盗まない
    rob_memo(nums, i - 2, memo) + nums[i]  # 盗む
  ].max
end

# 解法4: どの家を盗んだかも返す
def rob_with_houses(nums)
  return { amount: 0, houses: [] } if nums.empty?
  return { amount: nums[0], houses: [0] } if nums.length == 1

  n = nums.length
  dp = Array.new(n)
  houses = Array.new(n) { [] }

  dp[0] = nums[0]
  houses[0] = [0]

  if nums[1] > nums[0]
    dp[1] = nums[1]
    houses[1] = [1]
  else
    dp[1] = nums[0]
    houses[1] = [0]
  end

  (2...n).each do |i|
    if dp[i - 2] + nums[i] > dp[i - 1]
      dp[i] = dp[i - 2] + nums[i]
      houses[i] = houses[i - 2] + [i]
    else
      dp[i] = dp[i - 1]
      houses[i] = houses[i - 1]
    end
  end

  { amount: dp[n - 1], houses: houses[n - 1] }
end

# テストケース
puts rob([2, 7, 9, 3, 1])   # => 12
puts rob([1, 2, 3, 1])      # => 4
puts rob([1])               # => 1
puts rob([])                # => 0
puts rob([2, 1, 1, 2])      # => 4

p rob_with_houses([2, 7, 9, 3, 1])
# => {amount: 12, houses: [0, 2, 4]}
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 家の盗み（House Robber） テスト ==='
  puts

  result1 = rob([2, 7, 9, 3, 1])
  puts 'Test 1: rob([2, 7, 9, 3, 1])'
  puts "結果: #{result1}"
  puts '期待値: 12'
  puts "判定: #{result1 == 12 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = rob([1, 2, 3, 1])
  puts 'Test 2: rob([1, 2, 3, 1])'
  puts "結果: #{result2}"
  puts '期待値: 4'
  puts "判定: #{result2 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = rob([1])
  puts 'Test 3: rob([1])'
  puts "結果: #{result3}"
  puts '期待値: 1'
  puts "判定: #{result3 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = rob([])
  puts 'Test 4: rob([])'
  puts "結果: #{result4}"
  puts '期待値: 0'
  puts "判定: #{result4 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = rob([2, 1, 1, 2])
  puts 'Test 5: rob([2, 1, 1, 2])'
  puts "結果: #{result5}"
  puts '期待値: 4'
  puts "判定: #{result5 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result6 = rob_with_houses([2, 7, 9, 3, 1])
  puts "rob_with_houses([2, 7, 9, 3, 1]) = #{result6}"
  puts "判定: #{result6[:amount] == 12 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
