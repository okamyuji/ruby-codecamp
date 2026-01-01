#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 挿入ソートの実装
# ファイル: 02c_array_string_sorting.md
# ============================================================================
#
# 配列が与えられます。挿入ソートアルゴリズムを使用して配列をソートしてください。
#
# 入力例: [5, 2, 4, 6, 1, 3]
# 出力例: [1, 2, 3, 4, 5, 6]
#
# 時間計算量: O(n²) - 最悪・平均ケース、O(n) - 最良ケース
# 空間計算量: O(1) - in-placeソート
# ============================================================================

# 解法1: 基本的な挿入ソート
def insertion_sort(arr)
  n = arr.length

  # 2番目の要素から開始（最初の要素はソート済みとみなす）
  (1...n).each do |i|
    key = arr[i]
    j = i - 1

    # keyより大きい要素を右にシフト
    while j >= 0 && arr[j] > key
      arr[j + 1] = arr[j]
      j -= 1
    end

    # keyを適切な位置に挿入
    arr[j + 1] = key
  end

  arr
end

# 解法2: 交換を使った実装
def insertion_sort_swap(arr)
  (1...arr.length).each do |i|
    j = i

    # 左側のソート済み部分で適切な位置まで交換
    while j.positive? && arr[j - 1] > arr[j]
      arr[j - 1], arr[j] = arr[j], arr[j - 1]
      j -= 1
    end
  end

  arr
end

# 解法3: 降順挿入ソート
def insertion_sort_descending(arr)
  (1...arr.length).each do |i|
    key = arr[i]
    j = i - 1

    while j >= 0 && arr[j] < key # 比較演算子を逆にする
      arr[j + 1] = arr[j]
      j -= 1
    end

    arr[j + 1] = key
  end

  arr
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 挿入ソートの実装 テスト ==='
  puts

  # テストケース1: 通常のケース
  result1 = insertion_sort([5, 2, 4, 6, 1, 3].dup)
  puts 'Test 1: insertion_sort([5, 2, 4, 6, 1, 3])'
  puts "結果: #{result1}"
  puts '期待値: [1, 2, 3, 4, 5, 6]'
  puts "判定: #{result1 == [1, 2, 3, 4, 5, 6] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 別のケース
  result2 = insertion_sort([12, 11, 13, 5, 6].dup)
  puts 'Test 2: insertion_sort([12, 11, 13, 5, 6])'
  puts "結果: #{result2}"
  puts '期待値: [5, 6, 11, 12, 13]'
  puts "判定: #{result2 == [5, 6, 11, 12, 13] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 既にソート済み
  result3 = insertion_sort([1, 2, 3].dup)
  puts 'Test 3: insertion_sort([1, 2, 3])'
  puts "結果: #{result3}"
  puts '期待値: [1, 2, 3]'
  puts "判定: #{result3 == [1, 2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（交換）
  puts '--- 解法2（交換）のテスト ---'
  result4 = insertion_sort_swap([5, 2, 4, 6, 1, 3].dup)
  puts "insertion_sort_swap([5, 2, 4, 6, 1, 3]) = #{result4}"
  puts "判定: #{result4 == [1, 2, 3, 4, 5, 6] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（降順）
  puts '--- 解法3（降順）のテスト ---'
  result5 = insertion_sort_descending([5, 2, 4, 6, 1, 3].dup)
  puts "insertion_sort_descending([5, 2, 4, 6, 1, 3]) = #{result5}"
  puts '期待値: [6, 5, 4, 3, 2, 1]'
  puts "判定: #{result5 == [6, 5, 4, 3, 2, 1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
