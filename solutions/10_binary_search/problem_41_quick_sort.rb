#!/usr/bin/env ruby
# frozen_string_literal: true

def quick_sort(arr)
  return arr if arr.length <= 1

  pivot = arr[arr.length / 2]

  smaller = arr.select { |x| x < pivot }
  equal = arr.select { |x| x == pivot }
  larger = arr.select { |x| x > pivot }

  quick_sort(smaller) + equal + quick_sort(larger)
end

def quick_sort_partition(arr)
  return arr if arr.length <= 1

  pivot = arr.first
  smaller, larger = arr[1..].partition { |x| x < pivot }

  quick_sort_partition(smaller) + [pivot] + quick_sort_partition(larger)
end

def quick_sort_inplace(arr, low = 0, high = arr.length - 1)
  return arr if low >= high

  pivot_index = partition_inplace(arr, low, high)
  quick_sort_inplace(arr, low, pivot_index - 1)
  quick_sort_inplace(arr, pivot_index + 1, high)

  arr
end

def partition_inplace(arr, low, high)
  pivot = arr[high]
  i = low - 1

  (low...high).each do |j|
    if arr[j] <= pivot
      i += 1
      arr[i], arr[j] = arr[j], arr[i]
    end
  end

  arr[i + 1], arr[high] = arr[high], arr[i + 1]
  i + 1
end

def quick_sort_random(arr)
  return arr if arr.length <= 1

  pivot_index = rand(arr.length)
  pivot = arr[pivot_index]

  smaller = []
  equal = []
  larger = []

  arr.each do |x|
    if x < pivot
      smaller << x
    elsif x == pivot
      equal << x
    else
      larger << x
    end
  end

  quick_sort_random(smaller) + equal + quick_sort_random(larger)
end

if __FILE__ == $PROGRAM_NAME
  puts '=== クイックソート テスト ==='
  puts

  result1 = quick_sort([10, 7, 8, 9, 1, 5])
  puts 'Test 1: quick_sort([10, 7, 8, 9, 1, 5])'
  puts "結果: #{result1}"
  puts '期待値: [1, 5, 7, 8, 9, 10]'
  puts "判定: #{result1 == [1, 5, 7, 8, 9, 10] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = quick_sort([3, 6, 8, 10, 1, 2])
  puts 'Test 2: quick_sort([3, 6, 8, 10, 1, 2])'
  puts "結果: #{result2}"
  puts '期待値: [1, 2, 3, 6, 8, 10]'
  puts "判定: #{result2 == [1, 2, 3, 6, 8, 10] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = quick_sort([1])
  puts 'Test 3: quick_sort([1])'
  puts "結果: #{result3}"
  puts '期待値: [1]'
  puts "判定: #{result3 == [1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = quick_sort([])
  puts 'Test 4: quick_sort([])'
  puts "結果: #{result4}"
  puts '期待値: []'
  puts "判定: #{result4 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = quick_sort([5, 5, 5, 5])
  puts 'Test 5: quick_sort([5, 5, 5, 5])'
  puts "結果: #{result5}"
  puts '期待値: [5, 5, 5, 5]'
  puts "判定: #{result5 == [5, 5, 5, 5] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
