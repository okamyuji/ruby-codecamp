#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 積が正の最長部分配列
# ファイル: 02f_array_string_prefix_sum.md
# ============================================================================
#
# 整数の配列が与えられます。積が正になる最長の連続部分配列の長さを返してください。
#
# 入力例: [1, -2, -3, 4]
# 出力例: 4  # 全体の積が24（正）
#
# 時間計算量: O(n)
# 空間計算量: O(n)
# ============================================================================

# 解法1: 負の数の偶奇を追跡
def max_length_positive_product(nums)
  max_len = 0
  neg_count = 0
  parity_map = { 0 => -1 }

  nums.each_with_index do |num, i|
    # 0を含む部分配列は積が0なので除外
    if num.zero?
      neg_count = 0
      parity_map = { 0 => i }
      next
    end

    neg_count += 1 if num < 0

    parity = neg_count % 2

    if parity_map.key?(parity)
      length = i - parity_map[parity]
      max_len = [max_len, length].max
    else
      parity_map[parity] = i
    end
  end

  max_len
end

# 解法2: 符号の累積和を使用
def max_length_positive_product_sign(nums)
  max_len = 0
  sign = 1
  sign_map = { 1 => -1 }

  nums.each_with_index do |num, i|
    if num.zero?
      sign = 1
      sign_map = { 1 => i }
      next
    end

    sign *= num <=> 0 # -1, 0, or 1

    if sign_map.key?(sign)
      max_len = [max_len, i - sign_map[sign]].max
    else
      sign_map[sign] = i
    end
  end

  max_len
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 積が正の最長部分配列 テスト ==='
  puts

  # テストケース1: 全体が正
  result1 = max_length_positive_product([1, -2, -3, 4])
  puts 'Test 1: max_length_positive_product([1, -2, -3, 4])'
  puts "結果: #{result1}"
  puts '期待値: 4 (全体の積が24)'
  puts "判定: #{result1 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 0を含む
  result2 = max_length_positive_product([0, 1, -2, -3, -4])
  puts 'Test 2: max_length_positive_product([0, 1, -2, -3, -4])'
  puts "結果: #{result2}"
  puts '期待値: 3 ([-2, -3, -4]の積が-24...実は負なので[1, -2, -3]が正)'
  puts "判定: #{result2 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 負の数が奇数個
  result3 = max_length_positive_product([-1, -2, -3, 0, 1])
  puts 'Test 3: max_length_positive_product([-1, -2, -3, 0, 1])'
  puts "結果: #{result3}"
  puts '期待値: 2 ([-1, -2]の積が2)'
  puts "判定: #{result3 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 全て正
  result4 = max_length_positive_product([1, 2, 3, 4])
  puts 'Test 4: max_length_positive_product([1, 2, 3, 4])'
  puts "結果: #{result4}"
  puts '期待値: 4'
  puts "判定: #{result4 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（符号）
  puts '--- 解法2（符号）のテスト ---'
  result5 = max_length_positive_product_sign([1, -2, -3, 4])
  puts "max_length_positive_product_sign([1, -2, -3, 4]) = #{result5}"
  puts "判定: #{result5 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result6 = max_length_positive_product_sign([0, 1, -2, -3, -4])
  puts "max_length_positive_product_sign([0, 1, -2, -3, -4]) = #{result6}"
  puts "判定: #{result6 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
