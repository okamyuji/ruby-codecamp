#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 繰り返しのない最長部分文字列
# ファイル: 02h_array_string_sliding_window.md
# ============================================================================
#
# 文字列が与えられます。繰り返し文字のない最長の部分文字列の長さを返してください。
#
# 入力例: "abcabcbb"
# 出力例: 3  # "abc"
#
# 時間計算量: O(n)
# 空間計算量: O(min(n, m)) - mはアルファベットのサイズ
# ============================================================================

def length_of_longest_substring(s)
  char_index = {}
  max_len = 0
  left = 0

  s.each_char.with_index do |char, right|
    if char_index.key?(char) && char_index[char] >= left
      left = char_index[char] + 1
    end

    char_index[char] = right
    max_len = [max_len, right - left + 1].max
  end

  max_len
end

def length_of_longest_substring_set(s)
  char_set = Set.new
  max_len = 0
  left = 0

  s.each_char.with_index do |char, right|
    while char_set.include?(char)
      char_set.delete(s[left])
      left += 1
    end

    char_set << char
    max_len = [max_len, right - left + 1].max
  end

  max_len
end

def longest_substring_no_repeat_with_string(s)
  char_index = {}
  max_len = 0
  max_start = 0
  left = 0

  s.each_char.with_index do |char, right|
    if char_index.key?(char) && char_index[char] >= left
      left = char_index[char] + 1
    end

    char_index[char] = right

    if right - left + 1 > max_len
      max_len = right - left + 1
      max_start = left
    end
  end

  s[max_start, max_len]
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 繰り返しのない最長部分文字列 テスト ==='
  puts

  result1 = length_of_longest_substring('abcabcbb')
  puts "Test 1: length_of_longest_substring('abcabcbb')"
  puts "結果: #{result1}"
  puts '期待値: 3 ("abc")'
  puts "判定: #{result1 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = length_of_longest_substring('bbbbb')
  puts "Test 2: length_of_longest_substring('bbbbb')"
  puts "結果: #{result2}"
  puts '期待値: 1 ("b")'
  puts "判定: #{result2 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = length_of_longest_substring('pwwkew')
  puts "Test 3: length_of_longest_substring('pwwkew')"
  puts "結果: #{result3}"
  puts '期待値: 3 ("wke")'
  puts "判定: #{result3 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = length_of_longest_substring('')
  puts "Test 4: length_of_longest_substring('')"
  puts "結果: #{result4}"
  puts '期待値: 0'
  puts "判定: #{result4 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = length_of_longest_substring_set('abcabcbb')
  puts "length_of_longest_substring_set('abcabcbb') = #{result5}"
  puts "判定: #{result5 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result6 = longest_substring_no_repeat_with_string('abcabcbb')
  puts "longest_substring_no_repeat_with_string('abcabcbb') = '#{result6}'"
  puts "判定: #{result6 == 'abc' ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
