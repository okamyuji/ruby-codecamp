#!/usr/bin/env ruby
# frozen_string_literal: true

def anagram?(str1, str2)
  str1.downcase.chars.sort == str2.downcase.chars.sort
end

def anagram_count?(str1, str2)
  return false if str1.length != str2.length

  str1.downcase.chars.tally == str2.downcase.chars.tally
end

def anagram_manual?(str1, str2)
  return false if str1.length != str2.length

  count = Hash.new(0)

  str1.downcase.each_char { |char| count[char] += 1 }

  str2.downcase.each_char { |char| count[char] -= 1 }

  count.values.all?(&:zero?)
end

def anagram_clean?(str1, str2)
  clean1 = str1.downcase.gsub(/[^a-z]/, '').chars.sort
  clean2 = str2.downcase.gsub(/[^a-z]/, '').chars.sort

  clean1 == clean2
end

if __FILE__ == $PROGRAM_NAME
  puts '=== アナグラム判定 テスト ==='
  puts

  result1 = anagram?('listen', 'silent')
  puts "Test 1: anagram?('listen', 'silent')"
  puts "結果: #{result1}"
  puts '期待値: true'
  puts "判定: #{result1 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = anagram?('hello', 'world')
  puts "Test 2: anagram?('hello', 'world')"
  puts "結果: #{result2}"
  puts '期待値: false'
  puts "判定: #{result2 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = anagram?('Dormitory', 'dirtyroom')
  puts "Test 3: anagram?('Dormitory', 'dirtyroom')"
  puts "結果: #{result3}"
  puts '期待値: true'
  puts "判定: #{result3 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = anagram?('a', 'a')
  puts "Test 4: anagram?('a', 'a')"
  puts "結果: #{result4}"
  puts '期待値: true'
  puts "判定: #{result4 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = anagram?('ab', 'ba')
  puts "Test 5: anagram?('ab', 'ba')"
  puts "結果: #{result5}"
  puts '期待値: true'
  puts "判定: #{result5 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result6 = anagram?('abc', 'ab')
  puts "Test 6: anagram?('abc', 'ab')"
  puts "結果: #{result6}"
  puts '期待値: false'
  puts "判定: #{result6 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
