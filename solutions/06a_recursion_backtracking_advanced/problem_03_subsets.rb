#!/usr/bin/env ruby
# frozen_string_literal: true

def subsets(nums)
  result = []
  backtrack_subsets(nums, 0, [], result)
  result
end

def backtrack_subsets(nums, start, current, result)
  result << current.dup

  (start...nums.length).each do |i|
    current << nums[i]
    backtrack_subsets(nums, i + 1, current, result)
    current.pop
  end
end

def subsets_bit(nums)
  n = nums.length
  result = []

  (0...(2**n)).each do |mask|
    subset = []

    n.times do |i|
      subset << nums[i] if (mask >> i) & 1 == 1
    end

    result << subset
  end

  result
end

def subsets_iterative(nums)
  result = [[]]

  nums.each do |num|
    new_subsets = result.map { |subset| subset + [num] }
    result.concat(new_subsets)
  end

  result
end

def subsets_recursive(nums)
  return [[]] if nums.empty?

  first = nums[0]
  rest_subsets = subsets_recursive(nums[1..])

  rest_subsets + rest_subsets.map { |subset| [first] + subset }
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 部分集合の生成 テスト ==='
  puts

  result1 = subsets([1, 2, 3])
  puts 'Test 1: subsets([1, 2, 3])'
  puts "結果の数: #{result1.length}"
  puts '期待値: 8個の部分集合'
  puts "判定: #{result1.length == 8 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = subsets([0])
  puts 'Test 2: subsets([0])'
  puts "結果: #{result2.sort}"
  puts '期待値: [[], [0]]'
  puts "判定: #{result2.sort == [[], [0]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = subsets([])
  puts 'Test 3: subsets([])'
  puts "結果: #{result3}"
  puts '期待値: [[]]'
  puts "判定: #{result3 == [[]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
