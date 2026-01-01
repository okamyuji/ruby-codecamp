#!/usr/bin/env ruby
# frozen_string_literal: true

def find_duplicate(nums)
  slow = nums[0]
  fast = nums[0]

  loop do
    slow = nums[slow]
    fast = nums[nums[fast]]
    break if slow == fast
  end

  slow = nums[0]

  while slow != fast
    slow = nums[slow]
    fast = nums[fast]
  end

  fast
end

def find_duplicate_marking(nums)
  nums.each do |num|
    idx = num.abs

    return idx if nums[idx] < 0

    nums[idx] = -nums[idx]
  end

  -1
end

def find_duplicate_binary_search(nums)
  left = 1
  right = nums.length - 1

  while left < right
    mid = (left + right) / 2

    count = nums.count { |num| num <= mid }

    if count > mid
      right = mid
    else
      left = mid + 1
    end
  end

  left
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 重複する数字を見つける テスト ==='
  puts

  result1 = find_duplicate([1, 3, 4, 2, 2])
  puts 'Test 1: find_duplicate([1, 3, 4, 2, 2])'
  puts "結果: #{result1}"
  puts '期待値: 2'
  puts "判定: #{result1 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = find_duplicate([3, 1, 3, 4, 2])
  puts 'Test 2: find_duplicate([3, 1, 3, 4, 2])'
  puts "結果: #{result2}"
  puts '期待値: 3'
  puts "判定: #{result2 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = find_duplicate([1, 1])
  puts 'Test 3: find_duplicate([1, 1])'
  puts "結果: #{result3}"
  puts '期待値: 1'
  puts "判定: #{result3 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = find_duplicate([1, 1, 2])
  puts 'Test 4: find_duplicate([1, 1, 2])'
  puts "結果: #{result4}"
  puts '期待値: 1'
  puts "判定: #{result4 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = find_duplicate_marking([1, 3, 4, 2, 2].dup)
  puts "find_duplicate_marking([1, 3, 4, 2, 2]) = #{result5}"
  puts "判定: #{result5 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result6 = find_duplicate_binary_search([1, 3, 4, 2, 2])
  puts "find_duplicate_binary_search([1, 3, 4, 2, 2]) = #{result6}"
  puts "判定: #{result6 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
