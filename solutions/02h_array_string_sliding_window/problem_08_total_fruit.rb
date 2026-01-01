#!/usr/bin/env ruby
# frozen_string_literal: true

def total_fruit(fruits)
  fruit_count = Hash.new(0)
  left = 0
  max_fruits = 0

  fruits.each_with_index do |fruit, right|
    fruit_count[fruit] += 1

    while fruit_count.size > 2
      fruit_count[fruits[left]] -= 1
      fruit_count.delete(fruits[left]) if fruit_count[fruits[left]].zero?
      left += 1
    end

    max_fruits = [max_fruits, right - left + 1].max
  end

  max_fruits
end

def total_fruit_with_range(fruits)
  fruit_count = Hash.new(0)
  left = 0
  max_fruits = 0
  max_start = 0

  fruits.each_with_index do |fruit, right|
    fruit_count[fruit] += 1

    while fruit_count.size > 2
      fruit_count[fruits[left]] -= 1
      fruit_count.delete(fruits[left]) if fruit_count[fruits[left]].zero?
      left += 1
    end

    if right - left + 1 > max_fruits
      max_fruits = right - left + 1
      max_start = left
    end
  end

  { count: max_fruits, start: max_start, end: max_start + max_fruits - 1 }
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 果物をバスケットに入れる テスト ==='
  puts

  result1 = total_fruit([1, 2, 1])
  puts 'Test 1: total_fruit([1, 2, 1])'
  puts "結果: #{result1}"
  puts '期待値: 3'
  puts "判定: #{result1 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = total_fruit([0, 1, 2, 2])
  puts 'Test 2: total_fruit([0, 1, 2, 2])'
  puts "結果: #{result2}"
  puts '期待値: 3'
  puts "判定: #{result2 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = total_fruit([1, 2, 3, 2, 2])
  puts 'Test 3: total_fruit([1, 2, 3, 2, 2])'
  puts "結果: #{result3}"
  puts '期待値: 4'
  puts "判定: #{result3 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = total_fruit([3, 3, 3, 1, 2, 1, 1, 2, 3, 3, 4])
  puts 'Test 4: total_fruit([3, 3, 3, 1, 2, 1, 1, 2, 3, 3, 4])'
  puts "結果: #{result4}"
  puts '期待値: 5'
  puts "判定: #{result4 == 5 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = total_fruit_with_range([1, 2, 3, 2, 2])
  puts "total_fruit_with_range([1, 2, 3, 2, 2]) = #{result5}"
  puts "判定: #{result5[:count] == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
