#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 配列の反転
# ファイル: 02_array_basics.md
# ============================================================================
#
# 配列が与えられます。要素の順序を反転した新しい配列を返してください。
#
# 入力例: [1, 2, 3, 4, 5]
# 出力例: [5, 4, 3, 2, 1]
#
# 時間計算量: O(n) - 全要素を処理
# 空間計算量: O(n) - 新しい配列を作成（破壊的メソッドならO(1)）
# ============================================================================

# 解法1: reverseメソッドを使用（推奨）
def reverse_array(arr)
  # 新しい配列を返す（元の配列は変更されない）
  arr.reverse
end

# 解法2: 手動で逆順に構築
def reverse_array_manual(arr)
  result = []

  # 最後のインデックスから0まで逆順にイテレート
  (arr.length - 1).downto(0) do |i|
    result << arr[i]
  end

  result
end

# 解法3: 両端からスワップ（破壊的、in-place）
def reverse_array_inplace!(arr)
  left = 0
  right = arr.length - 1

  while left < right
    # 両端の要素を交換
    arr[left], arr[right] = arr[right], arr[left]
    left += 1
    right -= 1
  end

  arr
end

# 解法4: reverse_eachを使用
def reverse_array_each(arr)
  result = []
  # reverse_eachは逆順にイテレートする
  arr.reverse_each { |elem| result << elem }
  result
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 配列の反転 テスト ==='
  puts

  # テストケース1: 通常の配列
  result1 = reverse_array([1, 2, 3, 4, 5])
  puts 'Test 1: reverse_array([1, 2, 3, 4, 5])'
  puts "結果: #{result1}"
  puts '期待値: [5, 4, 3, 2, 1]'
  puts "判定: #{result1 == [5, 4, 3, 2, 1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 文字列の配列
  result2 = reverse_array(['a', 'b', 'c'])
  puts "Test 2: reverse_array(['a', 'b', 'c'])"
  puts "結果: #{result2}"
  puts "期待値: ['c', 'b', 'a']"
  puts "判定: #{result2 == ['c', 'b', 'a'] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 単一要素
  result3 = reverse_array([1])
  puts 'Test 3: reverse_array([1])'
  puts "結果: #{result3}"
  puts '期待値: [1]'
  puts "判定: #{result3 == [1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 空配列
  result4 = reverse_array([])
  puts 'Test 4: reverse_array([])'
  puts "結果: #{result4}"
  puts '期待値: []'
  puts "判定: #{result4 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト
  puts '--- 解法2（手動構築）のテスト ---'
  result5 = reverse_array_manual([1, 2, 3, 4, 5])
  puts "reverse_array_manual([1, 2, 3, 4, 5]) = #{result5}"
  puts "判定: #{result5 == [5, 4, 3, 2, 1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（破壊的）
  puts '--- 解法3（in-place）のテスト ---'
  test_arr = [1, 2, 3, 4, 5]
  result6 = reverse_array_inplace!(test_arr)
  puts "reverse_array_inplace!([1, 2, 3, 4, 5]) = #{result6}"
  puts "元の配列も変更: #{test_arr}"
  puts "判定: #{result6 == [5, 4, 3, 2, 1] && test_arr == [5, 4, 3, 2, 1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法4のテスト
  puts '--- 解法4（reverse_each）のテスト ---'
  result7 = reverse_array_each([1, 2, 3, 4, 5])
  puts "reverse_array_each([1, 2, 3, 4, 5]) = #{result7}"
  puts "判定: #{result7 == [5, 4, 3, 2, 1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
