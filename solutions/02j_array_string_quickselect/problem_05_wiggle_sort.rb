#!/usr/bin/env ruby
# frozen_string_literal: true

def wiggle_sort(nums)
  n = nums.length

  median = find_median(nums.dup)

  smaller = []
  equal = []
  larger = []

  nums.each do |num|
    if num < median
      smaller << num
    elsif num > median
      larger << num
    else
      equal << num
    end
  end

  result = Array.new(n)

  pos = 1
  larger.reverse_each do |num|
    result[pos] = num
    pos += 2
  end

  equal.reverse_each do |num|
    if pos < n
      result[pos] = num
      pos += 2
    else
      break
    end
  end

  pos = 0

  equal.reverse_each do |num|
    if result[1].nil? || num != result[1]
      result[pos] = num
      pos += 2
    end
  end

  smaller.reverse_each do |num|
    result[pos] = num
    pos += 2
  end

  nums.replace(result)
end

def find_median(nums)
  n = nums.length
  k = n / 2

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

def wiggle_sort_simple(nums)
  sorted = nums.sort
  n = nums.length
  mid = (n + 1) / 2

  smaller = sorted[0...mid].reverse
  larger = sorted[mid..].reverse

  result = []

  [smaller.length, larger.length].max.times do |i|
    result << smaller[i] if i < smaller.length
    result << larger[i] if i < larger.length
  end

  nums.replace(result)
end

if __FILE__ == $PROGRAM_NAME
  puts '=== ウィグルソート テスト ==='
  puts

  nums1 = [1, 5, 1, 1, 6, 4]
  wiggle_sort(nums1)
  puts 'Test 1: wiggle_sort([1, 5, 1, 1, 6, 4])'
  puts "結果: #{nums1}"
  valid1 = (0...(nums1.length - 1)).all? do |i|
    i.even? ? nums1[i] < nums1[i + 1] : nums1[i] > nums1[i + 1]
  end
  puts "判定: #{valid1 ? '✓ PASS' : '✗ FAIL'} (ウィグル順序)"
  puts

  nums2 = [1, 3, 2, 2, 3, 1]
  wiggle_sort(nums2)
  puts 'Test 2: wiggle_sort([1, 3, 2, 2, 3, 1])'
  puts "結果: #{nums2}"
  valid2 = (0...(nums2.length - 1)).all? do |i|
    i.even? ? nums2[i] < nums2[i + 1] : nums2[i] > nums2[i + 1]
  end
  puts "判定: #{valid2 ? '✓ PASS' : '✗ FAIL'} (ウィグル順序)"
  puts

  nums3 = [1, 5, 1, 1, 6, 4]
  wiggle_sort_simple(nums3)
  puts "wiggle_sort_simple([1, 5, 1, 1, 6, 4]) = #{nums3}"
  valid3 = (0...(nums3.length - 1)).all? do |i|
    i.even? ? nums3[i] < nums3[i + 1] : nums3[i] > nums3[i + 1]
  end
  puts "判定: #{valid3 ? '✓ PASS' : '✗ FAIL'} (ウィグル順序)"
  puts

  puts '=== 完了 ==='
end
