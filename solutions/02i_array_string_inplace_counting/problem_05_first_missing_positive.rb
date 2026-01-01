#!/usr/bin/env ruby
# frozen_string_literal: true

def first_missing_positive(nums)
  n = nums.length

  nums.map! { |num| num <= 0 || num > n ? n + 1 : num }

  nums.each do |num|
    val = num.abs

    nums[val - 1] = -nums[val - 1].abs if val <= n
  end

  nums.each_with_index do |num, i|
    return i + 1 if num > 0
  end

  n + 1
end

def first_missing_positive_sort(nums)
  n = nums.length
  i = 0

  while i < n
    correct_pos = nums[i] - 1

    if nums[i] > 0 && nums[i] <= n && nums[i] != nums[correct_pos]
      nums[i], nums[correct_pos] = nums[correct_pos], nums[i]
    else
      i += 1
    end
  end

  nums.each_with_index do |num, i|
    return i + 1 if num != i + 1
  end

  n + 1
end

def first_missing_positive_set(nums)
  present = Set.new(nums)

  i = 1
  i += 1 while present.include?(i)

  i
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 最初の消えた正の整数 テスト ==='
  puts

  result1 = first_missing_positive([1, 2, 0].dup)
  puts 'Test 1: first_missing_positive([1, 2, 0])'
  puts "結果: #{result1}"
  puts '期待値: 3'
  puts "判定: #{result1 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = first_missing_positive([3, 4, -1, 1].dup)
  puts 'Test 2: first_missing_positive([3, 4, -1, 1])'
  puts "結果: #{result2}"
  puts '期待値: 2'
  puts "判定: #{result2 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = first_missing_positive([7, 8, 9, 11, 12].dup)
  puts 'Test 3: first_missing_positive([7, 8, 9, 11, 12])'
  puts "結果: #{result3}"
  puts '期待値: 1'
  puts "判定: #{result3 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = first_missing_positive([1].dup)
  puts 'Test 4: first_missing_positive([1])'
  puts "結果: #{result4}"
  puts '期待値: 2'
  puts "判定: #{result4 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = first_missing_positive_sort([3, 4, -1, 1].dup)
  puts "first_missing_positive_sort([3, 4, -1, 1]) = #{result5}"
  puts "判定: #{result5 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result6 = first_missing_positive_set([3, 4, -1, 1])
  puts "first_missing_positive_set([3, 4, -1, 1]) = #{result6}"
  puts "判定: #{result6 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
