#!/usr/bin/env ruby
# frozen_string_literal: true

def intersection(nums1, nums2)
  set1 = nums1.to_set
  set2 = nums2.to_set

  (set1 & set2).to_a
end

def intersection_array(nums1, nums2)
  nums1 & nums2
end

def intersection_select(nums1, nums2)
  set2 = nums2.to_set

  nums1.uniq.select { |num| set2.include?(num) }
end

def intersection_manual(nums1, nums2)
  set1 = {}
  result = []

  nums1.each { |num| set1[num] = true }

  seen = {}
  nums2.each do |num|
    if set1[num] && !seen[num]
      result << num
      seen[num] = true
    end
  end

  result
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 2つの配列の共通要素 テスト ==='
  puts

  result1 = intersection([1, 2, 2, 1], [2, 2])
  puts 'Test 1: intersection([1, 2, 2, 1], [2, 2])'
  puts "結果: #{result1}"
  puts '期待値: [2]'
  puts "判定: #{result1 == [2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = intersection([4, 9, 5], [9, 4, 9, 8, 4])
  puts 'Test 2: intersection([4, 9, 5], [9, 4, 9, 8, 4])'
  puts "結果: #{result2.sort}"
  puts '期待値: [4, 9]'
  puts "判定: #{result2.sort == [4, 9] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = intersection([1, 2, 3], [4, 5, 6])
  puts 'Test 3: intersection([1, 2, 3], [4, 5, 6])'
  puts "結果: #{result3}"
  puts '期待値: []'
  puts "判定: #{result3 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = intersection([], [1, 2])
  puts 'Test 4: intersection([], [1, 2])'
  puts "結果: #{result4}"
  puts '期待値: []'
  puts "判定: #{result4 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = intersection([1, 1, 1], [1, 1, 1])
  puts 'Test 1: intersection([1, 1, 1], [1, 1, 1])'
  puts "結果: #{result5}"
  puts '期待値: [1]'
  puts "判定: #{result5 == [1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
