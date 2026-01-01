#!/usr/bin/env ruby
# frozen_string_literal: true

def search_insert(nums, target)
  left = 0
  right = nums.length

  while left < right
    mid = left + (right - left) / 2

    if nums[mid] < target
      left = mid + 1
    else
      right = mid
    end
  end

  left
end

def search_insert_builtin(nums, target)
  nums.bsearch_index { |x| x >= target } || nums.length
end

def search_insert_linear(nums, target)
  nums.each_with_index do |num, i|
    return i if num >= target
  end
  nums.length
end

def search_insert_with_found(nums, target)
  left = 0
  right = nums.length - 1

  while left <= right
    mid = left + (right - left) / 2

    if nums[mid] == target
      return { index: mid, found: true }
    elsif nums[mid] < target
      left = mid + 1
    else
      right = mid - 1
    end
  end

  { index: left, found: false }
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 挿入位置の検索 テスト ==='
  puts

  result1 = search_insert([1, 3, 5, 6], 5)
  puts 'Test 1: search_insert([1, 3, 5, 6], 5)'
  puts "結果: #{result1}"
  puts '期待値: 2'
  puts "判定: #{result1 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = search_insert([1, 3, 5, 6], 2)
  puts 'Test 2: search_insert([1, 3, 5, 6], 2)'
  puts "結果: #{result2}"
  puts '期待値: 1'
  puts "判定: #{result2 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = search_insert([1, 3, 5, 6], 7)
  puts 'Test 3: search_insert([1, 3, 5, 6], 7)'
  puts "結果: #{result3}"
  puts '期待値: 4'
  puts "判定: #{result3 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = search_insert([1, 3, 5, 6], 0)
  puts 'Test 4: search_insert([1, 3, 5, 6], 0)'
  puts "結果: #{result4}"
  puts '期待値: 0'
  puts "判定: #{result4 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = search_insert([], 1)
  puts 'Test 5: search_insert([], 1)'
  puts "結果: #{result5}"
  puts '期待値: 0'
  puts "判定: #{result5 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
