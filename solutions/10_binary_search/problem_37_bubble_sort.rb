#!/usr/bin/env ruby
# frozen_string_literal: true

def bubble_sort(arr)
  arr = arr.dup
  n = arr.length

  (0...n).each do |i|
    swapped = false

    (0...(n - i - 1)).each do |j|
      if arr[j] > arr[j + 1]
        arr[j], arr[j + 1] = arr[j + 1], arr[j]
        swapped = true
      end
    end

    break unless swapped
  end

  arr
end

def bubble_sort!(arr)
  n = arr.length

  loop do
    swapped = false

    (0...(n - 1)).each do |i|
      if arr[i] > arr[i + 1]
        arr[i], arr[i + 1] = arr[i + 1], arr[i]
        swapped = true
      end
    end

    break unless swapped
  end

  arr
end

def bubble_sort_while(arr)
  arr = arr.dup
  n = arr.length

  sorted = false
  until sorted
    sorted = true

    (0...(n - 1)).each do |i|
      if arr[i] > arr[i + 1]
        arr[i], arr[i + 1] = arr[i + 1], arr[i]
        sorted = false
      end
    end
  end

  arr
end

def sort_builtin(arr)
  arr.sort
end

if __FILE__ == $PROGRAM_NAME
  puts '=== バブルソート テスト ==='
  puts

  result1 = bubble_sort([64, 34, 25, 12, 22, 11, 90])
  puts 'Test 1: bubble_sort([64, 34, 25, 12, 22, 11, 90])'
  puts "結果: #{result1}"
  puts '期待値: [11, 12, 22, 25, 34, 64, 90]'
  puts "判定: #{result1 == [11, 12, 22, 25, 34, 64, 90] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = bubble_sort([5, 1, 4, 2, 8])
  puts 'Test 2: bubble_sort([5, 1, 4, 2, 8])'
  puts "結果: #{result2}"
  puts '期待値: [1, 2, 4, 5, 8]'
  puts "判定: #{result2 == [1, 2, 4, 5, 8] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = bubble_sort([1, 2, 3])
  puts 'Test 3: bubble_sort([1, 2, 3])'
  puts "結果: #{result3}"
  puts '期待値: [1, 2, 3]'
  puts "判定: #{result3 == [1, 2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = bubble_sort([])
  puts 'Test 4: bubble_sort([])'
  puts "結果: #{result4}"
  puts '期待値: []'
  puts "判定: #{result4 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = bubble_sort([1])
  puts 'Test 5: bubble_sort([1])'
  puts "結果: #{result5}"
  puts '期待値: [1]'
  puts "判定: #{result5 == [1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
