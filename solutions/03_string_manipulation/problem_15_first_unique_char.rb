#!/usr/bin/env ruby
# frozen_string_literal: true

def first_unique_char(str)
  count = str.chars.tally

  str.chars.each_with_index do |char, index|
    return index if count[char] == 1
  end

  -1
end

def first_unique_char_find(str)
  count = str.chars.tally

  str.chars.find_index { |char| count[char] == 1 } || -1
end

def first_unique_char_manual(str)
  count = Hash.new(0)

  str.each_char { |char| count[char] += 1 }

  str.each_char.with_index do |char, index|
    return index if count[char] == 1
  end

  -1
end

def first_unique_char_index(str)
  str.chars.each_with_index do |char, index|
    return index if str.index(char) == str.rindex(char)
  end

  -1
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 最初の非重複文字を見つける テスト ==='
  puts

  result1 = first_unique_char('leetcode')
  puts "Test 1: first_unique_char('leetcode')"
  puts "結果: #{result1}"
  puts "期待値: 0 ('l')"
  puts "判定: #{result1 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = first_unique_char('loveleetcode')
  puts "Test 2: first_unique_char('loveleetcode')"
  puts "結果: #{result2}"
  puts "期待値: 2 ('v')"
  puts "判定: #{result2 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = first_unique_char('aabb')
  puts "Test 3: first_unique_char('aabb')"
  puts "結果: #{result3}"
  puts '期待値: -1'
  puts "判定: #{result3 == -1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = first_unique_char('z')
  puts "Test 4: first_unique_char('z')"
  puts "結果: #{result4}"
  puts '期待値: 0'
  puts "判定: #{result4 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = first_unique_char('')
  puts "Test 5: first_unique_char('')"
  puts "結果: #{result5}"
  puts '期待値: -1'
  puts "判定: #{result5 == -1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
