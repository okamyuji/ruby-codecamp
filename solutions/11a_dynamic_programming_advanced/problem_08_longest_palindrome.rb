#!/usr/bin/env ruby
# frozen_string_literal: true

def longest_palindrome(s)
  return '' if s.empty?

  n = s.length
  dp = Array.new(n) { Array.new(n, false) }
  start = 0
  max_len = 1

  n.times { |i| dp[i][i] = true }

  (0...(n - 1)).each do |i|
    next unless s[i] == s[i + 1]

    dp[i][i + 1] = true
    start = i
    max_len = 2
  end

  (3..n).each do |len|
    (0..(n - len)).each do |i|
      j = i + len - 1

      next unless s[i] == s[j] && dp[i + 1][j - 1]

      dp[i][j] = true
      start = i
      max_len = len
    end
  end

  s[start, max_len]
end

def longest_palindrome_expand(s)
  return '' if s.empty?

  start = 0
  max_len = 0

  s.length.times do |i|
    len1 = expand_around_center(s, i, i)
    len2 = expand_around_center(s, i, i + 1)

    len = [len1, len2].max

    if len > max_len
      max_len = len
      start = i - (len - 1) / 2
    end
  end

  s[start, max_len]
end

def expand_around_center(s, left, right)
  while left >= 0 && right < s.length && s[left] == s[right]
    left -= 1
    right += 1
  end

  right - left - 1
end

def longest_palindrome_manacher(s)
  return '' if s.empty?

  t = "##{s.chars.join('#')}#"
  n = t.length

  p_arr = Array.new(n, 0)
  center = 0
  right = 0

  max_len = 0
  center_index = 0

  (0...n).each do |i|
    mirror = 2 * center - i

    p_arr[i] = right > i ? [right - i, p_arr[mirror]].min : 0

    while i + 1 + p_arr[i] < n && i - 1 - p_arr[i] >= 0 &&
          t[i + 1 + p_arr[i]] == t[i - 1 - p_arr[i]]
      p_arr[i] += 1
    end

    if i + p_arr[i] > right
      center = i
      right = i + p_arr[i]
    end

    if p_arr[i] > max_len
      max_len = p_arr[i]
      center_index = i
    end
  end

  start = (center_index - max_len) / 2
  s[start, max_len]
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 最長回文部分文字列 テスト ==='
  puts

  result1 = longest_palindrome('babad')
  puts "Test 1: longest_palindrome('babad')"
  puts "結果: '#{result1}'"
  puts "期待値: 'bab' または 'aba'"
  puts "判定: #{['bab', 'aba'].include?(result1) ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = longest_palindrome('cbbd')
  puts "Test 2: longest_palindrome('cbbd')"
  puts "結果: '#{result2}'"
  puts "期待値: 'bb'"
  puts "判定: #{result2 == 'bb' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = longest_palindrome('a')
  puts "Test 3: longest_palindrome('a')"
  puts "結果: '#{result3}'"
  puts "期待値: 'a'"
  puts "判定: #{result3 == 'a' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = longest_palindrome('ac')
  puts "Test 4: longest_palindrome('ac')"
  puts "結果: '#{result4}'"
  puts "期待値: 'a' または 'c'"
  puts "判定: #{['a', 'c'].include?(result4) ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
