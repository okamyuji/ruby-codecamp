#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 最長の連続する数列
# ファイル: 02b_array_string_hashtable.md
# ============================================================================
#
# ソートされていない整数配列が与えられます。最長の連続する数列の長さを求めてください。
#
# 入力例: [100, 4, 200, 1, 3, 2]
# 出力例: 4  # [1, 2, 3, 4]
#
# 時間計算量: O(n)
# 空間計算量: O(n)
# ============================================================================

# 解法1: セットを使用（O(n)、推奨）
def longest_consecutive(nums)
  return 0 if nums.empty?

  num_set = nums.to_set
  longest = 0

  num_set.each do |num|
    # num - 1が存在しない場合のみ、連続数列の開始点
    next if num_set.include?(num - 1)

    current_num = num
    current_length = 1

    # 連続する数をカウント
    while num_set.include?(current_num + 1)
      current_num += 1
      current_length += 1
    end

    longest = [longest, current_length].max
  end

  longest
end

# 解法2: ソートして探索（O(n log n)）
def longest_consecutive_sort(nums)
  return 0 if nums.empty?

  sorted = nums.uniq.sort
  longest = 1
  current_length = 1

  (1...sorted.length).each do |i|
    if sorted[i] == sorted[i - 1] + 1
      current_length += 1
      longest = [longest, current_length].max
    else
      current_length = 1
    end
  end

  longest
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 最長の連続する数列 テスト ==='
  puts

  # テストケース1: 通常のケース
  result1 = longest_consecutive([100, 4, 200, 1, 3, 2])
  puts 'Test 1: longest_consecutive([100, 4, 200, 1, 3, 2])'
  puts "結果: #{result1}"
  puts '期待値: 4 ([1, 2, 3, 4])'
  puts "判定: #{result1 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 長い連続数列
  result2 = longest_consecutive([0, 3, 7, 2, 5, 8, 4, 6, 0, 1])
  puts 'Test 2: longest_consecutive([0, 3, 7, 2, 5, 8, 4, 6, 0, 1])'
  puts "結果: #{result2}"
  puts '期待値: 9 ([0, 1, 2, 3, 4, 5, 6, 7, 8])'
  puts "判定: #{result2 == 9 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 空配列
  result3 = longest_consecutive([])
  puts 'Test 3: longest_consecutive([])'
  puts "結果: #{result3}"
  puts '期待値: 0'
  puts "判定: #{result3 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 単一要素
  result4 = longest_consecutive([1])
  puts 'Test 4: longest_consecutive([1])'
  puts "結果: #{result4}"
  puts '期待値: 1'
  puts "判定: #{result4 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース5: 連続しない数列
  result5 = longest_consecutive([1, 3, 5, 7])
  puts 'Test 5: longest_consecutive([1, 3, 5, 7])'
  puts "結果: #{result5}"
  puts '期待値: 1'
  puts "判定: #{result5 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（ソート）
  puts '--- 解法2（ソート）のテスト ---'
  result6 = longest_consecutive_sort([100, 4, 200, 1, 3, 2])
  puts "longest_consecutive_sort([100, 4, 200, 1, 3, 2]) = #{result6}"
  puts "判定: #{result6 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
