#!/usr/bin/env ruby
# frozen_string_literal: true

def find_difference(nums1, nums2)
  set1 = nums1.to_set
  set2 = nums2.to_set

  [
    (set1 - set2).to_a,
    (set2 - set1).to_a
  ]
end

def find_difference_array(nums1, nums2)
  [
    (nums1 - nums2).uniq,
    (nums2 - nums1).uniq
  ]
end

def find_difference_select(nums1, nums2)
  set1 = nums1.to_set
  set2 = nums2.to_set

  [
    nums1.uniq.reject { |n| set2.include?(n) },
    nums2.uniq.reject { |n| set1.include?(n) }
  ]
end

def find_difference_manual(nums1, nums2)
  in_nums1 = {}
  in_nums2 = {}

  nums1.each { |n| in_nums1[n] = true }
  nums2.each { |n| in_nums2[n] = true }

  diff1 = []
  diff2 = []

  in_nums1.each_key { |n| diff1 << n unless in_nums2[n] }
  in_nums2.each_key { |n| diff2 << n unless in_nums1[n] }

  [diff1, diff2]
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 配列の差分 テスト ==='
  puts

  result1 = find_difference([1, 2, 3], [2, 4, 6])
  puts 'Test 1: find_difference([1, 2, 3], [2, 4, 6])'
  puts "結果: #{result1.map(&:sort)}"
  expected1 = [[1, 3], [4, 6]]
  puts "期待値: #{expected1}"
  puts "判定: #{result1.map(&:sort).sort == expected1.map(&:sort).sort ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = find_difference([1, 2, 3, 3], [1, 1, 2, 2])
  puts 'Test 2: find_difference([1, 2, 3, 3], [1, 1, 2, 2])'
  puts "結果: #{result2}"
  puts '期待値: [[3], []]'
  puts "判定: #{result2 == [[3], []] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = find_difference([], [1, 2])
  puts 'Test 3: find_difference([], [1, 2])'
  puts "結果: #{result3.map(&:sort)}"
  puts '期待値: [[], [1, 2]]'
  puts "判定: #{result3.map(&:sort) == [[], [1, 2]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
