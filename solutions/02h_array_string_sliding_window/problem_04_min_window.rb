#!/usr/bin/env ruby
# frozen_string_literal: true

def min_window(s, t)
  return '' if s.empty? || t.empty?

  t_count = Hash.new(0)
  t.each_char { |char| t_count[char] += 1 }

  window_count = Hash.new(0)
  required = t_count.size
  formed = 0

  left = 0
  min_len = Float::INFINITY
  min_start = 0

  s.each_char.with_index do |char, right|
    window_count[char] += 1

    formed += 1 if t_count.key?(char) && window_count[char] == t_count[char]

    while formed == required && left <= right
      if right - left + 1 < min_len
        min_len = right - left + 1
        min_start = left
      end

      left_char = s[left]
      window_count[left_char] -= 1

      formed -= 1 if t_count.key?(left_char) && window_count[left_char] < t_count[left_char]

      left += 1
    end
  end

  min_len == Float::INFINITY ? '' : s[min_start, min_len]
end

def min_window_optimized(s, t)
  return '' if s.empty? || t.empty?

  t_count = Hash.new(0)
  t.each_char { |char| t_count[char] += 1 }

  filtered = []
  s.each_char.with_index do |char, i|
    filtered << [i, char] if t_count.key?(char)
  end

  window_count = Hash.new(0)
  required = t_count.size
  formed = 0

  left = 0
  min_len = Float::INFINITY
  min_start = 0

  filtered.each_with_index do |(right_idx, char), right|
    window_count[char] += 1

    formed += 1 if window_count[char] == t_count[char]

    while formed == required && left <= right
      left_idx, left_char = filtered[left]

      if right_idx - left_idx + 1 < min_len
        min_len = right_idx - left_idx + 1
        min_start = left_idx
      end

      window_count[left_char] -= 1
      formed -= 1 if window_count[left_char] < t_count[left_char]

      left += 1
    end
  end

  min_len == Float::INFINITY ? '' : s[min_start, min_len]
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 最小ウィンドウ部分文字列 テスト ==='
  puts

  result1 = min_window('ADOBECODEBANC', 'ABC')
  puts "Test 1: min_window('ADOBECODEBANC', 'ABC')"
  puts "結果: '#{result1}'"
  puts "期待値: 'BANC'"
  puts "判定: #{result1 == 'BANC' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = min_window('a', 'a')
  puts "Test 2: min_window('a', 'a')"
  puts "結果: '#{result2}'"
  puts "期待値: 'a'"
  puts "判定: #{result2 == 'a' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = min_window('a', 'aa')
  puts "Test 3: min_window('a', 'aa')"
  puts "結果: '#{result3}'"
  puts "期待値: ''"
  puts "判定: #{result3 == '' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = min_window_optimized('ADOBECODEBANC', 'ABC')
  puts "min_window_optimized('ADOBECODEBANC', 'ABC') = '#{result4}'"
  puts "判定: #{result4 == 'BANC' ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
