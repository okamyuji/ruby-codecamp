#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: バブルソートの実装
# ファイル: 02a_array_string_double_loop.md
# ============================================================================
#
# 配列が与えられます。バブルソートアルゴリズムを使用して配列をソートしてください。
#
# 入力例: [5, 2, 8, 1, 9]
# 出力例: [1, 2, 5, 8, 9]
#
# 時間計算量: O(n²) - 最悪・平均ケース、O(n) - 最良ケース（既にソート済み）
# 空間計算量: O(1) - in-placeソート
# ============================================================================

# 解法1: 基本的なバブルソート
def bubble_sort(arr)
  n = arr.length

  # 外側のループ: パスの回数
  (n - 1).times do |i|
    # 内側のループ: 隣接要素の比較
    (n - i - 1).times do |j|
      if arr[j] > arr[j + 1]
        # 交換
        arr[j], arr[j + 1] = arr[j + 1], arr[j]
      end
    end
  end

  arr
end

# 解法2: 最適化版（早期終了）
def bubble_sort_optimized(arr)
  n = arr.length

  (n - 1).times do |i|
    swapped = false

    (n - i - 1).times do |j|
      if arr[j] > arr[j + 1]
        arr[j], arr[j + 1] = arr[j + 1], arr[j]
        swapped = true
      end
    end

    # 交換が発生しなければ、すでにソート済み
    break unless swapped
  end

  arr
end

# 解法3: 降順バブルソート
def bubble_sort_descending(arr)
  n = arr.length

  (n - 1).times do |i|
    (n - i - 1).times do |j|
      if arr[j] < arr[j + 1] # 比較演算子を逆にする
        arr[j], arr[j + 1] = arr[j + 1], arr[j]
      end
    end
  end

  arr
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== バブルソートの実装 テスト ==='
  puts

  # テストケース1: 通常のケース
  result1 = bubble_sort([5, 2, 8, 1, 9].dup)
  puts 'Test 1: bubble_sort([5, 2, 8, 1, 9])'
  puts "結果: #{result1}"
  puts '期待値: [1, 2, 5, 8, 9]'
  puts "判定: #{result1 == [1, 2, 5, 8, 9] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 逆順
  result2 = bubble_sort([3, 2, 1].dup)
  puts 'Test 2: bubble_sort([3, 2, 1])'
  puts "結果: #{result2}"
  puts '期待値: [1, 2, 3]'
  puts "判定: #{result2 == [1, 2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 既にソート済み
  result3 = bubble_sort([1, 2, 3].dup)
  puts 'Test 3: bubble_sort([1, 2, 3])'
  puts "結果: #{result3}"
  puts '期待値: [1, 2, 3]'
  puts "判定: #{result3 == [1, 2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 単一要素
  result4 = bubble_sort([1].dup)
  puts 'Test 4: bubble_sort([1])'
  puts "結果: #{result4}"
  puts '期待値: [1]'
  puts "判定: #{result4 == [1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（最適化版）
  puts '--- 解法2（最適化版）のテスト ---'
  result5 = bubble_sort_optimized([5, 2, 8, 1, 9].dup)
  puts "bubble_sort_optimized([5, 2, 8, 1, 9]) = #{result5}"
  puts "判定: #{result5 == [1, 2, 5, 8, 9] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 既にソート済みの配列で最適化の効果を確認
  result6 = bubble_sort_optimized([1, 2, 3, 4, 5].dup)
  puts "bubble_sort_optimized([1, 2, 3, 4, 5]) = #{result6}"
  puts "判定: #{result6 == [1, 2, 3, 4, 5] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（降順）
  puts '--- 解法3（降順）のテスト ---'
  result7 = bubble_sort_descending([5, 2, 8, 1, 9].dup)
  puts "bubble_sort_descending([5, 2, 8, 1, 9]) = #{result7}"
  puts '期待値: [9, 8, 5, 2, 1]'
  puts "判定: #{result7 == [9, 8, 5, 2, 1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
