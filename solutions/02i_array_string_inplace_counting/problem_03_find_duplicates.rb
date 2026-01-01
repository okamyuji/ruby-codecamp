#!/usr/bin/env ruby
# frozen_string_literal: true

def find_duplicates(nums)
  duplicates = []

  nums.each do |num|
    idx = num.abs - 1

    if nums[idx] < 0
      duplicates << num.abs
    else
      nums[idx] = -nums[idx]
    end
  end

  duplicates
end

def find_duplicates_restore(nums)
  duplicates = []

  nums.each do |num|
    idx = num.abs - 1

    if nums[idx] < 0
      duplicates << num.abs
    else
      nums[idx] = -nums[idx]
    end
  end

  nums.map! { |num| num.abs }

  duplicates
end

def find_duplicates_hash(nums)
  seen = Set.new
  duplicates = []

  nums.each do |num|
    if seen.include?(num)
      duplicates << num
    else
      seen << num
    end
  end

  duplicates
end

if __FILE__ == $PROGRAM_NAME
  puts '=== すべての重複を見つける テスト ==='
  puts

  result1 = find_duplicates([4, 3, 2, 7, 8, 2, 3, 1].dup)
  puts 'Test 1: find_duplicates([4, 3, 2, 7, 8, 2, 3, 1])'
  puts "結果: #{result1.sort}"
  puts '期待値: [2, 3]'
  puts "判定: #{result1.sort == [2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = find_duplicates([1, 1, 2].dup)
  puts 'Test 2: find_duplicates([1, 1, 2])'
  puts "結果: #{result2}"
  puts '期待値: [1]'
  puts "判定: #{result2 == [1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = find_duplicates([1].dup)
  puts 'Test 3: find_duplicates([1])'
  puts "結果: #{result3}"
  puts '期待値: []'
  puts "判定: #{result3 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = find_duplicates_restore([4, 3, 2, 7, 8, 2, 3, 1].dup)
  puts "find_duplicates_restore([4, 3, 2, 7, 8, 2, 3, 1]) = #{result4.sort}"
  puts "判定: #{result4.sort == [2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = find_duplicates_hash([4, 3, 2, 7, 8, 2, 3, 1])
  puts "find_duplicates_hash([4, 3, 2, 7, 8, 2, 3, 1]) = #{result5.sort}"
  puts "判定: #{result5.sort == [2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
