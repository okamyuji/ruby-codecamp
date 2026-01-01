#!/usr/bin/env ruby
# frozen_string_literal: true

def split_array(nums, m)
  left = nums.max
  right = nums.sum

  while left < right
    mid = (left + right) / 2

    if can_split(nums, m, mid)
      right = mid
    else
      left = mid + 1
    end
  end

  left
end

def can_split(nums, m, max_sum)
  subarrays = 1
  current_sum = 0

  nums.each do |num|
    if current_sum + num > max_sum
      subarrays += 1
      current_sum = num

      return false if subarrays > m
    else
      current_sum += num
    end
  end

  true
end

def split_array_dp(nums, m)
  n = nums.length

  dp = Array.new(n + 1) { Array.new(m + 1, Float::INFINITY) }

  prefix_sum = [0]
  nums.each { |num| prefix_sum << prefix_sum.last + num }

  dp[0][0] = 0

  (1..n).each do |i|
    (1..[i, m].min).each do |j|
      ((j - 1)...i).each do |k|
        subarray_sum = prefix_sum[i] - prefix_sum[k]
        dp[i][j] = [dp[i][j], [dp[k][j - 1], subarray_sum].max].min
      end
    end
  end

  dp[n][m]
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 最小の分割数（答えの二分探索） テスト ==='
  puts

  result1 = split_array([7, 2, 5, 10, 8], 2)
  puts 'Test 1: split_array([7, 2, 5, 10, 8], 2)'
  puts "結果: #{result1}"
  puts '期待値: 18'
  puts "判定: #{result1 == 18 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = split_array([1, 2, 3, 4, 5], 2)
  puts 'Test 2: split_array([1, 2, 3, 4, 5], 2)'
  puts "結果: #{result2}"
  puts '期待値: 9'
  puts "判定: #{result2 == 9 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = split_array([1, 4, 4], 3)
  puts 'Test 3: split_array([1, 4, 4], 3)'
  puts "結果: #{result3}"
  puts '期待値: 4'
  puts "判定: #{result3 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
