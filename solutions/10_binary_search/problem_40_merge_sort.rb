#!/usr/bin/env ruby
# frozen_string_literal: true

def merge_sort(arr)
  return arr if arr.length <= 1

  mid = arr.length / 2
  left = merge_sort(arr[0...mid])
  right = merge_sort(arr[mid..])

  merge(left, right)
end

def merge(left, right)
  result = []

  until left.empty? || right.empty?
    if left.first <= right.first
      result << left.shift
    else
      result << right.shift
    end
  end

  result + left + right
end

def merge_sort_index(arr)
  return arr if arr.length <= 1

  mid = arr.length / 2
  left = merge_sort_index(arr[0...mid])
  right = merge_sort_index(arr[mid..])

  merge_index(left, right)
end

def merge_index(left, right)
  result = []
  i = 0
  j = 0

  while i < left.length && j < right.length
    if left[i] <= right[j]
      result << left[i]
      i += 1
    else
      result << right[j]
      j += 1
    end
  end

  result.concat(left[i..]).concat(right[j..])
end

def merge_sort_iterative(arr)
  return arr if arr.length <= 1

  arr = arr.dup
  n = arr.length
  width = 1

  while width < n
    (0...n).step(width * 2) do |i|
      left = arr[i, width]
      right = arr[i + width, width] || []
      merged = merge(left, right)
      merged.each_with_index { |val, j| arr[i + j] = val }
    end
    width *= 2
  end

  arr
end

if __FILE__ == $PROGRAM_NAME
  puts '=== マージソート テスト ==='
  puts

  result1 = merge_sort([38, 27, 43, 3, 9, 82, 10])
  puts 'Test 1: merge_sort([38, 27, 43, 3, 9, 82, 10])'
  puts "結果: #{result1}"
  puts '期待値: [3, 9, 10, 27, 38, 43, 82]'
  puts "判定: #{result1 == [3, 9, 10, 27, 38, 43, 82] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = merge_sort([5, 2, 4, 6, 1, 3])
  puts 'Test 2: merge_sort([5, 2, 4, 6, 1, 3])'
  puts "結果: #{result2}"
  puts '期待値: [1, 2, 3, 4, 5, 6]'
  puts "判定: #{result2 == [1, 2, 3, 4, 5, 6] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = merge_sort([1])
  puts 'Test 3: merge_sort([1])'
  puts "結果: #{result3}"
  puts '期待値: [1]'
  puts "判定: #{result3 == [1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = merge_sort([])
  puts 'Test 4: merge_sort([])'
  puts "結果: #{result4}"
  puts '期待値: []'
  puts "判定: #{result4 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = merge_sort([2, 1])
  puts 'Test 5: merge_sort([2, 1])'
  puts "結果: #{result5}"
  puts '期待値: [1, 2]'
  puts "判定: #{result5 == [1, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
