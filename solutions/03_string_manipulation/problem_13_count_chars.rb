#!/usr/bin/env ruby
# frozen_string_literal: true

def count_chars(str)
  str.chars.tally
end

def count_chars_each_with_object(str)
  str.chars.each_with_object(Hash.new(0)) do |char, hash|
    hash[char] += 1
  end
end

def count_chars_manual(str)
  count = {}

  str.each_char do |char|
    if count.key?(char)
      count[char] += 1
    else
      count[char] = 1
    end
  end

  count
end

def count_chars_group_by(str)
  str.chars.group_by(&:itself).transform_values(&:count)
end

def count_chars_default_hash(str)
  count = Hash.new(0)

  str.each_char { |char| count[char] += 1 }

  count
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 文字の出現回数をカウント テスト ==='
  puts

  result1 = count_chars('hello')
  puts "Test 1: count_chars('hello')"
  puts "結果: #{result1}"
  expected1 = { 'h' => 1, 'e' => 1, 'l' => 2, 'o' => 1 }
  puts "期待値: #{expected1}"
  puts "判定: #{result1 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = count_chars('aaa')
  puts "Test 2: count_chars('aaa')"
  puts "結果: #{result2}"
  puts "期待値: {'a'=>3}"
  puts "判定: #{result2 == { 'a' => 3 } ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = count_chars('abc')
  puts "Test 3: count_chars('abc')"
  puts "結果: #{result3}"
  expected3 = { 'a' => 1, 'b' => 1, 'c' => 1 }
  puts "判定: #{result3 == expected3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = count_chars('')
  puts "Test 4: count_chars('')"
  puts "結果: #{result4}"
  puts "判定: #{result4 == {} ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = count_chars('AaBb')
  puts "Test 5: count_chars('AaBb')"
  puts "結果: #{result5}"
  expected5 = { 'A' => 1, 'a' => 1, 'B' => 1, 'b' => 1 }
  puts "判定: #{result5 == expected5 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
