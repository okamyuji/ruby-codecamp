#!/usr/bin/env ruby
# frozen_string_literal: true

def max_subarray(nums)
  return nums[0] if nums.length == 1

  current_max = nums[0]
  global_max = nums[0]

  nums[1..].each do |num|
    current_max = [num, current_max + num].max
    global_max = [global_max, current_max].max
  end

  global_max
end

def max_subarray_dp(nums)
  n = nums.length
  dp = Array.new(n)
  dp[0] = nums[0]

  (1...n).each do |i|
    dp[i] = [nums[i], dp[i - 1] + nums[i]].max
  end

  dp.max
end

def max_subarray_divide(nums)
  divide_and_conquer(nums, 0, nums.length - 1)
end

def divide_and_conquer(nums, left, right)
  return nums[left] if left == right

  mid = (left + right) / 2

  left_max = divide_and_conquer(nums, left, mid)
  right_max = divide_and_conquer(nums, mid + 1, right)
  cross_max = max_crossing_sum(nums, left, mid, right)

  [left_max, right_max, cross_max].max
end

def max_crossing_sum(nums, left, mid, right)
  left_sum = -Float::INFINITY
  sum = 0
  mid.downto(left) do |i|
    sum += nums[i]
    left_sum = sum if sum > left_sum
  end

  right_sum = -Float::INFINITY
  sum = 0
  ((mid + 1)..right).each do |i|
    sum += nums[i]
    right_sum = sum if sum > right_sum
  end

  left_sum + right_sum
end

def max_subarray_with_indices(nums)
  current_max = nums[0]
  global_max = nums[0]
  start_idx = 0
  end_idx = 0
  temp_start = 0

  nums.each_with_index do |num, i|
    next if i == 0

    if num > current_max + num
      current_max = num
      temp_start = i
    else
      current_max += num
    end

    next unless current_max > global_max

    global_max = current_max
    start_idx = temp_start
    end_idx = i
  end

  {
    sum: global_max,
    subarray: nums[start_idx..end_idx]
  }
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 最大部分配列和（Maximum Subarray） テスト ==='
  puts

  result1 = max_subarray([-2, 1, -3, 4, -1, 2, 1, -5, 4])
  puts 'Test 1: max_subarray([-2, 1, -3, 4, -1, 2, 1, -5, 4])'
  puts "結果: #{result1}"
  puts '期待値: 6'
  puts "判定: #{result1 == 6 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = max_subarray([1])
  puts 'Test 2: max_subarray([1])'
  puts "結果: #{result2}"
  puts '期待値: 1'
  puts "判定: #{result2 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = max_subarray([5, 4, -1, 7, 8])
  puts 'Test 3: max_subarray([5, 4, -1, 7, 8])'
  puts "結果: #{result3}"
  puts '期待値: 23'
  puts "判定: #{result3 == 23 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = max_subarray([-1])
  puts 'Test 4: max_subarray([-1])'
  puts "結果: #{result4}"
  puts '期待値: -1'
  puts "判定: #{result4 == -1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = max_subarray([-2, -1])
  puts 'Test 5: max_subarray([-2, -1])'
  puts "結果: #{result5}"
  puts '期待値: -1'
  puts "判定: #{result5 == -1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result6 = max_subarray_with_indices([-2, 1, -3, 4, -1, 2, 1, -5, 4])
  puts "max_subarray_with_indices([-2, 1, -3, 4, -1, 2, 1, -5, 4]) = #{result6}"
  puts "判定: #{result6[:sum] == 6 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
