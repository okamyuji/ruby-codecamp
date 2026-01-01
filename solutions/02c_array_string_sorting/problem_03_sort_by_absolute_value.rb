#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: カスタムソート - 絶対値でソート
# ファイル: 02c_array_string_sorting.md
# ============================================================================
#
# 整数の配列が与えられます。絶対値の昇順でソートしてください。
# 絶対値が同じ場合は、元の値の昇順でソートします。
#
# 入力例: [-5, -3, 3, 2, -1]
# 出力例: [-1, 2, -3, 3, -5]
#
# 時間計算量: O(n log n)
# 空間計算量: O(n)
# ============================================================================

# 解法1: sort_byを使用（推奨）
def sort_by_absolute_value(arr)
  arr.sort_by { |x| [x.abs, x] }
end

# 解法2: sortとブロックを使用
def sort_by_absolute_value_sort(arr)
  arr.sort do |a, b|
    if a.abs == b.abs
      a <=> b # 絶対値が同じなら元の値で比較
    else
      a.abs <=> b.abs # 絶対値で比較
    end
  end
end

# 解法3: stable_sortが必要な場合（元の順序を保持）
def sort_by_absolute_value_stable(arr)
  arr.each_with_index.sort_by { |x, i| [x.abs, x, i] }.map(&:first)
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== カスタムソート - 絶対値でソート テスト ==='
  puts

  # テストケース1: 正負混在
  result1 = sort_by_absolute_value([-5, -3, 3, 2, -1])
  puts 'Test 1: sort_by_absolute_value([-5, -3, 3, 2, -1])'
  puts "結果: #{result1}"
  puts '期待値: [-1, 2, -3, 3, -5]'
  puts "判定: #{result1 == [-1, 2, -3, 3, -5] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 絶対値が同じペア
  result2 = sort_by_absolute_value([1, -1, 2, -2, 3, -3])
  puts 'Test 2: sort_by_absolute_value([1, -1, 2, -2, 3, -3])'
  puts "結果: #{result2}"
  puts '期待値: [-1, 1, -2, 2, -3, 3]'
  puts "判定: #{result2 == [-1, 1, -2, 2, -3, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 別のケース
  result3 = sort_by_absolute_value([5, -7, 3, -3])
  puts 'Test 3: sort_by_absolute_value([5, -7, 3, -3])'
  puts "結果: #{result3}"
  puts '期待値: [-3, 3, 5, -7]'
  puts "判定: #{result3 == [-3, 3, 5, -7] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 正の数のみ
  result4 = sort_by_absolute_value([5, 2, 8, 1])
  puts 'Test 4: sort_by_absolute_value([5, 2, 8, 1])'
  puts "結果: #{result4}"
  puts '期待値: [1, 2, 5, 8]'
  puts "判定: #{result4 == [1, 2, 5, 8] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（sort）
  puts '--- 解法2（sort）のテスト ---'
  result5 = sort_by_absolute_value_sort([-5, -3, 3, 2, -1])
  puts "sort_by_absolute_value_sort([-5, -3, 3, 2, -1]) = #{result5}"
  puts "判定: #{result5 == [-1, 2, -3, 3, -5] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（stable）
  puts '--- 解法3（stable）のテスト ---'
  result6 = sort_by_absolute_value_stable([-5, -3, 3, 2, -1])
  puts "sort_by_absolute_value_stable([-5, -3, 3, 2, -1]) = #{result6}"
  puts "判定: #{result6 == [-1, 2, -3, 3, -5] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
