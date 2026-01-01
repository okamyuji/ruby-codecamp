#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 合計がKの部分配列の数
# ファイル: 02f_array_string_prefix_sum.md
# ============================================================================
#
# 整数の配列と整数kが与えられます。合計がkになる連続する部分配列の数を返してください。
#
# 入力例:
#   nums = [1, 1, 1], k = 2
# 出力例: 2  # [1, 1] が2回
#
# 時間計算量: O(n)
# 空間計算量: O(n)
# ============================================================================

# 解法1: ハッシュマップを使用
def subarray_sum(nums, k)
  count = 0
  sum = 0
  sum_map = Hash.new(0)
  sum_map[0] = 1

  nums.each do |num|
    sum += num

    # sum - k が存在すれば、その部分配列を除いた残りがk
    count += sum_map[sum - k] if sum_map.key?(sum - k)

    sum_map[sum] += 1
  end

  count
end

# 解法2: すべての部分配列のインデックスを見つける
def find_subarray_sum_indices(nums, k)
  result = []
  sum = 0
  sum_map = Hash.new { |h, key| h[key] = [] }
  sum_map[0] << -1

  nums.each_with_index do |num, i|
    sum += num

    if sum_map.key?(sum - k)
      sum_map[sum - k].each do |start_idx|
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
  puts '=== 合計がKの部分配列の数 テスト ==='
  puts

  # テストケース1: 2つの部分配列
  result1 = subarray_sum([1, 1, 1], 2)
  puts 'Test 1: subarray_sum([1, 1, 1], 2)'
  puts "結果: #{result1}"
  puts '期待値: 2 ([1, 1]が2回)'
  puts "判定: #{result1 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 1つの部分配列
  result2 = subarray_sum([1, 2, 3], 3)
  puts 'Test 2: subarray_sum([1, 2, 3], 3)'
  puts "結果: #{result2}"
  puts '期待値: 2 ([1, 2]と[3])'
  puts "判定: #{result2 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 負の数を含む
  result3 = subarray_sum([1, -1, 0], 0)
  puts 'Test 3: subarray_sum([1, -1, 0], 0)'
  puts "結果: #{result3}"
  puts '期待値: 3 ([1, -1], [0], [1, -1, 0])'
  puts "判定: #{result3 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 存在しない
  result4 = subarray_sum([1, 2, 3], 10)
  puts 'Test 4: subarray_sum([1, 2, 3], 10)'
  puts "結果: #{result4}"
  puts '期待値: 0'
  puts "判定: #{result4 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（インデックスを返す）
  puts '--- 解法2（インデックスを返す）のテスト ---'
  result5 = find_subarray_sum_indices([1, 1, 1], 2)
  puts "find_subarray_sum_indices([1, 1, 1], 2) = #{result5}"
  puts '期待値: [[0, 1], [1, 2]]'
  expected5 = [[0, 1], [1, 2]]
  puts "判定: #{result5 == expected5 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result6 = find_subarray_sum_indices([1, 2, 3], 3)
  puts "find_subarray_sum_indices([1, 2, 3], 3) = #{result6}"
  puts '期待値: [[0, 1], [2, 2]]'
  expected6 = [[0, 1], [2, 2]]
  puts "判定: #{result6 == expected6 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
