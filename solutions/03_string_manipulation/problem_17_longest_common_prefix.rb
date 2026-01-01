#!/usr/bin/env ruby
# frozen_string_literal: true

def longest_common_prefix(strs)
  return '' if strs.empty?

  prefix = strs[0]

  prefix.chars.each_with_index do |char, index|
    strs[1..].each do |str|
      return prefix[0...index] if index >= str.length || str[index] != char
    end
  end

  prefix
end

def longest_common_prefix_sort(strs)
  return '' if strs.empty?

  sorted = strs.sort
  first = sorted.first
  last = sorted.last

  index = 0
  index += 1 while index < first.length && index < last.length && first[index] == last[index]

  first[0...index]
end

def longest_common_prefix_reduce(strs)
  return '' if strs.empty?

  strs.reduce do |prefix, str|
    i = 0
    i += 1 while i < prefix.length && i < str.length && prefix[i] == str[i]
    prefix[0...i]
  end
end

def longest_common_prefix_divide(strs)
  return '' if strs.empty?

  divide_and_conquer(strs, 0, strs.length - 1)
end

def divide_and_conquer(strs, left, right)
  if left == right
    strs[left]
  else
    mid = (left + right) / 2
    lcp_left = divide_and_conquer(strs, left, mid)
    lcp_right = divide_and_conquer(strs, mid + 1, right)
    common_prefix(lcp_left, lcp_right)
  end
end

def common_prefix(str1, str2)
  min_len = [str1.length, str2.length].min
  i = 0
  i += 1 while i < min_len && str1[i] == str2[i]
  str1[0...i]
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 最長の共通接頭辞 テスト ==='
  puts

  result1 = longest_common_prefix(['flower', 'flow', 'flight'])
  puts "Test 1: longest_common_prefix(['flower', 'flow', 'flight'])"
  puts "結果: '#{result1}'"
  puts "期待値: 'fl'"
  puts "判定: #{result1 == 'fl' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = longest_common_prefix(['dog', 'racecar', 'car'])
  puts "Test 2: longest_common_prefix(['dog', 'racecar', 'car'])"
  puts "結果: '#{result2}'"
  puts "期待値: ''"
  puts "判定: #{result2 == '' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = longest_common_prefix(['abc'])
  puts "Test 3: longest_common_prefix(['abc'])"
  puts "結果: '#{result3}'"
  puts "期待値: 'abc'"
  puts "判定: #{result3 == 'abc' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = longest_common_prefix([])
  puts 'Test 4: longest_common_prefix([])'
  puts "結果: '#{result4}'"
  puts "期待値: ''"
  puts "判定: #{result4 == '' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = longest_common_prefix(['', 'abc'])
  puts "Test 5: longest_common_prefix(['', 'abc'])"
  puts "結果: '#{result5}'"
  puts "期待値: ''"
  puts "判定: #{result5 == '' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result6 = longest_common_prefix(['abc', 'abc', 'abc'])
  puts "Test 6: longest_common_prefix(['abc', 'abc', 'abc'])"
  puts "結果: '#{result6}'"
  puts "期待値: 'abc'"
  puts "判定: #{result6 == 'abc' ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
