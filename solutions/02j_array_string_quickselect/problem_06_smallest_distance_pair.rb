#!/usr/bin/env ruby
# frozen_string_literal: true

def smallest_distance_pair(nums, k)
  nums.sort!

  left = 0
  right = nums[-1] - nums[0]

  while left < right
    mid = (left + right) / 2

    count = count_pairs_with_distance_le(nums, mid)

    if count >= k
      right = mid
    else
      left = mid + 1
    end
  end

  left
end

def count_pairs_with_distance_le(nums, distance)
  count = 0
  left = 0

  nums.each_with_index do |num, right|
    left += 1 while nums[right] - nums[left] > distance

    count += right - left
  end

  count
end

def smallest_distance_pair_quickselect(nums, k)
  distances = []

  nums.length.times do |i|
    ((i + 1)...nums.length).each do |j|
      distances << (nums[i] - nums[j]).abs
    end
  end

  quickselect_simple(distances, k - 1)
end

def quickselect_simple(arr, k)
  left = 0
  right = arr.length - 1

  loop do
    pivot_idx = partition_simple(arr, left, right)

    if pivot_idx == k
      return arr[k]
    elsif pivot_idx > k
      right = pivot_idx - 1
    else
      left = pivot_idx + 1
    end
  end
end

def partition_simple(arr, left, right)
  pivot_idx = rand(left..right)
  arr[pivot_idx], arr[right] = arr[right], arr[pivot_idx]

  pivot = arr[right]
  i = left

  (left...right).each do |j|
    if arr[j] < pivot
      arr[i], arr[j] = arr[j], arr[i]
      i += 1
    end
  end

  arr[i], arr[right] = arr[right], arr[i]
  i
end

if __FILE__ == $PROGRAM_NAME
  puts '=== k番目に小さいペアの距離 テスト ==='
  puts

  result1 = smallest_distance_pair([1, 3, 1], 1)
  puts 'Test 1: smallest_distance_pair([1, 3, 1], 1)'
  puts "結果: #{result1}"
  puts '期待値: 0'
  puts "判定: #{result1 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = smallest_distance_pair([1, 1, 1], 2)
  puts 'Test 2: smallest_distance_pair([1, 1, 1], 2)'
  puts "結果: #{result2}"
  puts '期待値: 0'
  puts "判定: #{result2 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = smallest_distance_pair([1, 6, 1], 3)
  puts 'Test 3: smallest_distance_pair([1, 6, 1], 3)'
  puts "結果: #{result3}"
  puts '期待値: 5'
  puts "判定: #{result3 == 5 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = smallest_distance_pair_quickselect([1, 3, 1], 1)
  puts "smallest_distance_pair_quickselect([1, 3, 1], 1) = #{result4}"
  puts "判定: #{result4 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
