#!/usr/bin/env ruby
# frozen_string_literal: true

def selection_sort(arr)
  arr = arr.dup
  n = arr.length

  (0...(n - 1)).each do |i|
    min_index = i

    ((i + 1)...n).each do |j|
      min_index = j if arr[j] < arr[min_index]
    end

    arr[i], arr[min_index] = arr[min_index], arr[i] if min_index != i
  end

  arr
end

def selection_sort_min_by(arr)
  arr = arr.dup
  n = arr.length

  (0...(n - 1)).each do |i|
    min_index = (i...n).min_by { |j| arr[j] }
    arr[i], arr[min_index] = arr[min_index], arr[i]
  end

  arr
end

def selection_sort_desc(arr)
  arr = arr.dup
  n = arr.length

  (0...(n - 1)).each do |i|
    max_index = i

    ((i + 1)...n).each do |j|
      max_index = j if arr[j] > arr[max_index]
    end

    arr[i], arr[max_index] = arr[max_index], arr[i]
  end

  arr
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 選択ソート テスト ==='
  puts

  result1 = selection_sort([64, 25, 12, 22, 11])
  puts 'Test 1: selection_sort([64, 25, 12, 22, 11])'
  puts "結果: #{result1}"
  puts '期待値: [11, 12, 22, 25, 64]'
  puts "判定: #{result1 == [11, 12, 22, 25, 64] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = selection_sort([5, 3, 8, 4, 2])
  puts 'Test 2: selection_sort([5, 3, 8, 4, 2])'
  puts "結果: #{result2}"
  puts '期待値: [2, 3, 4, 5, 8]'
  puts "判定: #{result2 == [2, 3, 4, 5, 8] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = selection_sort([1])
  puts 'Test 3: selection_sort([1])'
  puts "結果: #{result3}"
  puts '期待値: [1]'
  puts "判定: #{result3 == [1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = selection_sort([])
  puts 'Test 4: selection_sort([])'
  puts "結果: #{result4}"
  puts '期待値: []'
  puts "判定: #{result4 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = selection_sort([3, 3, 3])
  puts 'Test 5: selection_sort([3, 3, 3])'
  puts "結果: #{result5}"
  puts '期待値: [3, 3, 3]'
  puts "判定: #{result5 == [3, 3, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
