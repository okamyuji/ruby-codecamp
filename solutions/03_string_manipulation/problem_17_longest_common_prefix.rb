#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin longest_common_prefix
# 解法1: 垂直走査（推奨）
def longest_common_prefix(strs)
  return '' if strs.empty?

  # 最初の文字列を基準にする
  prefix = strs[0]

  prefix.chars.each_with_index do |char, index|
    # 他のすべての文字列でこの位置の文字を確認
    strs[1..].each do |str|
      # 文字列が短いか、文字が一致しない場合
      if index >= str.length || str[index] != char
        return prefix[0...index]
      end
    end
  end

  prefix
end

# 解法2: ソートを利用
def longest_common_prefix_sort(strs)
  return '' if strs.empty?

  # ソートすると、最初と最後の文字列の共通接頭辞が全体の共通接頭辞
  sorted = strs.sort
  first = sorted.first
  last = sorted.last

  index = 0
  index += 1 while index < first.length && index < last.length && first[index] == last[index]

  first[0...index]
end

# 解法3: reduceを使用
def longest_common_prefix_reduce(strs)
  return '' if strs.empty?

  strs.reduce do |prefix, str|
    # prefixとstrの共通接頭辞を計算
    i = 0
    i += 1 while i < prefix.length && i < str.length && prefix[i] == str[i]
    prefix[0...i]
  end
end

# 解法4: 分割統治法
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

# テストケース
p longest_common_prefix(['flower', 'flow', 'flight'])  # => "fl"
p longest_common_prefix(['dog', 'racecar', 'car'])     # => ""
p longest_common_prefix(['abc'])                       # => "abc"
p longest_common_prefix([])                            # => ""
p longest_common_prefix(['', 'abc'])                   # => ""
p longest_common_prefix(['abc', 'abc', 'abc'])         # => "abc"
# docs:end

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
