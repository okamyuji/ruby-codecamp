#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 選択ソートの実装
# ファイル: 02c_array_string_sorting.md
# ============================================================================
#
# 配列が与えられます。選択ソートアルゴリズムを使用して配列をソートしてください。
#
# 入力例: [64, 25, 12, 22, 11]
# 出力例: [11, 12, 22, 25, 64]
#
# 時間計算量: O(n²) - 常に
# 空間計算量: O(1) - in-placeソート
# ============================================================================

# 解法1: 基本的な選択ソート
def selection_sort(arr)
  n = arr.length

  # 各位置について最小値を探す
  (n - 1).times do |i|
    min_index = i

    # 未ソート部分から最小値を探す
    ((i + 1)...n).each do |j|
      min_index = j if arr[j] < arr[min_index]
    end

    # 最小値を現在位置と交換
    arr[i], arr[min_index] = arr[min_index], arr[i]
  end

  arr
end

# 解法2: 降順選択ソート
def selection_sort_descending(arr)
  n = arr.length

  (n - 1).times do |i|
    max_index = i

    ((i + 1)...n).each do |j|
      max_index = j if arr[j] > arr[max_index]
    end

    arr[i], arr[max_index] = arr[max_index], arr[i]
  end

  arr
end

# 解法3: 選択ソートでk番目に小さい要素を見つける
def kth_smallest_selection(arr, k)
  # k回だけ選択ソートを実行
  k.times do |i|
    min_index = i

    ((i + 1)...arr.length).each do |j|
      min_index = j if arr[j] < arr[min_index]
    end

    arr[i], arr[min_index] = arr[min_index], arr[i]
  end

  arr[k - 1]
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 選択ソートの実装 テスト ==='
  puts

  # テストケース1: 通常のケース
  result1 = selection_sort([64, 25, 12, 22, 11].dup)
  puts 'Test 1: selection_sort([64, 25, 12, 22, 11])'
  puts "結果: #{result1}"
  puts '期待値: [11, 12, 22, 25, 64]'
  puts "判定: #{result1 == [11, 12, 22, 25, 64] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 別のケース
  result2 = selection_sort([5, 2, 8, 1, 9].dup)
  puts 'Test 2: selection_sort([5, 2, 8, 1, 9])'
  puts "結果: #{result2}"
  puts '期待値: [1, 2, 5, 8, 9]'
  puts "判定: #{result2 == [1, 2, 5, 8, 9] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 既にソート済み
  result3 = selection_sort([1, 2, 3, 4, 5].dup)
  puts 'Test 3: selection_sort([1, 2, 3, 4, 5])'
  puts "結果: #{result3}"
  puts '期待値: [1, 2, 3, 4, 5]'
  puts "判定: #{result3 == [1, 2, 3, 4, 5] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（降順）
  puts '--- 解法2（降順）のテスト ---'
  result4 = selection_sort_descending([64, 25, 12, 22, 11].dup)
  puts "selection_sort_descending([64, 25, 12, 22, 11]) = #{result4}"
  puts '期待値: [64, 25, 22, 12, 11]'
  puts "判定: #{result4 == [64, 25, 22, 12, 11] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（k番目に小さい要素）
  puts '--- 解法3（k番目に小さい要素）のテスト ---'
  result5 = kth_smallest_selection([7, 10, 4, 3, 20, 15].dup, 3)
  puts "kth_smallest_selection([7, 10, 4, 3, 20, 15], 3) = #{result5}"
  puts '期待値: 7'
  puts "判定: #{result5 == 7 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
