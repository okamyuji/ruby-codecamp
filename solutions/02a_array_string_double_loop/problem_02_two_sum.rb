#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: Two Sum（ペアの和が目標値と一致）
# ファイル: 02a_array_string_double_loop.md
# ============================================================================
#
# 整数の配列と目標値が与えられます。配列内の2つの数の和が目標値と一致するような
# インデックスのペアを返してください。各入力には必ず1つの解が存在すると仮定します。
#
# 入力例:
#   nums = [2, 7, 11, 15]
#   target = 9
# 出力例: [0, 1]  # nums[0] + nums[1] = 2 + 7 = 9
#
# 時間計算量: O(n²) - 二重ループ版、O(n) - ハッシュテーブル版
# 空間計算量: O(1) - 二重ループ版、O(n) - ハッシュテーブル版
# ============================================================================

# 解法1: 二重ループ（O(n²)）
def two_sum_brute_force(nums, target)
  nums.each_with_index do |num1, i|
    ((i + 1)...nums.length).each do |j|
      return [i, j] if num1 + nums[j] == target
    end
  end

  nil
end

# 解法2: ハッシュテーブル（O(n)、推奨）
def two_sum(nums, target)
  hash = {}

  nums.each_with_index do |num, i|
    complement = target - num
    return [hash[complement], i] if hash.key?(complement)

    hash[num] = i
  end

  nil
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== Two Sum テスト ==='
  puts

  # テストケース1: 通常のケース
  result1 = two_sum([2, 7, 11, 15], 9)
  puts 'Test 1: two_sum([2, 7, 11, 15], 9)'
  puts "結果: #{result1}"
  puts '期待値: [0, 1]'
  puts "判定: #{result1 == [0, 1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 後方のペア
  result2 = two_sum([2, 7, 11, 15], 26)
  puts 'Test 2: two_sum([2, 7, 11, 15], 26)'
  puts "結果: #{result2}"
  puts '期待値: [2, 3]'
  puts "判定: #{result2 == [2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 負の数を含む
  result3 = two_sum([-1, -2, -3, -4, -5], -8)
  puts 'Test 3: two_sum([-1, -2, -3, -4, -5], -8)'
  puts "結果: #{result3}"
  puts '期待値: [2, 4] (-3 + -5 = -8)'
  puts "判定: #{result3 == [2, 4] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 同じ値を含む
  result4 = two_sum([3, 3], 6)
  puts 'Test 4: two_sum([3, 3], 6)'
  puts "結果: #{result4}"
  puts '期待値: [0, 1]'
  puts "判定: #{result4 == [0, 1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法1のテスト（二重ループ）
  puts '--- 解法1（二重ループ）のテスト ---'
  result5 = two_sum_brute_force([2, 7, 11, 15], 9)
  puts "two_sum_brute_force([2, 7, 11, 15], 9) = #{result5}"
  puts "判定: #{result5 == [0, 1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result6 = two_sum_brute_force([2, 7, 11, 15], 26)
  puts "two_sum_brute_force([2, 7, 11, 15], 26) = #{result6}"
  puts "判定: #{result6 == [2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
