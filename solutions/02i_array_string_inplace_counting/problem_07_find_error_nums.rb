#!/usr/bin/env ruby
# frozen_string_literal: true

def find_error_nums(nums)
  duplicate = 0

  nums.each do |num|
    idx = num.abs - 1

    if nums[idx] < 0
      duplicate = num.abs
    else
      nums[idx] = -nums[idx]
    end
  end

  missing = 0
  nums.each_with_index do |num, i|
    if num > 0
      missing = i + 1
      break
    end
  end

  [duplicate, missing]
end

def find_error_nums_math(nums)
  n = nums.length

  actual_sum = nums.sum
  expected_sum = n * (n + 1) / 2

  duplicate = 0
  seen = Set.new

  nums.each do |num|
    duplicate = num if seen.include?(num)
    seen << num
  end

  missing = expected_sum - (actual_sum - duplicate)

  [duplicate, missing]
end

def find_error_nums_hash(nums)
  freq = Hash.new(0)
  nums.each { |num| freq[num] += 1 }

  duplicate = freq.find { |_k, v| v == 2 }[0]
  missing = (1..nums.length).find { |num| !freq.key?(num) }

  [duplicate, missing]
end

if __FILE__ == $PROGRAM_NAME
  puts '=== セットの不一致 テスト ==='
  puts

  result1 = find_error_nums([1, 2, 2, 4].dup)
  puts 'Test 1: find_error_nums([1, 2, 2, 4])'
  puts "結果: #{result1}"
  puts '期待値: [2, 3]'
  puts "判定: #{result1 == [2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = find_error_nums([1, 1].dup)
  puts 'Test 2: find_error_nums([1, 1])'
  puts "結果: #{result2}"
  puts '期待値: [1, 2]'
  puts "判定: #{result2 == [1, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = find_error_nums_math([1, 2, 2, 4])
  puts "find_error_nums_math([1, 2, 2, 4]) = #{result3}"
  puts "判定: #{result3 == [2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = find_error_nums_hash([1, 2, 2, 4])
  puts "find_error_nums_hash([1, 2, 2, 4]) = #{result4}"
  puts "判定: #{result4 == [2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
