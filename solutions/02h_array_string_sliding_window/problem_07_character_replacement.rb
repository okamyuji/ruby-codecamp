#!/usr/bin/env ruby
# frozen_string_literal: true

def character_replacement(s, k)
  char_count = Hash.new(0)
  left = 0
  max_count = 0
  max_len = 0

  s.each_char.with_index do |char, right|
    char_count[char] += 1
    max_count = [max_count, char_count[char]].max

    while (right - left + 1) - max_count > k
      char_count[s[left]] -= 1
      left += 1
    end

    max_len = [max_len, right - left + 1].max
  end

  max_len
end

def character_replacement_with_string(s, k)
  char_count = Hash.new(0)
  left = 0
  max_count = 0
  max_len = 0
  max_start = 0

  s.each_char.with_index do |char, right|
    char_count[char] += 1
    max_count = [max_count, char_count[char]].max

    while (right - left + 1) - max_count > k
      char_count[s[left]] -= 1
      left += 1
    end

    if right - left + 1 > max_len
      max_len = right - left + 1
      max_start = left
    end
  end

  s[max_start, max_len]
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 最長の繰り返し文字置換 テスト ==='
  puts

  result1 = character_replacement('ABAB', 2)
  puts "Test 1: character_replacement('ABAB', 2)"
  puts "結果: #{result1}"
  puts '期待値: 4'
  puts "判定: #{result1 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = character_replacement('AABABBA', 1)
  puts "Test 2: character_replacement('AABABBA', 1)"
  puts "結果: #{result2}"
  puts '期待値: 4'
  puts "判定: #{result2 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = character_replacement('AAAA', 2)
  puts "Test 3: character_replacement('AAAA', 2)"
  puts "結果: #{result3}"
  puts '期待値: 4'
  puts "判定: #{result3 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = character_replacement_with_string('AABABBA', 1)
  puts "character_replacement_with_string('AABABBA', 1) = '#{result4}'"
  puts "判定: #{result4.length == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
