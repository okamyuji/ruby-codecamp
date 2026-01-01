#!/usr/bin/env ruby
# frozen_string_literal: true

def find_disappeared_numbers(nums)
  nums.each do |num|
    idx = num.abs - 1
    nums[idx] = -nums[idx].abs
  end

  disappeared = []

  nums.each_with_index do |num, i|
    disappeared << i + 1 if num > 0
  end

  disappeared
end

def find_disappeared_numbers_restore(nums)
  nums.each do |num|
    idx = num.abs - 1
    nums[idx] = -nums[idx].abs
  end

  disappeared = []

  nums.each_with_index do |num, i|
    disappeared << i + 1 if num > 0
  end

  nums.map! { |num| num.abs }

  disappeared
end

def find_disappeared_numbers_set(nums)
  present = Set.new(nums)

  (1..nums.length).reject { |num| present.include?(num) }
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 消えたすべての数字を見つける テスト ==='
  puts

  result1 = find_disappeared_numbers([4, 3, 2, 7, 8, 2, 3, 1].dup)
  puts 'Test 1: find_disappeared_numbers([4, 3, 2, 7, 8, 2, 3, 1])'
  puts "結果: #{result1}"
  puts '期待値: [5, 6]'
  puts "判定: #{result1 == [5, 6] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = find_disappeared_numbers([1, 1].dup)
  puts 'Test 2: find_disappeared_numbers([1, 1])'
  puts "結果: #{result2}"
  puts '期待値: [2]'
  puts "判定: #{result2 == [2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = find_disappeared_numbers([1, 2, 3].dup)
  puts 'Test 3: find_disappeared_numbers([1, 2, 3])'
  puts "結果: #{result3}"
  puts '期待値: []'
  puts "判定: #{result3 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = find_disappeared_numbers_restore([4, 3, 2, 7, 8, 2, 3, 1].dup)
  puts "find_disappeared_numbers_restore([4, 3, 2, 7, 8, 2, 3, 1]) = #{result4}"
  puts "判定: #{result4 == [5, 6] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = find_disappeared_numbers_set([4, 3, 2, 7, 8, 2, 3, 1])
  puts "find_disappeared_numbers_set([4, 3, 2, 7, 8, 2, 3, 1]) = #{result5}"
  puts "判定: #{result5 == [5, 6] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
