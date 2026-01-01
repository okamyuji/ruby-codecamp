#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 配列の回転
# ファイル: 02_array_basics.md
# ============================================================================
#
# 配列と回転数kが与えられます。配列を右にk回回転させた結果を返してください。
#
# 入力例:
#   配列: [1, 2, 3, 4, 5]
#   k: 2
# 出力例: [4, 5, 1, 2, 3]
#
# 時間計算量: O(n) - 配列を再構築
# 空間計算量: O(n) - 新しい配列を作成
# ============================================================================

# 解法1: rotateメソッドを使用（推奨）
def rotate_array(arr, k)
  return arr if arr.empty?

  # Rubyのrotateは左回転なので、負の値を渡して右回転
  arr.rotate(-k)
end

# 解法2: スライスを使用
def rotate_array_slice(arr, k)
  return arr if arr.empty?

  n = arr.length
  k %= n # kを正規化（配列長より大きい場合に対応）

  # 最後のk要素を先頭に移動
  arr[-k..] + arr[0...-k]
end

# 解法3: 手動で新しい配列を構築
def rotate_array_manual(arr, k)
  return arr if arr.empty?

  n = arr.length
  k %= n
  result = Array.new(n)

  # 各要素の新しい位置を計算
  arr.each_with_index do |elem, i|
    new_index = (i + k) % n
    result[new_index] = elem
  end

  result
end

# 解法4: 3回の反転を使用（in-place）
def rotate_array_reverse!(arr, k)
  return arr if arr.empty?

  n = arr.length
  k %= n

  # 配列全体を反転
  arr.reverse!
  # 最初のk要素を反転
  arr[0...k] = arr[0...k].reverse
  # 残りの要素を反転
  arr[k...n] = arr[k...n].reverse

  arr
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 配列の回転 テスト ==='
  puts

  # テストケース1: 通常の回転
  result1 = rotate_array([1, 2, 3, 4, 5], 2)
  puts 'Test 1: rotate_array([1, 2, 3, 4, 5], 2)'
  puts "結果: #{result1}"
  puts '期待値: [4, 5, 1, 2, 3]'
  puts "判定: #{result1 == [4, 5, 1, 2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 回転なし（k=0）
  result2 = rotate_array([1, 2, 3, 4, 5], 0)
  puts 'Test 2: rotate_array([1, 2, 3, 4, 5], 0)'
  puts "結果: #{result2}"
  puts '期待値: [1, 2, 3, 4, 5]'
  puts "判定: #{result2 == [1, 2, 3, 4, 5] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 配列長と同じ回転（k=5）
  result3 = rotate_array([1, 2, 3, 4, 5], 5)
  puts 'Test 3: rotate_array([1, 2, 3, 4, 5], 5)'
  puts "結果: #{result3}"
  puts '期待値: [1, 2, 3, 4, 5]'
  puts "判定: #{result3 == [1, 2, 3, 4, 5] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 配列長より大きい回転（k=7）
  result4 = rotate_array([1, 2, 3, 4, 5], 7)
  puts 'Test 4: rotate_array([1, 2, 3, 4, 5], 7) # 7 % 5 = 2'
  puts "結果: #{result4}"
  puts '期待値: [4, 5, 1, 2, 3]'
  puts "判定: #{result4 == [4, 5, 1, 2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース5: 空配列
  result5 = rotate_array([], 3)
  puts 'Test 5: rotate_array([], 3)'
  puts "結果: #{result5}"
  puts '期待値: []'
  puts "判定: #{result5 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト
  puts '--- 解法2（スライス）のテスト ---'
  result6 = rotate_array_slice([1, 2, 3, 4, 5], 2)
  puts "rotate_array_slice([1, 2, 3, 4, 5], 2) = #{result6}"
  puts "判定: #{result6 == [4, 5, 1, 2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト
  puts '--- 解法3（手動構築）のテスト ---'
  result7 = rotate_array_manual([1, 2, 3, 4, 5], 2)
  puts "rotate_array_manual([1, 2, 3, 4, 5], 2) = #{result7}"
  puts "判定: #{result7 == [4, 5, 1, 2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法4のテスト（破壊的）
  puts '--- 解法4（3回反転、in-place）のテスト ---'
  test_arr = [1, 2, 3, 4, 5]
  result8 = rotate_array_reverse!(test_arr, 2)
  puts "rotate_array_reverse!([1, 2, 3, 4, 5], 2) = #{result8}"
  puts "元の配列も変更: #{test_arr}"
  puts "判定: #{result8 == [4, 5, 1, 2, 3] && test_arr == [4, 5, 1, 2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
