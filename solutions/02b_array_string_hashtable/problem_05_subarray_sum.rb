#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 部分配列の和が目標値と一致
# ファイル: 02b_array_string_hashtable.md
# ============================================================================
#
# 整数の配列と目標値が与えられます。連続する部分配列の和が目標値と一致する
# 部分配列が存在するかを判定してください。
#
# 入力例:
#   nums = [1, 2, 3, 7, 5]
#   target = 12
# 出力例: true  # [7, 5] の和が12
#
# 時間計算量: O(n)
# 空間計算量: O(n)
# ============================================================================

# 解法1: 累積和とハッシュセット
def subarray_sum_exists(nums, target)
  sum = 0
  seen = Set.new([0]) # 累積和0を初期状態

  nums.each do |num|
    sum += num

    # sum - target が存在すれば、その間の和がtarget
    return true if seen.include?(sum - target)

    seen.add(sum)
  end

  false
end

# 解法2: インデックスを返す版
def subarray_sum_indices(nums, target)
  sum = 0
  sum_indices = { 0 => -1 } # 累積和 => インデックス

  nums.each_with_index do |num, i|
    sum += num

    if sum_indices.key?(sum - target)
      # 部分配列のインデックス範囲を返す
      start_idx = sum_indices[sum - target] + 1
      return [start_idx, i]
    end

    sum_indices[sum] = i
  end

  nil
end

# 解法3: 二重ループ（O(n²)、効率悪い）
def subarray_sum_brute_force(nums, target)
  (0...nums.length).each do |i|
    sum = 0
    (i...nums.length).each do |j|
      sum += nums[j]
      return true if sum == target
    end
  end

  false
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 部分配列の和が目標値と一致 テスト ==='
  puts

  # テストケース1: 存在する（[7, 5]）
  result1 = subarray_sum_exists([1, 2, 3, 7, 5], 12)
  puts 'Test 1: subarray_sum_exists([1, 2, 3, 7, 5], 12)'
  puts "結果: #{result1}"
  puts '期待値: true ([7, 5]の和が12)'
  puts "判定: #{result1 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 存在しない
  result2 = subarray_sum_exists([1, 2, 3, 4], 100)
  puts 'Test 2: subarray_sum_exists([1, 2, 3, 4], 100)'
  puts "結果: #{result2}"
  puts '期待値: false'
  puts "判定: #{result2 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 負の数を含む
  result3 = subarray_sum_exists([1, -1, 0], 0)
  puts 'Test 3: subarray_sum_exists([1, -1, 0], 0)'
  puts "結果: #{result3}"
  puts '期待値: true'
  puts "判定: #{result3 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（インデックスを返す）
  puts '--- 解法2（インデックスを返す）のテスト ---'
  result4 = subarray_sum_indices([1, 2, 3, 7, 5], 12)
  puts "subarray_sum_indices([1, 2, 3, 7, 5], 12) = #{result4}"
  puts '期待値: [1, 3] (インデックス1から3: 2+3+7=12)'
  puts "判定: #{result4 == [1, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = subarray_sum_indices([1, 2, 3, 4], 6)
  puts "subarray_sum_indices([1, 2, 3, 4], 6) = #{result5}"
  puts '期待値: [0, 2] (インデックス0から2: 1+2+3=6)'
  puts "判定: #{result5 == [0, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（二重ループ）
  puts '--- 解法3（二重ループ）のテスト ---'
  result6 = subarray_sum_brute_force([1, 2, 3, 7, 5], 12)
  puts "subarray_sum_brute_force([1, 2, 3, 7, 5], 12) = #{result6}"
  puts "判定: #{result6 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
