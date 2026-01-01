#!/usr/bin/env ruby
# frozen_string_literal: true

def find_corrupt_value(nums)
  nums.each do |num|
    idx = num.abs

    nums[idx] = -nums[idx].abs if idx < nums.length
  end

  nums.each_with_index do |num, i|
    return i if num > 0
  end

  nums.length
end

def find_corrupt_value_xor(nums)
  result = nums.length

  nums.each_with_index do |num, i|
    result ^= i ^ num
  end

  result
end

def find_corrupt_value_swap(nums)
  i = 0

  while i < nums.length
    correct_pos = nums[i]

    if correct_pos < nums.length && nums[i] != nums[correct_pos]
      nums[i], nums[correct_pos] = nums[correct_pos], nums[i]
    else
      i += 1
    end
  end

  nums.each_with_index do |num, i|
    return i if num != i
  end

  nums.length
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 配列内の正しくない数字 テスト ==='
  puts

  result1 = find_corrupt_value([0, 1, 3, 3].dup)
  puts 'Test 1: find_corrupt_value([0, 1, 3, 3])'
  puts "結果: #{result1}"
  puts '期待値: 2'
  puts "判定: #{result1 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = find_corrupt_value([1, 0, 2, 3].dup)
  puts 'Test 2: find_corrupt_value([1, 0, 2, 3])'
  puts "結果: #{result2}"
  puts '期待値: 4'
  puts "判定: #{result2 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = find_corrupt_value([0, 2, 2, 3].dup)
  puts 'Test 3: find_corrupt_value([0, 2, 2, 3])'
  puts "結果: #{result3}"
  puts '期待値: 1'
  puts "判定: #{result3 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = find_corrupt_value_xor([0, 1, 3, 3])
  puts "find_corrupt_value_xor([0, 1, 3, 3]) = #{result4}"
  puts "判定: #{result4 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = find_corrupt_value_swap([0, 1, 3, 3].dup)
  puts "find_corrupt_value_swap([0, 1, 3, 3]) = #{result5}"
  puts "判定: #{result5 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
