#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 配列の最大値と最小値
# ファイル: 02_array_basics.md
# ============================================================================
#
# 整数の配列が与えられます。配列内の最大値と最小値を配列として返してください。
#
# 入力例: [3, 1, 4, 1, 5, 9, 2, 6]
# 出力例: [1, 9]  # [最小値, 最大値]
#
# 時間計算量: O(n) - 配列を一度走査
# 空間計算量: O(1) - 定数量のメモリのみ使用
# ============================================================================

# 解法1: 手動で最大値・最小値を追跡
def min_max_manual(arr)
  # 空配列のエッジケース処理
  return nil if arr.empty?

  # 最初の要素で初期化
  min_val = arr[0]
  max_val = arr[0]

  # 2番目の要素から走査（最初は既に処理済み）
  arr[1..].each do |num|
    # 現在の最小値より小さければ更新
    min_val = num if num < min_val
    # 現在の最大値より大きければ更新
    max_val = num if num > max_val
  end

  [min_val, max_val]
end

# 解法2: 組み込みメソッドを使用（推奨）
def min_max(arr)
  return nil if arr.empty?

  # minmaxメソッドは[最小値, 最大値]の配列を返す
  arr.minmax
end

# 解法3: min, maxを個別に使用
def min_max_separate(arr)
  return nil if arr.empty?

  [arr.min, arr.max]
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 配列の最大値と最小値 テスト ==='
  puts

  # テストケース1: 通常の配列
  result1 = min_max([3, 1, 4, 1, 5, 9, 2, 6])
  puts 'Test 1: min_max([3, 1, 4, 1, 5, 9, 2, 6])'
  puts "結果: #{result1}"
  puts '期待値: [1, 9]'
  puts "判定: #{result1 == [1, 9] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 空配列
  result2 = min_max([])
  puts 'Test 2: min_max([])'
  puts "結果: #{result2.inspect}"
  puts '期待値: nil'
  puts "判定: #{result2.nil? ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 単一要素
  result3 = min_max([5])
  puts 'Test 3: min_max([5])'
  puts "結果: #{result3}"
  puts '期待値: [5, 5]'
  puts "判定: #{result3 == [5, 5] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 負の数を含む
  result4 = min_max([-5, -1, 0, 3, 7])
  puts 'Test 4: min_max([-5, -1, 0, 3, 7])'
  puts "結果: #{result4}"
  puts '期待値: [-5, 7]'
  puts "判定: #{result4 == [-5, 7] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法1のテスト
  puts '--- 解法1（手動追跡）のテスト ---'
  result5 = min_max_manual([3, 1, 4, 1, 5, 9, 2, 6])
  puts "min_max_manual([3, 1, 4, 1, 5, 9, 2, 6]) = #{result5}"
  puts "判定: #{result5 == [1, 9] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト
  puts '--- 解法3（min/max個別）のテスト ---'
  result6 = min_max_separate([3, 1, 4, 1, 5, 9, 2, 6])
  puts "min_max_separate([3, 1, 4, 1, 5, 9, 2, 6]) = #{result6}"
  puts "判定: #{result6 == [1, 9] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
