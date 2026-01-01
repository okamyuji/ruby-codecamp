#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題1: 計算量の分析
# ファイル: 00_ruby_basics_and_complexity.md
# ============================================================================
#
# 以下のコードの時間計算量と空間計算量を分析してください。
#
# def process_data(arr)
#   result = []
#
#   arr.each do |x|
#     result << x * 2 if x.even?
#   end
#
#   result.sort
# end
#
# 時間計算量: O(n log n) - sortが支配的
# 空間計算量: O(n) - result配列が最大n個の要素を保持
# ============================================================================

def process_data(arr)
  result = []

  arr.each do |x|
    result << x * 2 if x.even?
  end

  result.sort
end

def analyze_complexity(arr)
  arr.length

  # 時間計算量の分析
  # 1. arr.each: O(n)
  # 2. x.even?: O(1) per element
  # 3. result << x * 2: O(1) per element
  # 4. result.sort: O(m log m) where m <= n
  # 全体: O(n) + O(m log m) = O(n log n) (worst case when all even)

  # 空間計算量の分析
  # 1. result配列: O(n) in worst case
  # 2. その他の変数: O(1)
  # 全体: O(n)

  {
    time_complexity: 'O(n log n)',
    space_complexity: 'O(n)',
    explanation: {
      time: 'arr.eachはO(n)だが、result.sortがO(m log m)で支配的。最悪の場合m=nなのでO(n log n)',
      space: 'result配列が最大n個の要素を保持するためO(n)'
    }
  }
end

def process_data_optimized(arr)
  # 最適化版: sortを避けられる場合
  # ただし、この問題ではsortが要件なので最適化は不可
  result = []

  arr.each do |x|
    result << x * 2 if x.even?
  end

  result.sort
end

def process_data_with_select(arr)
  # selectを使った実装
  arr.select(&:even?).map { |x| x * 2 }.sort
end

def process_data_functional(arr)
  # 関数型スタイル
  arr
    .filter(&:even?)
    .map { |x| x * 2 }
    .sort
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 計算量の分析 テスト ==='
  puts

  test_arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

  puts 'Test 1: process_data([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])'
  result1 = process_data(test_arr)
  expected1 = [4, 8, 12, 16, 20]
  puts "結果: #{result1}"
  puts "期待値: #{expected1}"
  puts "判定: #{result1 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts 'Test 2: analyze_complexity'
  analysis = analyze_complexity(test_arr)
  puts "時間計算量: #{analysis[:time_complexity]}"
  puts "空間計算量: #{analysis[:space_complexity]}"
  puts "説明（時間）: #{analysis[:explanation][:time]}"
  puts "説明（空間）: #{analysis[:explanation][:space]}"
  puts "判定: #{analysis[:time_complexity] == 'O(n log n)' && analysis[:space_complexity] == 'O(n)' ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts 'Test 3: process_data_with_select([5, 10, 15, 20])'
  result3 = process_data_with_select([5, 10, 15, 20])
  expected3 = [20, 40]
  puts "結果: #{result3}"
  puts "期待値: #{expected3}"
  puts "判定: #{result3 == expected3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts 'Test 4: process_data_functional([2, 4, 6])'
  result4 = process_data_functional([2, 4, 6])
  expected4 = [4, 8, 12]
  puts "結果: #{result4}"
  puts "期待値: #{expected4}"
  puts "判定: #{result4 == expected4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts 'Test 5: 空配列のテスト'
  result5 = process_data([])
  expected5 = []
  puts "結果: #{result5}"
  puts "期待値: #{expected5}"
  puts "判定: #{result5 == expected5 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts 'Test 6: 全て奇数のテスト'
  result6 = process_data([1, 3, 5, 7, 9])
  expected6 = []
  puts "結果: #{result6}"
  puts "期待値: #{expected6}"
  puts "判定: #{result6 == expected6 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
