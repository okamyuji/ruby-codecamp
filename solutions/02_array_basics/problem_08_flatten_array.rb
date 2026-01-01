#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 配列の要素を平坦化
# ファイル: 02_array_basics.md
# ============================================================================
#
# ネストした配列が与えられます。すべての要素を1次元の配列に平坦化してください。
#
# 入力例: [[1, 2], [3, [4, 5]], 6]
# 出力例: [1, 2, 3, 4, 5, 6]
#
# 時間計算量: O(n) - nは全要素数
# 空間計算量: O(n) - 結果配列のサイズ
# ============================================================================

# 解法1: flattenメソッドを使用（推奨）
def flatten_array(arr)
  # flattenは完全に平坦化する
  arr.flatten
end

# 解法2: 1段階のみ平坦化
def flatten_one_level(arr)
  # flatten(1)は1段階のみ平坦化
  arr.flatten(1)
end

# 解法3: 再帰的に手動実装
def flatten_array_recursive(arr)
  result = []

  arr.each do |elem|
    if elem.is_a?(Array)
      # 配列の場合は再帰的に平坦化して結果に連結
      result.concat(flatten_array_recursive(elem))
    else
      # 配列でない場合はそのまま追加
      result << elem
    end
  end

  result
end

# 解法4: スタックを使用（再帰なし）
def flatten_array_iterative(arr)
  result = []
  stack = arr.dup # 元の配列をコピー

  until stack.empty?
    elem = stack.shift # 先頭から取り出し

    if elem.is_a?(Array)
      # 配列の場合はその要素をスタックの先頭に追加
      stack.unshift(*elem)
    else
      result << elem
    end
  end

  result
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 配列の要素を平坦化 テスト ==='
  puts

  # テストケース1: ネストした配列
  result1 = flatten_array([[1, 2], [3, [4, 5]], 6])
  puts 'Test 1: flatten_array([[1, 2], [3, [4, 5]], 6])'
  puts "結果: #{result1}"
  puts '期待値: [1, 2, 3, 4, 5, 6]'
  puts "判定: #{result1 == [1, 2, 3, 4, 5, 6] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 深いネスト
  result2 = flatten_array([1, [2, [3, [4]]]])
  puts 'Test 2: flatten_array([1, [2, [3, [4]]]])'
  puts "結果: #{result2}"
  puts '期待値: [1, 2, 3, 4]'
  puts "判定: #{result2 == [1, 2, 3, 4] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 空の配列を含む
  result3 = flatten_array([[]])
  puts 'Test 3: flatten_array([[]])'
  puts "結果: #{result3}"
  puts '期待値: []'
  puts "判定: #{result3 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: ネストなし
  result4 = flatten_array([1, 2, 3])
  puts 'Test 4: flatten_array([1, 2, 3])'
  puts "結果: #{result4}"
  puts '期待値: [1, 2, 3]'
  puts "判定: #{result4 == [1, 2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（1段階のみ）
  puts '--- 解法2（1段階のみ平坦化）のテスト ---'
  result5 = flatten_one_level([[1, 2], [3, [4, 5]], 6])
  puts "flatten_one_level([[1, 2], [3, [4, 5]], 6]) = #{result5}"
  puts '期待値: [1, 2, 3, [4, 5], 6]'
  puts "判定: #{result5 == [1, 2, 3, [4, 5], 6] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（再帰）
  puts '--- 解法3（再帰）のテスト ---'
  result6 = flatten_array_recursive([[1, 2], [3, [4, 5]], 6])
  puts "flatten_array_recursive([[1, 2], [3, [4, 5]], 6]) = #{result6}"
  puts "判定: #{result6 == [1, 2, 3, 4, 5, 6] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法4のテスト（スタック）
  puts '--- 解法4（スタック）のテスト ---'
  result7 = flatten_array_iterative([[1, 2], [3, [4, 5]], 6])
  puts "flatten_array_iterative([[1, 2], [3, [4, 5]], 6]) = #{result7}"
  puts "判定: #{result7 == [1, 2, 3, 4, 5, 6] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
