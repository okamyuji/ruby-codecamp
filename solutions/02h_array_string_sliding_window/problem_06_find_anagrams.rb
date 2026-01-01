#!/usr/bin/env ruby
# frozen_string_literal: true

def find_anagrams(s, p)
  return [] if s.length < p.length

  p_count = Hash.new(0)
  p.each_char { |char| p_count[char] += 1 }

  window_count = Hash.new(0)
  result = []

  s.each_char.with_index do |char, right|
    window_count[char] += 1

    if right >= p.length
      left_char = s[right - p.length]
      window_count[left_char] -= 1
      window_count.delete(left_char) if window_count[left_char].zero?
    end

    result << right - p.length + 1 if window_count == p_count
  end

  result
end

def find_anagrams_counter(s, p)
  return [] if s.length < p.length

  p_count = Hash.new(0)
  p.each_char { |char| p_count[char] += 1 }

  window_count = Hash.new(0)
  result = []
  matches = 0

  s.each_char.with_index do |char, right|
    if p_count.key?(char)
      window_count[char] += 1
      matches += 1 if window_count[char] == p_count[char]
    end

    if right >= p.length
      left_char = s[right - p.length]

      if p_count.key?(left_char)
        matches -= 1 if window_count[left_char] == p_count[left_char]
        window_count[left_char] -= 1
      end
    end

    result << right - p.length + 1 if matches == p_count.size
  end

  result
end

if __FILE__ == $PROGRAM_NAME
  puts '=== アナグラムの検索 テスト ==='
  puts

  result1 = find_anagrams('cbaebabacd', 'abc')
  puts "Test 1: find_anagrams('cbaebabacd', 'abc')"
  puts "結果: #{result1}"
  puts '期待値: [0, 6]'
  puts "判定: #{result1 == [0, 6] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = find_anagrams('abab', 'ab')
  puts "Test 2: find_anagrams('abab', 'ab')"
  puts "結果: #{result2}"
  puts '期待値: [0, 1, 2]'
  puts "判定: #{result2 == [0, 1, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = find_anagrams('baa', 'aa')
  puts "Test 3: find_anagrams('baa', 'aa')"
  puts "結果: #{result3}"
  puts '期待値: [1]'
  puts "判定: #{result3 == [1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = find_anagrams_counter('cbaebabacd', 'abc')
  puts "find_anagrams_counter('cbaebabacd', 'abc') = #{result4}"
  puts "判定: #{result4 == [0, 6] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
