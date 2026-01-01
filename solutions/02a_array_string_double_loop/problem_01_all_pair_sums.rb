#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 配列内のすべてのペアの和を求める
# ファイル: 02a_array_string_double_loop.md
# ============================================================================
#
# 整数の配列が与えられます。配列内のすべての異なるペア（i, j）について、
# i < j の条件下でarr[i] + arr[j]の値をすべて求めてください。
#
# 入力例: [1, 2, 3]
# 出力例: [3, 4, 5]  # (1+2, 1+3, 2+3)
#
# 時間計算量: O(n²) - すべてのペアを調べる
# 空間計算量: O(n²) - 最悪の場合、すべてのペアを保存
# ============================================================================

# 解法1: 基本的な二重ループ
def all_pair_sums(arr)
  result = []

  # 外側のループ: 最初の要素を選ぶ
  arr.each_with_index do |num1, i|
    # 内側のループ: i より後ろの要素を選ぶ
    ((i + 1)...arr.length).each do |j|
      result << num1 + arr[j]
    end
  end

  result
end

# 解法2: 範囲を使った実装
def all_pair_sums_range(arr)
  result = []

  (0...arr.length).each do |i|
    ((i + 1)...arr.length).each do |j|
      result << arr[i] + arr[j]
    end
  end

  result
end

# 解法3: combination を使った関数型スタイル
def all_pair_sums_combination(arr)
  arr.combination(2).map { |a, b| a + b }
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 配列内のすべてのペアの和を求める テスト ==='
  puts

  # テストケース1: 3要素
  result1 = all_pair_sums([1, 2, 3])
  puts 'Test 1: all_pair_sums([1, 2, 3])'
  puts "結果: #{result1}"
  puts '期待値: [3, 4, 5]'
  puts "判定: #{result1 == [3, 4, 5] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 4要素
  result2 = all_pair_sums([1, 2, 3, 4])
  puts 'Test 2: all_pair_sums([1, 2, 3, 4])'
  puts "結果: #{result2}"
  puts '期待値: [3, 4, 5, 5, 6, 7]'
  puts "判定: #{result2 == [3, 4, 5, 5, 6, 7] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 単一要素
  result3 = all_pair_sums([5])
  puts 'Test 3: all_pair_sums([5])'
  puts "結果: #{result3}"
  puts '期待値: []'
  puts "判定: #{result3 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 空配列
  result4 = all_pair_sums([])
  puts 'Test 4: all_pair_sums([])'
  puts "結果: #{result4}"
  puts '期待値: []'
  puts "判定: #{result4 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース5: 同じ値
  result5 = all_pair_sums([1, 1, 1])
  puts 'Test 5: all_pair_sums([1, 1, 1])'
  puts "結果: #{result5}"
  puts '期待値: [2, 2, 2]'
  puts "判定: #{result5 == [2, 2, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト
  puts '--- 解法2（範囲）のテスト ---'
  result6 = all_pair_sums_range([1, 2, 3])
  puts "all_pair_sums_range([1, 2, 3]) = #{result6}"
  puts "判定: #{result6 == [3, 4, 5] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト
  puts '--- 解法3（combination）のテスト ---'
  result7 = all_pair_sums_combination([1, 2, 3])
  puts "all_pair_sums_combination([1, 2, 3]) = #{result7}"
  puts "判定: #{result7 == [3, 4, 5] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
