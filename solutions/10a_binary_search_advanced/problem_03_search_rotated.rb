#!/usr/bin/env ruby
# frozen_string_literal: true

def search_rotated(nums, target)
  left = 0
  right = nums.length - 1

  while left <= right
    mid = (left + right) / 2

    return mid if nums[mid] == target

    if nums[left] <= nums[mid]
      if nums[left] <= target && target < nums[mid]
        right = mid - 1
      else
        left = mid + 1
      end
    elsif nums[mid] < target && target <= nums[right]
      left = mid + 1
    else
      right = mid - 1
    end
  end

  -1
end

def search_rotated_pivot(nums, target)
  pivot = find_pivot(nums)

  if target >= nums[0]
    binary_search(nums, 0, pivot - 1, target)
  else
    binary_search(nums, pivot, nums.length - 1, target)
  end
end

def find_pivot(nums)
  left = 0
  right = nums.length - 1

  while left < right
    mid = (left + right) / 2

    if nums[mid] > nums[right]
      left = mid + 1
    else
      right = mid
    end
  end

  left
end

def binary_search(nums, left, right, target)
  while left <= right
    mid = (left + right) / 2

    return mid if nums[mid] == target

    if nums[mid] < target
      left = mid + 1
    else
      right = mid - 1
    end
  end

  -1
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 回転ソート配列の検索 テスト ==='
  puts

  result1 = search_rotated([4, 5, 6, 7, 0, 1, 2], 0)
  puts 'Test 1: search_rotated([4, 5, 6, 7, 0, 1, 2], 0)'
  puts "結果: #{result1}"
  puts '期待値: 4'
  puts "判定: #{result1 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = search_rotated([4, 5, 6, 7, 0, 1, 2], 3)
  puts 'Test 2: search_rotated([4, 5, 6, 7, 0, 1, 2], 3)'
  puts "結果: #{result2}"
  puts '期待値: -1'
  puts "判定: #{result2 == -1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = search_rotated([1], 0)
  puts 'Test 3: search_rotated([1], 0)'
  puts "結果: #{result3}"
  puts '期待値: -1'
  puts "判定: #{result3 == -1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
