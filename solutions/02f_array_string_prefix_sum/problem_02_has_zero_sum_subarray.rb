#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 部分配列の合計が0
# ファイル: 02f_array_string_prefix_sum.md
# ============================================================================
#
# 整数の配列が与えられます。合計が0になる部分配列が存在するかどうかを判定してください。
#
# 入力例: [4, 2, -3, 1, 6]
# 出力例: true  # [2, -3, 1] の合計が0
#
# 時間計算量: O(n)
# 空間計算量: O(n)
# ============================================================================

# 解法1: ハッシュセットを使用
def has_zero_sum_subarray(nums)
  sum = 0
  seen = Set.new([0])

  nums.each do |num|
    sum += num

    return true if seen.include?(sum)

    seen << sum
  end

  false
end

# 解法2: ハッシュを使用（インデックスも記録）
def find_zero_sum_subarray(nums)
  sum = 0
  sum_map = { 0 => -1 }

  nums.each_with_index do |num, i|
    sum += num

    if sum_map.key?(sum)
      start_idx = sum_map[sum] + 1
      return [start_idx, i]
    end

    sum_map[sum] = i
  end

  nil
end

# 解法3: すべての0合計部分配列を見つける
def find_all_zero_sum_subarrays(nums)
  result = []
  sum = 0
  sum_map = Hash.new { |h, k| h[k] = [] }
  sum_map[0] << -1

  nums.each_with_index do |num, i|
    sum += num

    if sum_map.key?(sum)
      sum_map[sum].each do |start_idx|
        result << [start_idx + 1, i]
      end
    end

    sum_map[sum] << i
  end

  result
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 部分配列の合計が0 テスト ==='
  puts

  # テストケース1: 存在する
  result1 = has_zero_sum_subarray([4, 2, -3, 1, 6])
  puts 'Test 1: has_zero_sum_subarray([4, 2, -3, 1, 6])'
  puts "結果: #{result1}"
  puts '期待値: true ([2, -3, 1]の合計が0)'
  puts "判定: #{result1 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 0を含む
  result2 = has_zero_sum_subarray([4, 2, 0, 1, 6])
  puts 'Test 2: has_zero_sum_subarray([4, 2, 0, 1, 6])'
  puts "結果: #{result2}"
  puts '期待値: true (0単体)'
  puts "判定: #{result2 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 存在しない
  result3 = has_zero_sum_subarray([1, 2, 3])
  puts 'Test 3: has_zero_sum_subarray([1, 2, 3])'
  puts "結果: #{result3}"
  puts '期待値: false'
  puts "判定: #{result3 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（インデックスを返す）
  puts '--- 解法2（インデックスを返す）のテスト ---'
  result4 = find_zero_sum_subarray([4, 2, -3, 1, 6])
  puts "find_zero_sum_subarray([4, 2, -3, 1, 6]) = #{result4}"
  puts '期待値: [1, 3] (インデックス1から3: 2 + (-3) + 1 = 0)'
  puts "判定: #{result4 == [1, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（全ての0合計部分配列）
  puts '--- 解法3（全ての0合計部分配列）のテスト ---'
  result5 = find_all_zero_sum_subarrays([1, 2, -3, 3, -1, -1])
  puts "find_all_zero_sum_subarrays([1, 2, -3, 3, -1, -1]) = #{result5}"
  puts '期待値: [[0, 2], [2, 3], [1, 5]] など（複数の0合計部分配列）'
  # 少なくとも3つの部分配列が見つかることを確認
  puts "判定: #{result5.length >= 3 ? '✓ PASS' : '✗ FAIL'} (#{result5.length}個の部分配列)"
  puts

  puts '=== 完了 ==='
end
