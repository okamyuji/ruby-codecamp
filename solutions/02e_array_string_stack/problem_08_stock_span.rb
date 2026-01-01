#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 株の売買（スパン）
# ファイル: 02e_array_string_stack.md
# ============================================================================
#
# 株価の配列が与えられます。各日について、その日の株価スパン（その日以前の連続した、
# その日の株価以下の日数）を計算してください。
#
# 入力例: [100, 80, 60, 70, 60, 75, 85]
# 出力例: [1, 1, 1, 2, 1, 4, 6]
#
# 時間計算量: O(n)
# 空間計算量: O(n)
# ============================================================================

# 解法1: 単調減少スタック
def stock_span(prices)
  n = prices.length
  span = Array.new(n, 1)
  stack = []

  prices.each_with_index do |price, i|
    # 現在の株価以下の日をスタックから削除
    stack.pop while !stack.empty? && prices[stack.last] <= price

    span[i] = stack.empty? ? i + 1 : i - stack.last

    stack << i
  end

  span
end

# 解法2: クラスとして実装
class StockSpanner
  def initialize
    @prices = []
    @stack = []
  end

  def next(price)
    @prices << price
    i = @prices.length - 1

    @stack.pop while !@stack.empty? && @prices[@stack.last] <= price

    span = @stack.empty? ? i + 1 : i - @stack.last

    @stack << i

    span
  end
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 株の売買（スパン） テスト ==='
  puts

  # テストケース1: 通常のケース
  result1 = stock_span([100, 80, 60, 70, 60, 75, 85])
  puts 'Test 1: stock_span([100, 80, 60, 70, 60, 75, 85])'
  puts "結果: #{result1}"
  puts '期待値: [1, 1, 1, 2, 1, 4, 6]'
  expected1 = [1, 1, 1, 2, 1, 4, 6]
  puts "判定: #{result1 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 昇順
  result2 = stock_span([1, 2, 3, 4, 5])
  puts 'Test 2: stock_span([1, 2, 3, 4, 5])'
  puts "結果: #{result2}"
  puts '期待値: [1, 2, 3, 4, 5]'
  expected2 = [1, 2, 3, 4, 5]
  puts "判定: #{result2 == expected2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 降順
  result3 = stock_span([5, 4, 3, 2, 1])
  puts 'Test 3: stock_span([5, 4, 3, 2, 1])'
  puts "結果: #{result3}"
  puts '期待値: [1, 1, 1, 1, 1]'
  expected3 = [1, 1, 1, 1, 1]
  puts "判定: #{result3 == expected3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（クラス実装）
  puts '--- 解法2（クラス実装）のテスト ---'
  spanner = StockSpanner.new
  results = []
  [100, 80, 60, 70, 60, 75, 85].each do |price|
    results << spanner.next(price)
  end
  puts 'StockSpanner: [100, 80, 60, 70, 60, 75, 85]'
  puts "結果: #{results}"
  puts "判定: #{results == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
