#!/usr/bin/env ruby
# frozen_string_literal: true

def find_kth_largest(nums, k)
  n = nums.length
  quickselect(nums, n - k)
end

def quickselect(nums, k)
  left = 0
  right = nums.length - 1

  loop do
    pivot_idx = partition_asc(nums, left, right)

    if pivot_idx == k
      return nums[k]
    elsif pivot_idx > k
      right = pivot_idx - 1
    else
      left = pivot_idx + 1
    end
  end
end

def partition_asc(nums, left, right)
  pivot_idx = rand(left..right)
  nums[pivot_idx], nums[right] = nums[right], nums[pivot_idx]

  pivot = nums[right]
  i = left

  (left...right).each do |j|
    if nums[j] < pivot
      nums[i], nums[j] = nums[j], nums[i]
      i += 1
    end
  end

  nums[i], nums[right] = nums[right], nums[i]
  i
end

def find_kth_largest_desc(nums, k)
  left = 0
  right = nums.length - 1

  loop do
    pivot_idx = partition_desc(nums, left, right)

    if pivot_idx == k - 1
      return nums[k - 1]
    elsif pivot_idx > k - 1
      right = pivot_idx - 1
    else
      left = pivot_idx + 1
    end
  end
end

def partition_desc(nums, left, right)
  pivot_idx = rand(left..right)
  nums[pivot_idx], nums[right] = nums[right], nums[pivot_idx]

  pivot = nums[right]
  i = left

  (left...right).each do |j|
    if nums[j] > pivot
      nums[i], nums[j] = nums[j], nums[i]
      i += 1
    end
  end

  nums[i], nums[right] = nums[right], nums[i]
  i
end

def find_kth_largest_heap(nums, k)
  heap = []

  nums.each do |num|
    if heap.size < k
      heap << num
      heap.sort!
    elsif num > heap[0]
      heap[0] = num
      heap.sort!
    end
  end

  heap[0]
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 配列のk番目に大きい要素 テスト ==='
  puts

  result1 = find_kth_largest([3, 2, 1, 5, 6, 4].dup, 2)
  puts 'Test 1: find_kth_largest([3, 2, 1, 5, 6, 4], 2)'
  puts "結果: #{result1}"
  puts '期待値: 5'
  puts "判定: #{result1 == 5 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = find_kth_largest([3, 2, 3, 1, 2, 4, 5, 5, 6].dup, 4)
  puts 'Test 2: find_kth_largest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4)'
  puts "結果: #{result2}"
  puts '期待値: 4'
  puts "判定: #{result2 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = find_kth_largest([1].dup, 1)
  puts 'Test 3: find_kth_largest([1], 1)'
  puts "結果: #{result3}"
  puts '期待値: 1'
  puts "判定: #{result3 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = find_kth_largest_desc([3, 2, 1, 5, 6, 4].dup, 2)
  puts "find_kth_largest_desc([3, 2, 1, 5, 6, 4], 2) = #{result4}"
  puts "判定: #{result4 == 5 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = find_kth_largest_heap([3, 2, 1, 5, 6, 4], 2)
  puts "find_kth_largest_heap([3, 2, 1, 5, 6, 4], 2) = #{result5}"
  puts "判定: #{result5 == 5 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
