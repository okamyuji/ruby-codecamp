#!/usr/bin/env ruby
# frozen_string_literal: true

def contains_duplicate(nums)
  nums.length != nums.uniq.length
end

def contains_duplicate_set(nums)
  seen = Set.new

  nums.each do |num|
    return true if seen.include?(num)

    seen.add(num)
  end

  false
end

def contains_duplicate_hash(nums)
  seen = {}

  nums.each do |num|
    return true if seen[num]

    seen[num] = true
  end

  false
end

def contains_duplicate_any(nums)
  seen = Set.new

  nums.any? { |num| !seen.add?(num) }
end

def contains_duplicate_tally(nums)
  nums.tally.values.any? { |count| count > 1 }
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 重複する要素の検出 テスト ==='
  puts

  result1 = contains_duplicate([1, 2, 3, 1])
  puts 'Test 1: contains_duplicate([1, 2, 3, 1])'
  puts "結果: #{result1}"
  puts '期待値: true'
  puts "判定: #{result1 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = contains_duplicate([1, 2, 3, 4])
  puts 'Test 2: contains_duplicate([1, 2, 3, 4])'
  puts "結果: #{result2}"
  puts '期待値: false'
  puts "判定: #{result2 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = contains_duplicate([1, 1, 1, 3, 3])
  puts 'Test 3: contains_duplicate([1, 1, 1, 3, 3])'
  puts "結果: #{result3}"
  puts '期待値: true'
  puts "判定: #{result3 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = contains_duplicate([])
  puts 'Test 4: contains_duplicate([])'
  puts "結果: #{result4}"
  puts '期待値: false'
  puts "判定: #{result4 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = contains_duplicate([1])
  puts 'Test 5: contains_duplicate([1])'
  puts "結果: #{result5}"
  puts '期待値: false'
  puts "判定: #{result5 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
