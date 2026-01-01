#!/usr/bin/env ruby
# frozen_string_literal: true

def insertion_sort(arr)
  arr = arr.dup
  n = arr.length

  (1...n).each do |i|
    key = arr[i]
    j = i - 1

    while j >= 0 && arr[j] > key
      arr[j + 1] = arr[j]
      j -= 1
    end

    arr[j + 1] = key
  end

  arr
end

def insertion_sort_binary(arr)
  arr = arr.dup

  (1...arr.length).each do |i|
    key = arr[i]

    insert_pos = (0...i).bsearch { |j| arr[j] > key } || i

    (insert_pos...i).reverse_each { |j| arr[j + 1] = arr[j] }
    arr[insert_pos] = key
  end

  arr
end

def insertion_sort_ruby(arr)
  result = []

  arr.each do |num|
    insert_index = result.find_index { |x| x > num } || result.length
    result.insert(insert_index, num)
  end

  result
end

def insertion_sort_desc(arr)
  arr = arr.dup

  (1...arr.length).each do |i|
    key = arr[i]
    j = i - 1

    while j >= 0 && arr[j] < key
      arr[j + 1] = arr[j]
      j -= 1
    end

    arr[j + 1] = key
  end

  arr
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 挿入ソート テスト ==='
  puts

  result1 = insertion_sort([12, 11, 13, 5, 6])
  puts 'Test 1: insertion_sort([12, 11, 13, 5, 6])'
  puts "結果: #{result1}"
  puts '期待値: [5, 6, 11, 12, 13]'
  puts "判定: #{result1 == [5, 6, 11, 12, 13] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = insertion_sort([5, 2, 4, 6, 1, 3])
  puts 'Test 2: insertion_sort([5, 2, 4, 6, 1, 3])'
  puts "結果: #{result2}"
  puts '期待値: [1, 2, 3, 4, 5, 6]'
  puts "判定: #{result2 == [1, 2, 3, 4, 5, 6] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = insertion_sort([1, 2, 3])
  puts 'Test 3: insertion_sort([1, 2, 3])'
  puts "結果: #{result3}"
  puts '期待値: [1, 2, 3]'
  puts "判定: #{result3 == [1, 2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = insertion_sort([3, 2, 1])
  puts 'Test 4: insertion_sort([3, 2, 1])'
  puts "結果: #{result4}"
  puts '期待値: [1, 2, 3]'
  puts "判定: #{result4 == [1, 2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = insertion_sort([])
  puts 'Test 5: insertion_sort([])'
  puts "結果: #{result5}"
  puts '期待値: []'
  puts "判定: #{result5 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
