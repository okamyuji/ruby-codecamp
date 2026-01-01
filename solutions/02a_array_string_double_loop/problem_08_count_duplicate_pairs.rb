#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 配列内の重複するペアの数
# ファイル: 02a_array_string_double_loop.md
# ============================================================================
#
# 整数の配列が与えられます。同じ値を持つ要素のペアがいくつあるかを数えてください。
#
# 入力例: [1, 2, 1, 2, 3]
# 出力例: 2  # (0,2)と(1,3)の2ペア
#
# 時間計算量: O(n²) - 二重ループ版、O(n) - ハッシュ版
# 空間計算量: O(1) - 二重ループ版、O(n) - ハッシュ版
# ============================================================================

# 解法1: 二重ループ（O(n²)）
def count_duplicate_pairs_brute_force(arr)
  count = 0

  arr.each_with_index do |num1, i|
    ((i + 1)...arr.length).each do |j|
      count += 1 if num1 == arr[j]
    end
  end

  count
end

# 解法2: ハッシュで頻度カウント（O(n)、推奨）
def count_duplicate_pairs(arr)
  freq = Hash.new(0)

  # 各値の出現回数をカウント
  arr.each { |num| freq[num] += 1 }

  # 各値について、組み合わせ数C(n, 2) = n * (n - 1) / 2 を計算
  count = 0
  freq.each_value do |n|
    count += n * (n - 1) / 2 if n > 1
  end

  count
end

# 解法3: 関数型スタイル
def count_duplicate_pairs_functional(arr)
  arr.group_by(&:itself)
     .values
     .sum { |group| group.size * (group.size - 1) / 2 }
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 配列内の重複するペアの数 テスト ==='
  puts

  # テストケース1: 2ペア
  result1 = count_duplicate_pairs([1, 2, 1, 2, 3])
  puts 'Test 1: count_duplicate_pairs([1, 2, 1, 2, 3])'
  puts "結果: #{result1}"
  puts '期待値: 2 (インデックス(0,2)と(1,3))'
  puts "判定: #{result1 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 4つの同じ要素
  result2 = count_duplicate_pairs([1, 1, 1, 1])
  puts 'Test 2: count_duplicate_pairs([1, 1, 1, 1])'
  puts "結果: #{result2}"
  puts '期待値: 6 (C(4,2) = 6)'
  puts "判定: #{result2 == 6 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 重複なし
  result3 = count_duplicate_pairs([1, 2, 3, 4])
  puts 'Test 3: count_duplicate_pairs([1, 2, 3, 4])'
  puts "結果: #{result3}"
  puts '期待値: 0'
  puts "判定: #{result3 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 3つの同じ要素
  result4 = count_duplicate_pairs([5, 5, 5])
  puts 'Test 4: count_duplicate_pairs([5, 5, 5])'
  puts "結果: #{result4}"
  puts '期待値: 3 (C(3,2) = 3)'
  puts "判定: #{result4 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース5: 空配列
  result5 = count_duplicate_pairs([])
  puts 'Test 5: count_duplicate_pairs([])'
  puts "結果: #{result5}"
  puts '期待値: 0'
  puts "判定: #{result5 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法1のテスト（二重ループ）
  puts '--- 解法1（二重ループ）のテスト ---'
  result6 = count_duplicate_pairs_brute_force([1, 2, 1, 2, 3])
  puts "count_duplicate_pairs_brute_force([1, 2, 1, 2, 3]) = #{result6}"
  puts "判定: #{result6 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（関数型）
  puts '--- 解法3（関数型）のテスト ---'
  result7 = count_duplicate_pairs_functional([1, 2, 1, 2, 3])
  puts "count_duplicate_pairs_functional([1, 2, 1, 2, 3]) = #{result7}"
  puts "判定: #{result7 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
