#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin longest_common_subsequence
# 解法1: 二次元DP
def longest_common_subsequence(text1, text2)
  m = text1.length
  n = text2.length
  dp = Array.new(m + 1) { Array.new(n + 1, 0) }

  (1..m).each do |i|
    (1..n).each do |j|
      if text1[i - 1] == text2[j - 1]
        dp[i][j] = dp[i - 1][j - 1] + 1
      else
        dp[i][j] = [dp[i - 1][j], dp[i][j - 1]].max
      end
    end
  end

  dp[m][n]
end

# 解法2: 一次元DP（空間最適化）
def longest_common_subsequence_1d(text1, text2)
  # 短い方を列にする
  text1, text2 = text2, text1 if text1.length > text2.length

  m = text1.length
  n = text2.length

  prev = Array.new(n + 1, 0)

  (1..m).each do |i|
    curr = Array.new(n + 1, 0)

    (1..n).each do |j|
      if text1[i - 1] == text2[j - 1]
        curr[j] = prev[j - 1] + 1
      else
        curr[j] = [prev[j], curr[j - 1]].max
      end
    end

    prev = curr
  end

  prev[n]
end

# 解法3: LCS文字列を復元
def longest_common_subsequence_with_string(text1, text2)
  m = text1.length
  n = text2.length
  dp = Array.new(m + 1) { Array.new(n + 1, 0) }

  # DP計算
  (1..m).each do |i|
    (1..n).each do |j|
      if text1[i - 1] == text2[j - 1]
        dp[i][j] = dp[i - 1][j - 1] + 1
      else
        dp[i][j] = [dp[i - 1][j], dp[i][j - 1]].max
      end
    end
  end

  # バックトラック
  lcs = []
  i = m
  j = n

  while i > 0 && j > 0
    if text1[i - 1] == text2[j - 1]
      lcs.unshift(text1[i - 1])
      i -= 1
      j -= 1
    elsif dp[i - 1][j] > dp[i][j - 1]
      i -= 1
    else
      j -= 1
    end
  end

  [dp[m][n], lcs.join]
end

# テストケース
p longest_common_subsequence('abcde', 'ace') # => 3
p longest_common_subsequence('abc', 'abc')  # => 3
p longest_common_subsequence('abc', 'def')  # => 0
p longest_common_subsequence_with_string('abcde', 'ace') # => [3, "ace"]
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 最長共通部分列（LCS） テスト ==='
  puts

  result1 = longest_common_subsequence('abcde', 'ace')
  puts "Test 1: longest_common_subsequence('abcde', 'ace')"
  puts "結果: #{result1}"
  puts '期待値: 3'
  puts "判定: #{result1 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = longest_common_subsequence('abc', 'abc')
  puts "Test 2: longest_common_subsequence('abc', 'abc')"
  puts "結果: #{result2}"
  puts '期待値: 3'
  puts "判定: #{result2 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = longest_common_subsequence('abc', 'def')
  puts "Test 3: longest_common_subsequence('abc', 'def')"
  puts "結果: #{result3}"
  puts '期待値: 0'
  puts "判定: #{result3 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = longest_common_subsequence_with_string('abcde', 'ace')
  puts "longest_common_subsequence_with_string('abcde', 'ace') = #{result4}"
  puts "期待値: [3, 'ace']"
  puts "判定: #{result4 == [3, 'ace'] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
