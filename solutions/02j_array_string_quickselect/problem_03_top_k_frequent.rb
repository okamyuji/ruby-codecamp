#!/usr/bin/env ruby
# frozen_string_literal: true

def top_k_frequent(nums, k)
  freq = nums.tally
  unique = freq.keys

  quickselect_by_frequency(unique, unique.length - k, freq)

  unique[(unique.length - k)..]
end

def quickselect_by_frequency(nums, k, freq)
  left = 0
  right = nums.length - 1

  loop do
    pivot_idx = partition_by_frequency(nums, left, right, freq)

    if pivot_idx == k
      return
    elsif pivot_idx > k
      right = pivot_idx - 1
    else
      left = pivot_idx + 1
    end
  end
end

def partition_by_frequency(nums, left, right, freq)
  pivot_idx = rand(left..right)
  nums[pivot_idx], nums[right] = nums[right], nums[pivot_idx]

  pivot_freq = freq[nums[right]]
  i = left

  (left...right).each do |j|
    if freq[nums[j]] < pivot_freq
      nums[i], nums[j] = nums[j], nums[i]
      i += 1
    end
  end

  nums[i], nums[right] = nums[right], nums[i]
  i
end

def top_k_frequent_bucket(nums, k)
  freq = nums.tally

  buckets = Array.new(nums.length + 1) { [] }

  freq.each do |num, count|
    buckets[count] << num
  end

  result = []

  buckets.reverse_each do |bucket|
    bucket.each do |num|
      result << num
      return result if result.size == k
    end
  end

  result
end

if __FILE__ == $PROGRAM_NAME
  puts '=== トップK頻出要素（Quickselect版） テスト ==='
  puts

  result1 = top_k_frequent([1, 1, 1, 2, 2, 3], 2)
  puts 'Test 1: top_k_frequent([1, 1, 1, 2, 2, 3], 2)'
  puts "結果: #{result1.sort}"
  puts '期待値: [1, 2]'
  puts "判定: #{result1.sort == [1, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = top_k_frequent([1], 1)
  puts 'Test 2: top_k_frequent([1], 1)'
  puts "結果: #{result2}"
  puts '期待値: [1]'
  puts "判定: #{result2 == [1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = top_k_frequent([4, 1, -1, 2, -1, 2, 3], 2)
  puts 'Test 3: top_k_frequent([4, 1, -1, 2, -1, 2, 3], 2)'
  puts "結果: #{result3.sort}"
  puts '期待値: [-1, 2]'
  puts "判定: #{result3.sort == [-1, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = top_k_frequent_bucket([1, 1, 1, 2, 2, 3], 2)
  puts "top_k_frequent_bucket([1, 1, 1, 2, 2, 3], 2) = #{result4.sort}"
  puts "判定: #{result4.sort == [1, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
