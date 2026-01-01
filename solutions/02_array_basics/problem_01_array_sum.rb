#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 配列の合計値
# ファイル: 02_array_basics.md
# ============================================================================
#
# 整数の配列が与えられます。配列内のすべての要素の合計値を返してください。
#
# 入力例: [1, 2, 3, 4, 5]
# 出力例: 15
#
# 時間計算量: O(n) - 配列の全要素を一度走査
# 空間計算量: O(1) - 追加のメモリは定数量のみ
# ============================================================================

# 解法1: 基本的なループを使用
# 配列の各要素を順番に走査し、累積的に加算する
def array_sum_loop(arr)
  # 合計値を保持する変数を初期化
  total = 0

  # 配列の各要素をイテレート
  arr.each do |num|
    total += num
  end

  total
end

# 解法2: sumメソッドを使用（推奨）
# Rubyの組み込みメソッドで最も簡潔
def array_sum(arr)
  # 空配列の場合は0を返す
  arr.sum
end

# 解法3: reduceを使用
# 関数型プログラミングスタイル
def array_sum_reduce(arr)
  # 初期値0から始めて、各要素を累積的に加算
  # accはアキュムレータ（累積値）、numは現在の要素
  arr.reduce(0) { |acc, num| acc + num }
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 配列の合計値 テスト ==='
  puts

  # テストケース1: 通常の配列
  result1 = array_sum([1, 2, 3, 4, 5])
  puts 'Test 1: array_sum([1, 2, 3, 4, 5])'
  puts "結果: #{result1}"
  puts '期待値: 15'
  puts "判定: #{result1 == 15 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 空配列
  result2 = array_sum([])
  puts 'Test 2: array_sum([])'
  puts "結果: #{result2}"
  puts '期待値: 0'
  puts "判定: #{result2 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 正負の数
  result3 = array_sum([-1, 1])
  puts 'Test 3: array_sum([-1, 1])'
  puts "結果: #{result3}"
  puts '期待値: 0'
  puts "判定: #{result3 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 単一要素
  result4 = array_sum([100])
  puts 'Test 4: array_sum([100])'
  puts "結果: #{result4}"
  puts '期待値: 100'
  puts "判定: #{result4 == 100 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法1のテスト
  puts '--- 解法1（ループ）のテスト ---'
  result5 = array_sum_loop([1, 2, 3, 4, 5])
  puts "array_sum_loop([1, 2, 3, 4, 5]) = #{result5}"
  puts "判定: #{result5 == 15 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト
  puts '--- 解法3（reduce）のテスト ---'
  result6 = array_sum_reduce([1, 2, 3, 4, 5])
  puts "array_sum_reduce([1, 2, 3, 4, 5]) = #{result6}"
  puts "判定: #{result6 == 15 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
