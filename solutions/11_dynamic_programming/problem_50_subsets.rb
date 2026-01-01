#!/usr/bin/env ruby
# frozen_string_literal: true

def subsets(nums)
  (0..nums.length).flat_map { |k| nums.combination(k).to_a }
end

def subsets_iterative(nums)
  result = [[]]

  nums.each do |num|
    new_subsets = result.map { |subset| subset + [num] }
    result.concat(new_subsets)
  end

  result
end

def subsets_backtrack(nums)
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

  (0...(1 << n)).each do |mask|
    subset = []

    (0...n).each do |i|
      subset << nums[i] if (mask & (1 << i)) != 0
    end

    result << subset
  end

  result
end

def subsets_recursive(nums)
  return [[]] if nums.empty?

  first = nums[0]
  rest = nums[1..]

  rest_subsets = subsets_recursive(rest)

  rest_subsets + rest_subsets.map { |s| [first] + s }
end

def subsets_with_dup(nums)
  nums.sort!
  result = [[]]
  start = 0

  nums.each_with_index do |num, i|
    start = result.length - (i > 0 && nums[i] == nums[i - 1] ? start : 0)

    new_subsets = result[start..].map { |subset| subset + [num] }
    start = result.length
    result.concat(new_subsets)
  end

  result
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 部分集合（Subsets） テスト ==='
  puts

  result1 = subsets([1, 2, 3])
  puts 'Test 1: subsets([1, 2, 3])'
  puts "結果の数: #{result1.length}"
  puts '期待値: 8個の部分集合'
  puts "判定: #{result1.length == 8 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = subsets_iterative([1, 2])
  puts 'Test 2: subsets_iterative([1, 2])'
  puts "結果: #{result2.map(&:sort).sort}"
  expected2 = [[], [1], [2], [1, 2]]
  puts "期待値: #{expected2.map(&:sort).sort}"
  puts "判定: #{result2.map(&:sort).sort == expected2.map(&:sort).sort ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = subsets_bit([1, 2, 3])
  puts 'Test 3: subsets_bit([1, 2, 3])'
  puts "結果の数: #{result3.length}"
  puts '期待値: 8個の部分集合'
  puts "判定: #{result3.length == 8 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = subsets([])
  puts 'Test 4: subsets([])'
  puts "結果: #{result4}"
  puts '期待値: [[]]'
  puts "判定: #{result4 == [[]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = subsets_with_dup([1, 2, 2])
  puts 'Test 5: subsets_with_dup([1, 2, 2])'
  puts "結果の数: #{result5.length}"
  puts '期待値: 6個の部分集合'
  puts "判定: #{result5.length == 6 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
