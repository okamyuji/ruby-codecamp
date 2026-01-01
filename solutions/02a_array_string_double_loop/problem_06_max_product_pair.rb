#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 最大の積を持つペアを見つける
# ファイル: 02a_array_string_double_loop.md
# ============================================================================
#
# 整数の配列が与えられます。配列内の2つの要素の積が最大となるペアを見つけてください。
#
# 入力例: [3, 4, 5, 2]
# 出力例: 20  # 4 * 5 = 20
#
# 時間計算量: O(n²) - 二重ループ版、O(n log n) - ソート版
# 空間計算量: O(1)
# ============================================================================

# 解法1: 二重ループ
def max_product_pair_brute_force(arr)
  return nil if arr.length < 2

  max_product = -Float::INFINITY

  arr.each_with_index do |num1, i|
    ((i + 1)...arr.length).each do |j|
      product = num1 * arr[j]
      max_product = product if product > max_product
    end
  end

  max_product
end

# 解法2: ソートして最大の2つを掛ける（正の数のみの場合）
def max_product_pair_sorted(arr)
  return nil if arr.length < 2

  sorted = arr.sort
  # 最大の2つの要素の積
  sorted[-1] * sorted[-2]
end

# 解法3: 負の数も考慮した完全版
def max_product_pair(arr)
  return nil if arr.length < 2

  sorted = arr.sort

  # 最大の2つの正の数の積と、最小の2つの負の数の積を比較
  max_positive = sorted[-1] * sorted[-2]
  max_negative = sorted[0] * sorted[1]

  [max_positive, max_negative].max
end

# 解法4: 1パスで解く
def max_product_pair_one_pass(arr)
  return nil if arr.length < 2

  # 最大の2つと最小の2つを追跡
  max1 = max2 = -Float::INFINITY
  min1 = min2 = Float::INFINITY

  arr.each do |num|
    if num > max1
      max2 = max1
      max1 = num
    elsif num > max2
      max2 = num
    end

    if num < min1
      min2 = min1
      min1 = num
    elsif num < min2
      min2 = num
    end
  end

  [max1 * max2, min1 * min2].max
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 最大の積を持つペアを見つける テスト ==='
  puts

  # テストケース1: 正の数のみ
  result1 = max_product_pair([3, 4, 5, 2])
  puts 'Test 1: max_product_pair([3, 4, 5, 2])'
  puts "結果: #{result1}"
  puts '期待値: 20 (4 * 5)'
  puts "判定: #{result1 == 20 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 正の数のみ（別パターン）
  result2 = max_product_pair([1, 2, 3, 4])
  puts 'Test 2: max_product_pair([1, 2, 3, 4])'
  puts "結果: #{result2}"
  puts '期待値: 12 (3 * 4)'
  puts "判定: #{result2 == 12 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 負の数を含む（正の積が最大）
  result3 = max_product_pair([-10, -3, 5, 6])
  puts 'Test 3: max_product_pair([-10, -3, 5, 6])'
  puts "結果: #{result3}"
  puts '期待値: 30 (5 * 6 または -10 * -3)'
  puts "判定: #{result3 == 30 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 負の数の積が最大
  result4 = max_product_pair([-10, -20, 1, 5])
  puts 'Test 4: max_product_pair([-10, -20, 1, 5])'
  puts "結果: #{result4}"
  puts '期待値: 200 (-10 * -20)'
  puts "判定: #{result4 == 200 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法1のテスト（二重ループ）
  puts '--- 解法1（二重ループ）のテスト ---'
  result5 = max_product_pair_brute_force([3, 4, 5, 2])
  puts "max_product_pair_brute_force([3, 4, 5, 2]) = #{result5}"
  puts "判定: #{result5 == 20 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（ソート、正の数のみ）
  puts '--- 解法2（ソート）のテスト ---'
  result6 = max_product_pair_sorted([3, 4, 5, 2])
  puts "max_product_pair_sorted([3, 4, 5, 2]) = #{result6}"
  puts "判定: #{result6 == 20 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法4のテスト（1パス）
  puts '--- 解法4（1パス）のテスト ---'
  result7 = max_product_pair_one_pass([-10, -20, 1, 5])
  puts "max_product_pair_one_pass([-10, -20, 1, 5]) = #{result7}"
  puts "判定: #{result7 == 200 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
