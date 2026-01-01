#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 2つの配列のマージ
# ファイル: 02_array_basics.md
# ============================================================================
#
# 2つのソート済み配列が与えられます。これらをマージして、1つのソート済み配列を返してください。
#
# 入力例:
#   配列1: [1, 3, 5, 7]
#   配列2: [2, 4, 6, 8]
# 出力例: [1, 2, 3, 4, 5, 6, 7, 8]
#
# 時間計算量: O(n + m) - 両配列の全要素を一度処理
# 空間計算量: O(n + m) - 結果配列のサイズ
# ============================================================================

# 解法1: 2ポインタ法（効率的な実装）
def merge_sorted_arrays(arr1, arr2)
  result = []
  i = 0  # arr1のポインタ
  j = 0  # arr2のポインタ

  # 両方の配列に要素がある間、比較しながらマージ
  while i < arr1.length && j < arr2.length
    if arr1[i] <= arr2[j]
      result << arr1[i]
      i += 1
    else
      result << arr2[j]
      j += 1
    end
  end

  # 残りの要素を追加（片方の配列が先に終わった場合）
  result.concat(arr1[i..]) if i < arr1.length
  result.concat(arr2[j..]) if j < arr2.length

  result
end

# 解法2: 連結してソート（シンプルだが効率は劣る）
def merge_sorted_simple(arr1, arr2)
  # O(n log n)の計算量になるが、コードはシンプル
  (arr1 + arr2).sort
end

# 解法3: Ruby的な実装
def merge_sorted_ruby(arr1, arr2)
  # 連結して配列のソートメソッドを使用
  [*arr1, *arr2].sort
end

# 解法4: 再帰的な実装
def merge_sorted_recursive(arr1, arr2)
  # ベースケース
  return arr2 if arr1.empty?
  return arr1 if arr2.empty?

  if arr1[0] <= arr2[0]
    [arr1[0]] + merge_sorted_recursive(arr1[1..], arr2)
  else
    [arr2[0]] + merge_sorted_recursive(arr1, arr2[1..])
  end
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 2つの配列のマージ テスト ==='
  puts

  # テストケース1: 通常のマージ
  result1 = merge_sorted_arrays([1, 3, 5, 7], [2, 4, 6, 8])
  puts 'Test 1: merge_sorted_arrays([1, 3, 5, 7], [2, 4, 6, 8])'
  puts "結果: #{result1}"
  puts '期待値: [1, 2, 3, 4, 5, 6, 7, 8]'
  puts "判定: #{result1 == [1, 2, 3, 4, 5, 6, 7, 8] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 重複しない範囲
  result2 = merge_sorted_arrays([1, 2, 3], [4, 5, 6])
  puts 'Test 2: merge_sorted_arrays([1, 2, 3], [4, 5, 6])'
  puts "結果: #{result2}"
  puts '期待値: [1, 2, 3, 4, 5, 6]'
  puts "判定: #{result2 == [1, 2, 3, 4, 5, 6] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 片方が空配列
  result3 = merge_sorted_arrays([], [1, 2, 3])
  puts 'Test 3: merge_sorted_arrays([], [1, 2, 3])'
  puts "結果: #{result3}"
  puts '期待値: [1, 2, 3]'
  puts "判定: #{result3 == [1, 2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 片方が空配列（逆）
  result4 = merge_sorted_arrays([1, 2, 3], [])
  puts 'Test 4: merge_sorted_arrays([1, 2, 3], [])'
  puts "結果: #{result4}"
  puts '期待値: [1, 2, 3]'
  puts "判定: #{result4 == [1, 2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース5: 重複する値
  result5 = merge_sorted_arrays([1, 1, 1], [1, 1])
  puts 'Test 5: merge_sorted_arrays([1, 1, 1], [1, 1])'
  puts "結果: #{result5}"
  puts '期待値: [1, 1, 1, 1, 1]'
  puts "判定: #{result5 == [1, 1, 1, 1, 1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト
  puts '--- 解法2（連結+ソート）のテスト ---'
  result6 = merge_sorted_simple([1, 3, 5, 7], [2, 4, 6, 8])
  puts "merge_sorted_simple([1, 3, 5, 7], [2, 4, 6, 8]) = #{result6}"
  puts "判定: #{result6 == [1, 2, 3, 4, 5, 6, 7, 8] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト
  puts '--- 解法3（Ruby的）のテスト ---'
  result7 = merge_sorted_ruby([1, 3, 5, 7], [2, 4, 6, 8])
  puts "merge_sorted_ruby([1, 3, 5, 7], [2, 4, 6, 8]) = #{result7}"
  puts "判定: #{result7 == [1, 2, 3, 4, 5, 6, 7, 8] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法4のテスト
  puts '--- 解法4（再帰）のテスト ---'
  result8 = merge_sorted_recursive([1, 3, 5, 7], [2, 4, 6, 8])
  puts "merge_sorted_recursive([1, 3, 5, 7], [2, 4, 6, 8]) = #{result8}"
  puts "判定: #{result8 == [1, 2, 3, 4, 5, 6, 7, 8] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
