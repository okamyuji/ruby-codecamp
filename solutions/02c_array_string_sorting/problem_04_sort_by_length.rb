#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: カスタムソート - 文字列を長さでソート
# ファイル: 02c_array_string_sorting.md
# ============================================================================
#
# 文字列の配列が与えられます。文字列の長さの昇順でソートしてください。
# 長さが同じ場合は辞書順でソートします。
#
# 入力例: ["apple", "pie", "a", "zoo", "elephant"]
# 出力例: ["a", "pie", "zoo", "apple", "elephant"]
#
# 時間計算量: O(n log n)
# 空間計算量: O(n)
# ============================================================================

# 解法1: sort_byを使用（推奨）
def sort_by_length(strs)
  strs.sort_by { |s| [s.length, s] }
end

# 解法2: sortとブロックを使用
def sort_by_length_sort(strs)
  strs.sort do |a, b|
    if a.length == b.length
      a <=> b
    else
      a.length <=> b.length
    end
  end
end

# 解法3: 降順ソート（長い順）
def sort_by_length_descending(strs)
  strs.sort_by { |s| [-s.length, s] }
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== カスタムソート - 文字列を長さでソート テスト ==='
  puts

  # テストケース1: 通常のケース
  result1 = sort_by_length(['apple', 'pie', 'a', 'zoo', 'elephant'])
  puts "Test 1: sort_by_length(['apple', 'pie', 'a', 'zoo', 'elephant'])"
  puts "結果: #{result1}"
  puts '期待値: ["a", "pie", "zoo", "apple", "elephant"]'
  puts "判定: #{result1 == ['a', 'pie', 'zoo', 'apple', 'elephant'] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 同じ長さ
  result2 = sort_by_length(['aa', 'a', 'aaa', 'aaaa'])
  puts "Test 2: sort_by_length(['aa', 'a', 'aaa', 'aaaa'])"
  puts "結果: #{result2}"
  puts '期待値: ["a", "aa", "aaa", "aaaa"]'
  puts "判定: #{result2 == ['a', 'aa', 'aaa', 'aaaa'] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 辞書順も考慮
  result3 = sort_by_length(['dog', 'cat', 'bird', 'ant'])
  puts "Test 3: sort_by_length(['dog', 'cat', 'bird', 'ant'])"
  puts "結果: #{result3}"
  puts '期待値: ["ant", "cat", "dog", "bird"]'
  puts "判定: #{result3 == ['ant', 'cat', 'dog', 'bird'] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（sort）
  puts '--- 解法2（sort）のテスト ---'
  result4 = sort_by_length_sort(['apple', 'pie', 'a', 'zoo', 'elephant'])
  puts "sort_by_length_sort(['apple', 'pie', 'a', 'zoo', 'elephant']) = #{result4}"
  puts "判定: #{result4 == ['a', 'pie', 'zoo', 'apple', 'elephant'] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（降順）
  puts '--- 解法3（降順）のテスト ---'
  result5 = sort_by_length_descending(['apple', 'pie', 'a', 'zoo'])
  puts "sort_by_length_descending(['apple', 'pie', 'a', 'zoo']) = #{result5}"
  puts '期待値: ["apple", "pie", "zoo", "a"]'
  puts "判定: #{result5 == ['apple', 'pie', 'zoo', 'a'] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
