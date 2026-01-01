#!/usr/bin/env ruby
# frozen_string_literal: true

def upper_bound(nums, target)
  left = 0
  right = nums.length

  while left < right
    mid = (left + right) / 2

    if nums[mid] <= target
      left = mid + 1
    else
      right = mid
    end
  end

  left
end

def upper_bound_builtin(nums, target)
  nums.bsearch_index { |x| x > target } || nums.length
end

def upper_bound_explicit(nums, target)
  left = 0
  right = nums.length - 1
  result = nums.length

  while left <= right
    mid = (left + right) / 2

    if nums[mid] > target
      result = mid
      right = mid - 1
    else
      left = mid + 1
    end
  end

  result
end

def upper_bound_from_lower(nums, target)
  lower_bound(nums, target + 1)
end

def lower_bound(nums, target)
  left = 0
  right = nums.length

  while left < right
    mid = (left + right) / 2

    if nums[mid] < target
      left = mid + 1
    else
      right = mid
    end
  end

  left
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 上界（Upper Bound）の実装 テスト ==='
  puts

  result1 = upper_bound([1, 2, 4, 4, 5, 6], 4)
  puts 'Test 1: upper_bound([1, 2, 4, 4, 5, 6], 4)'
  puts "結果: #{result1}"
  puts '期待値: 4'
  puts "判定: #{result1 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = upper_bound([1, 2, 4, 4, 5, 6], 3)
  puts 'Test 2: upper_bound([1, 2, 4, 4, 5, 6], 3)'
  puts "結果: #{result2}"
  puts '期待値: 2'
  puts "判定: #{result2 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = upper_bound([1, 2, 4, 4, 5, 6], 7)
  puts 'Test 3: upper_bound([1, 2, 4, 4, 5, 6], 7)'
  puts "結果: #{result3}"
  puts '期待値: 6'
  puts "判定: #{result3 == 6 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = upper_bound([1, 2, 4, 4, 5, 6], 0)
  puts 'Test 4: upper_bound([1, 2, 4, 4, 5, 6], 0)'
  puts "結果: #{result4}"
  puts '期待値: 0'
  puts "判定: #{result4 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
