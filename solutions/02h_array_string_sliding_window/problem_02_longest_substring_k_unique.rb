#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 最長の部分文字列（k個のユニーク文字）
# ファイル: 02h_array_string_sliding_window.md
# ============================================================================
#
# 文字列が与えられます。ちょうどk個のユニークな文字を含む最長の部分文字列の長さを
# 返してください。
#
# 入力例:
#   s = "eceba", k = 2
# 出力例: 3  # "ece"
#
# 時間計算量: O(n)
# 空間計算量: O(k)
# ============================================================================

# 解法1: Sliding Window with Hash
def longest_substring_k_unique(s, k)
  return 0 if s.empty? || k.zero?

  char_count = Hash.new(0)
  max_len = 0
  left = 0

  s.each_char.with_index do |char, right|
    char_count[char] += 1

    # ユニーク文字数がkを超えたら縮小
    while char_count.size > k
      char_count[s[left]] -= 1
      char_count.delete(s[left]) if char_count[s[left]].zero?
      left += 1
    end

    # ちょうどk個のユニーク文字
    max_len = [max_len, right - left + 1].max if char_count.size == k
  end

  max_len
end

# 解法2: 部分文字列も返す
def longest_substring_k_unique_with_string(s, k)
  return '' if s.empty? || k.zero?

  char_count = Hash.new(0)
  max_len = 0
  max_start = 0
  left = 0

  s.each_char.with_index do |char, right|
    char_count[char] += 1

    while char_count.size > k
      char_count[s[left]] -= 1
      char_count.delete(s[left]) if char_count[s[left]].zero?
      left += 1
    end

    if char_count.size == k && right - left + 1 > max_len
      max_len = right - left + 1
      max_start = left
    end
  end

  s[max_start, max_len]
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 最長の部分文字列（k個のユニーク文字） テスト ==='
  puts

  # テストケース1: "eceba", k=2
  result1 = longest_substring_k_unique('eceba', 2)
  puts "Test 1: longest_substring_k_unique('eceba', 2)"
  puts "結果: #{result1}"
  puts '期待値: 3 ("ece")'
  puts "判定: #{result1 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: "aa", k=1
  result2 = longest_substring_k_unique('aa', 1)
  puts "Test 2: longest_substring_k_unique('aa', 1)"
  puts "結果: #{result2}"
  puts '期待値: 2 ("aa")'
  puts "判定: #{result2 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: "abcba", k=2
  result3 = longest_substring_k_unique('abcba', 2)
  puts "Test 3: longest_substring_k_unique('abcba', 2)"
  puts "結果: #{result3}"
  puts '期待値: 3 ("bcb")'
  puts "判定: #{result3 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（部分文字列を返す）
  puts '--- 解法2（部分文字列を返す）のテスト ---'
  result4 = longest_substring_k_unique_with_string('eceba', 2)
  puts "longest_substring_k_unique_with_string('eceba', 2) = '#{result4}'"
  puts "期待値: 'ece'"
  puts "判定: #{result4 == 'ece' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = longest_substring_k_unique_with_string('aa', 1)
  puts "longest_substring_k_unique_with_string('aa', 1) = '#{result5}'"
  puts "期待値: 'aa'"
  puts "判定: #{result5 == 'aa' ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
