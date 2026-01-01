#!/usr/bin/env ruby
# frozen_string_literal: true

def contains_nearby_duplicate(nums, k)
  last_index = {}

  nums.each_with_index do |num, index|
    return true if last_index.key?(num) && index - last_index[num] <= k

    last_index[num] = index
  end

  false
end

def contains_nearby_duplicate_window(nums, k)
  window = Set.new

  nums.each_with_index do |num, index|
    window.delete(nums[index - k - 1]) if index > k

    return true unless window.add?(num)
  end

  false
end

def contains_nearby_duplicate_all_indices(nums, k)
  indices = Hash.new { |h, key| h[key] = [] }

  nums.each_with_index { |num, i| indices[num] << i }

  indices.values.any? do |idx_list|
    idx_list.each_cons(2).any? { |i, j| j - i <= k }
  end
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 近くの重複要素（Contains Nearby Duplicate） テスト ==='
  puts

  result1 = contains_nearby_duplicate([1, 2, 3, 1], 3)
  puts 'Test 1: contains_nearby_duplicate([1, 2, 3, 1], 3)'
  puts "結果: #{result1}"
  puts '期待値: true'
  puts "判定: #{result1 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = contains_nearby_duplicate([1, 0, 1, 1], 1)
  puts 'Test 2: contains_nearby_duplicate([1, 0, 1, 1], 1)'
  puts "結果: #{result2}"
  puts '期待値: true'
  puts "判定: #{result2 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = contains_nearby_duplicate([1, 2, 3, 1, 2, 3], 2)
  puts 'Test 3: contains_nearby_duplicate([1, 2, 3, 1, 2, 3], 2)'
  puts "結果: #{result3}"
  puts '期待値: false'
  puts "判定: #{result3 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = contains_nearby_duplicate([], 0)
  puts 'Test 4: contains_nearby_duplicate([], 0)'
  puts "結果: #{result4}"
  puts '期待値: false'
  puts "判定: #{result4 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = contains_nearby_duplicate([1], 1)
  puts 'Test 5: contains_nearby_duplicate([1], 1)'
  puts "結果: #{result5}"
  puts '期待値: false'
  puts "判定: #{result5 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
