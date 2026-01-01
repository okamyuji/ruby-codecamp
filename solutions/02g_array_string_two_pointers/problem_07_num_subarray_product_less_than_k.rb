#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 部分配列の積がK未満
# ファイル: 02g_array_string_two_pointers.md
# ============================================================================
#
# 正の整数の配列と整数kが与えられます。積がk未満の連続部分配列の数を返してください。
#
# 入力例:
#   nums = [10, 5, 2, 6], k = 100
# 出力例: 8  # [10], [5], [2], [6], [10,5], [5,2], [2,6], [5,2,6]
#
# 時間計算量: O(n)
# 空間計算量: O(1)
# ============================================================================

# 解法1: Sliding Window
def num_subarray_product_less_than_k(nums, k)
  return 0 if k <= 1

  count = 0
  product = 1
  left = 0

  nums.each_with_index do |num, right|
    product *= num

    while product >= k
      product /= nums[left]
      left += 1
    end

    # [left, right] の範囲で right を終端とする部分配列の数
    count += right - left + 1
  end

  count
end

# 解法2: すべての部分配列を列挙
def find_all_subarray_product_less_than_k(nums, k)
  result = []

  nums.length.times do |i|
    product = 1

    (i...nums.length).each do |j|
      product *= nums[j]

      break if product >= k

      result << nums[i..j]
    end
  end

  result
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 部分配列の積がK未満 テスト ==='
  puts

  # テストケース1: 通常のケース
  result1 = num_subarray_product_less_than_k([10, 5, 2, 6], 100)
  puts 'Test 1: num_subarray_product_less_than_k([10, 5, 2, 6], 100)'
  puts "結果: #{result1}"
  puts '期待値: 8'
  puts "判定: #{result1 == 8 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: k=0
  result2 = num_subarray_product_less_than_k([1, 2, 3], 0)
  puts 'Test 2: num_subarray_product_less_than_k([1, 2, 3], 0)'
  puts "結果: #{result2}"
  puts '期待値: 0'
  puts "判定: #{result2 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 全て条件を満たす
  result3 = num_subarray_product_less_than_k([1, 1, 1], 10)
  puts 'Test 3: num_subarray_product_less_than_k([1, 1, 1], 10)'
  puts "結果: #{result3}"
  puts '期待値: 6 ([1], [1], [1], [1,1], [1,1], [1,1,1])'
  puts "判定: #{result3 == 6 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（全ての部分配列）
  puts '--- 解法2（全ての部分配列）のテスト ---'
  result4 = find_all_subarray_product_less_than_k([10, 5, 2, 6], 100)
  puts 'find_all_subarray_product_less_than_k([10, 5, 2, 6], 100)'
  puts "結果の数: #{result4.length}"
  puts '期待値: 8個の部分配列'
  puts "判定: #{result4.length == 8 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
