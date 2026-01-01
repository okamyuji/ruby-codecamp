#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 固定サイズのウィンドウの最大合計
# ファイル: 02h_array_string_sliding_window.md
# ============================================================================
#
# 整数の配列とサイズkが与えられます。サイズkの連続する部分配列の最大合計を返してください。
#
# 入力例:
#   nums = [2, 1, 5, 1, 3, 2], k = 3
# 出力例: 9  # [5, 1, 3]
#
# 時間計算量: O(n)
# 空間計算量: O(1)
# ============================================================================

# 解法1: Sliding Window
def max_sum_subarray(nums, k)
  return 0 if nums.length < k

  # 最初のウィンドウの合計
  window_sum = nums[0...k].sum
  max_sum = window_sum

  # ウィンドウをスライド
  (k...nums.length).each do |i|
    window_sum = window_sum - nums[i - k] + nums[i]
    max_sum = [max_sum, window_sum].max
  end

  max_sum
end

# 解法2: インデックスも返す
def max_sum_subarray_with_index(nums, k)
  return { sum: 0, start: 0, end: 0 } if nums.length < k

  window_sum = nums[0...k].sum
  max_sum = window_sum
  max_start = 0

  (k...nums.length).each do |i|
    window_sum = window_sum - nums[i - k] + nums[i]

    if window_sum > max_sum
      max_sum = window_sum
      max_start = i - k + 1
    end
  end

  { sum: max_sum, start: max_start, end: max_start + k - 1 }
end

# 解法3: ブルートフォース（比較用）
def max_sum_subarray_brute(nums, k)
  return 0 if nums.length < k

  max_sum = -Float::INFINITY

  (nums.length - k + 1).times do |i|
    current_sum = nums[i, k].sum
    max_sum = [max_sum, current_sum].max
  end

  max_sum
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 固定サイズのウィンドウの最大合計 テスト ==='
  puts

  # テストケース1: 通常のケース
  result1 = max_sum_subarray([2, 1, 5, 1, 3, 2], 3)
  puts 'Test 1: max_sum_subarray([2, 1, 5, 1, 3, 2], 3)'
  puts "結果: #{result1}"
  puts '期待値: 9 ([5, 1, 3])'
  puts "判定: #{result1 == 9 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 別のケース
  result2 = max_sum_subarray([2, 3, 4, 1, 5], 2)
  puts 'Test 2: max_sum_subarray([2, 3, 4, 1, 5], 2)'
  puts "結果: #{result2}"
  puts '期待値: 7 ([3, 4])'
  puts "判定: #{result2 == 7 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 大きなウィンドウ
  result3 = max_sum_subarray([1, 4, 2, 10, 23, 3, 1, 0, 20], 4)
  puts 'Test 3: max_sum_subarray([1, 4, 2, 10, 23, 3, 1, 0, 20], 4)'
  puts "結果: #{result3}"
  puts '期待値: 39 ([4, 2, 10, 23])'
  puts "判定: #{result3 == 39 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（インデックス付き）
  puts '--- 解法2（インデックス付き）のテスト ---'
  result4 = max_sum_subarray_with_index([2, 1, 5, 1, 3, 2], 3)
  puts "max_sum_subarray_with_index([2, 1, 5, 1, 3, 2], 3) = #{result4}"
  puts '期待値: { sum: 9, start: 2, end: 4 }'
  puts "判定: #{result4 == { sum: 9, start: 2, end: 4 } ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（ブルートフォース）
  puts '--- 解法3（ブルートフォース）のテスト ---'
  result5 = max_sum_subarray_brute([2, 1, 5, 1, 3, 2], 3)
  puts "max_sum_subarray_brute([2, 1, 5, 1, 3, 2], 3) = #{result5}"
  puts "判定: #{result5 == 9 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
