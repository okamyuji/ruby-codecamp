#!/usr/bin/env ruby
# frozen_string_literal: true

def rob(nums)
  return 0 if nums.empty?
  return nums[0] if nums.length == 1

  prev_prev = nums[0]
  prev = [nums[0], nums[1]].max

  nums[2..].each do |num|
    current = [prev, prev_prev + num].max
    prev_prev = prev
    prev = current
  end

  prev
end

def rob_dp(nums)
  return 0 if nums.empty?
  return nums[0] if nums.length == 1

  n = nums.length
  dp = Array.new(n)
  dp[0] = nums[0]
  dp[1] = [nums[0], nums[1]].max

  (2...n).each do |i|
    dp[i] = [dp[i - 1], dp[i - 2] + nums[i]].max
  end

  dp[n - 1]
end

def rob_memo(nums, i = nil, memo = {})
  i ||= nums.length - 1

  return 0 if i < 0
  return nums[0] if i == 0
  return memo[i] if memo.key?(i)

  memo[i] = [
    rob_memo(nums, i - 1, memo),
    rob_memo(nums, i - 2, memo) + nums[i]
  ].max
end

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
