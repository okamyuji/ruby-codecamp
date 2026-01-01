#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 次に大きい要素
# ファイル: 02e_array_string_stack.md
# ============================================================================
#
# 整数の配列が与えられます。各要素について、その右側で最初に現れる、その要素より大きい要素を
# 見つけてください。存在しない場合は-1を返します。
#
# 入力例: [4, 5, 2, 10, 8]
# 出力例: [5, 10, 10, -1, -1]
#
# 時間計算量: O(n)
# 空間計算量: O(n)
# ============================================================================

# 解法1: 単調減少スタック
def next_greater_element(nums)
  n = nums.length
  result = Array.new(n, -1)
  stack = [] # インデックスを格納

  nums.each_with_index do |num, i|
    # 現在の要素より小さいスタック上の要素を解決
    while !stack.empty? && nums[stack.last] < num
      idx = stack.pop
      result[idx] = num
    end

    stack << i
  end

  result
end

# 解法2: 右から左へスキャン
def next_greater_element_reverse(nums)
  n = nums.length
  result = Array.new(n, -1)
  stack = []

  (n - 1).downto(0) do |i|
    # 現在の要素以下のスタック上の要素を削除
    stack.pop while !stack.empty? && stack.last <= nums[i]

    result[i] = stack.last unless stack.empty?
    stack << nums[i]
  end

  result
end

# 解法3: ブルートフォース（比較用）
def next_greater_element_brute(nums)
  nums.map.with_index do |num, i|
    found = -1

    ((i + 1)...nums.length).each do |j|
      if nums[j] > num
        found = nums[j]
        break
      end
    end

    found
  end
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 次に大きい要素 テスト ==='
  puts

  # テストケース1: 通常のケース
  result1 = next_greater_element([4, 5, 2, 10, 8])
  puts 'Test 1: next_greater_element([4, 5, 2, 10, 8])'
  puts "結果: #{result1}"
  puts '期待値: [5, 10, 10, -1, -1]'
  expected1 = [5, 10, 10, -1, -1]
  puts "判定: #{result1 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 昇順
  result2 = next_greater_element([1, 2, 3, 4, 5])
  puts 'Test 2: next_greater_element([1, 2, 3, 4, 5])'
  puts "結果: #{result2}"
  puts '期待値: [2, 3, 4, 5, -1]'
  expected2 = [2, 3, 4, 5, -1]
  puts "判定: #{result2 == expected2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 降順
  result3 = next_greater_element([5, 4, 3, 2, 1])
  puts 'Test 3: next_greater_element([5, 4, 3, 2, 1])'
  puts "結果: #{result3}"
  puts '期待値: [-1, -1, -1, -1, -1]'
  expected3 = [-1, -1, -1, -1, -1]
  puts "判定: #{result3 == expected3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（右から左）
  puts '--- 解法2（右から左）のテスト ---'
  result4 = next_greater_element_reverse([4, 5, 2, 10, 8])
  puts "next_greater_element_reverse([4, 5, 2, 10, 8]) = #{result4}"
  puts "判定: #{result4 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（ブルートフォース）
  puts '--- 解法3（ブルートフォース）のテスト ---'
  result5 = next_greater_element_brute([4, 5, 2, 10, 8])
  puts "next_greater_element_brute([4, 5, 2, 10, 8]) = #{result5}"
  puts "判定: #{result5 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
