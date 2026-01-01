#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 単調増加スタック - 次に小さい要素
# ファイル: 02e_array_string_stack.md
# ============================================================================
#
# 整数の配列が与えられます。各要素について、その右側で最初に現れる、その要素より小さい要素を
# 見つけてください。存在しない場合は-1を返します。
#
# 入力例: [4, 5, 2, 10, 8]
# 出力例: [2, 2, -1, 8, -1]
#
# 時間計算量: O(n)
# 空間計算量: O(n)
# ============================================================================

# 解法1: 単調増加スタック
def next_smaller_element(nums)
  n = nums.length
  result = Array.new(n, -1)
  stack = []

  nums.each_with_index do |num, i|
    while !stack.empty? && nums[stack.last] > num
      idx = stack.pop
      result[idx] = num
    end

    stack << i
  end

  result
end

# 解法2: 右から左へスキャン
def next_smaller_element_reverse(nums)
  n = nums.length
  result = Array.new(n, -1)
  stack = []

  (n - 1).downto(0) do |i|
    stack.pop while !stack.empty? && stack.last >= nums[i]

    result[i] = stack.last unless stack.empty?
    stack << nums[i]
  end

  result
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 単調増加スタック - 次に小さい要素 テスト ==='
  puts

  # テストケース1: 通常のケース
  result1 = next_smaller_element([4, 5, 2, 10, 8])
  puts 'Test 1: next_smaller_element([4, 5, 2, 10, 8])'
  puts "結果: #{result1}"
  puts '期待値: [2, 2, -1, 8, -1]'
  expected1 = [2, 2, -1, 8, -1]
  puts "判定: #{result1 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 降順
  result2 = next_smaller_element([3, 2, 1, 4, 5])
  puts 'Test 2: next_smaller_element([3, 2, 1, 4, 5])'
  puts "結果: #{result2}"
  puts '期待値: [2, 1, -1, -1, -1]'
  expected2 = [2, 1, -1, -1, -1]
  puts "判定: #{result2 == expected2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 昇順
  result3 = next_smaller_element([1, 2, 3, 4, 5])
  puts 'Test 3: next_smaller_element([1, 2, 3, 4, 5])'
  puts "結果: #{result3}"
  puts '期待値: [-1, -1, -1, -1, -1]'
  expected3 = [-1, -1, -1, -1, -1]
  puts "判定: #{result3 == expected3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（右から左）
  puts '--- 解法2（右から左）のテスト ---'
  result4 = next_smaller_element_reverse([4, 5, 2, 10, 8])
  puts "next_smaller_element_reverse([4, 5, 2, 10, 8]) = #{result4}"
  puts "判定: #{result4 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = next_smaller_element_reverse([3, 2, 1, 4, 5])
  puts "next_smaller_element_reverse([3, 2, 1, 4, 5]) = #{result5}"
  puts "判定: #{result5 == expected2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
