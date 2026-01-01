#!/usr/bin/env ruby
# frozen_string_literal: true

def arrange_numbers(nums)
  i = 0

  while i < nums.length
    correct_pos = nums[i]

    if nums[i] != i && nums[i] != nums[correct_pos]
      nums[i], nums[correct_pos] = nums[correct_pos], nums[i]
    else
      i += 1
    end
  end

  nums
end

def arrange_numbers_one_pass(nums)
  nums.each_index do |i|
    while nums[i] != i && nums[i] != nums[nums[i]]
      correct_pos = nums[i]
      nums[i], nums[correct_pos] = nums[correct_pos], nums[i]
    end
  end

  nums
end

def arrange_numbers_new_array(nums)
  result = Array.new(nums.length)

  nums.each_with_index do |num, _i|
    result[num] = num
  end

  result
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 配列の要素を正しい位置に配置 テスト ==='
  puts

  result1 = arrange_numbers([4, 0, 2, 1, 3].dup)
  puts 'Test 1: arrange_numbers([4, 0, 2, 1, 3])'
  puts "結果: #{result1}"
  puts '期待値: [0, 1, 2, 3, 4]'
  puts "判定: #{result1 == [0, 1, 2, 3, 4] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = arrange_numbers([3, 1, 0, 2].dup)
  puts 'Test 2: arrange_numbers([3, 1, 0, 2])'
  puts "結果: #{result2}"
  puts '期待値: [0, 1, 2, 3]'
  puts "判定: #{result2 == [0, 1, 2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = arrange_numbers([0, 1, 2].dup)
  puts 'Test 3: arrange_numbers([0, 1, 2])'
  puts "結果: #{result3}"
  puts '期待値: [0, 1, 2]'
  puts "判定: #{result3 == [0, 1, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = arrange_numbers_one_pass([4, 0, 2, 1, 3].dup)
  puts "arrange_numbers_one_pass([4, 0, 2, 1, 3]) = #{result4}"
  puts "判定: #{result4 == [0, 1, 2, 3, 4] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = arrange_numbers_new_array([4, 0, 2, 1, 3])
  puts "arrange_numbers_new_array([4, 0, 2, 1, 3]) = #{result5}"
  puts "判定: #{result5 == [0, 1, 2, 3, 4] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
