#!/usr/bin/env ruby
# frozen_string_literal: true

def longest_ones(nums, k)
  left = 0
  zero_count = 0
  max_len = 0

  nums.each_with_index do |num, right|
    zero_count += 1 if num.zero?

    while zero_count > k
      zero_count -= 1 if nums[left].zero?
      left += 1
    end

    max_len = [max_len, right - left + 1].max
  end

  max_len
end

def longest_ones_with_indices(nums, k)
  left = 0
  zero_count = 0
  max_len = 0
  max_start = 0

  nums.each_with_index do |num, right|
    zero_count += 1 if num.zero?

    while zero_count > k
      zero_count -= 1 if nums[left].zero?
      left += 1
    end

    if right - left + 1 > max_len
      max_len = right - left + 1
      max_start = left
    end
  end

  { length: max_len, start: max_start, end: max_start + max_len - 1 }
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 最大連続1（k回の反転許可） テスト ==='
  puts

  result1 = longest_ones([1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0], 2)
  puts 'Test 1: longest_ones([1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0], 2)'
  puts "結果: #{result1}"
  puts '期待値: 6'
  puts "判定: #{result1 == 6 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = longest_ones([0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1], 3)
  puts 'Test 2: longest_ones([0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1], 3)'
  puts "結果: #{result2}"
  puts '期待値: 10'
  puts "判定: #{result2 == 10 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = longest_ones_with_indices([1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0], 2)
  puts "longest_ones_with_indices([1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0], 2) = #{result3}"
  puts "判定: #{result3[:length] == 6 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
