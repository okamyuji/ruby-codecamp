#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 最大長方形の面積（ヒストグラム）
# ファイル: 02e_array_string_stack.md
# ============================================================================
#
# 各バーの高さを表す整数の配列が与えられます。ヒストグラムにおける最大の長方形の面積を
# 求めてください。
#
# 入力例: [2, 1, 5, 6, 2, 3]
# 出力例: 10  # インデックス2-3の高さ5の長方形（5 * 2 = 10）
#
# 時間計算量: O(n)
# 空間計算量: O(n)
# ============================================================================

# 解法1: 単調増加スタック
def largest_rectangle_area(heights)
  stack = []
  max_area = 0
  heights << 0 # 番兵を追加

  heights.each_with_index do |h, i|
    while !stack.empty? && heights[stack.last] > h
      height_idx = stack.pop
      height = heights[height_idx]
      width = stack.empty? ? i : i - stack.last - 1
      area = height * width
      max_area = [max_area, area].max
    end

    stack << i
  end

  heights.pop # 番兵を削除
  max_area
end

# 解法2: スタックなし（分割統治）
def largest_rectangle_area_divide_conquer(heights)
  return 0 if heights.empty?

  helper(heights, 0, heights.length - 1)
end

def helper(heights, left, right)
  return 0 if left > right

  # 最小の高さのインデックスを見つける
  min_idx = left
  (left..right).each do |i|
    min_idx = i if heights[i] < heights[min_idx]
  end

  # 3つの選択肢の最大値
  # 1. 最小高さを含む長方形
  # 2. 左部分の最大
  # 3. 右部分の最大
  [
    heights[min_idx] * (right - left + 1),
    helper(heights, left, min_idx - 1),
    helper(heights, min_idx + 1, right)
  ].max
end

# 解法3: 左右の境界を事前計算
def largest_rectangle_area_precompute(heights)
  n = heights.length
  return 0 if n.zero?

  # 各バーについて、左側の小さいバーと右側の小さいバーを見つける
  left = Array.new(n)
  right = Array.new(n)

  # 左側の境界
  left[0] = -1
  (1...n).each do |i|
    p = i - 1
    p = left[p] while p >= 0 && heights[p] >= heights[i]
    left[i] = p
  end

  # 右側の境界
  right[n - 1] = n
  (n - 2).downto(0) do |i|
    p = i + 1
    p = right[p] while p < n && heights[p] >= heights[i]
    right[i] = p
  end

  # 最大面積を計算
  max_area = 0
  n.times do |i|
    width = right[i] - left[i] - 1
    area = heights[i] * width
    max_area = [max_area, area].max
  end

  max_area
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 最大長方形の面積（ヒストグラム） テスト ==='
  puts

  # テストケース1: 通常のケース
  result1 = largest_rectangle_area([2, 1, 5, 6, 2, 3].dup)
  puts 'Test 1: largest_rectangle_area([2, 1, 5, 6, 2, 3])'
  puts "結果: #{result1}"
  puts '期待値: 10'
  puts "判定: #{result1 == 10 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 2つのバー
  result2 = largest_rectangle_area([2, 4].dup)
  puts 'Test 2: largest_rectangle_area([2, 4])'
  puts "結果: #{result2}"
  puts '期待値: 4'
  puts "判定: #{result2 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 同じ高さ
  result3 = largest_rectangle_area([1, 1].dup)
  puts 'Test 3: largest_rectangle_area([1, 1])'
  puts "結果: #{result3}"
  puts '期待値: 2'
  puts "判定: #{result3 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 別のケース
  result4 = largest_rectangle_area([2, 1, 2].dup)
  puts 'Test 4: largest_rectangle_area([2, 1, 2])'
  puts "結果: #{result4}"
  puts '期待値: 3'
  puts "判定: #{result4 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（分割統治）
  puts '--- 解法2（分割統治）のテスト ---'
  result5 = largest_rectangle_area_divide_conquer([2, 1, 5, 6, 2, 3])
  puts "largest_rectangle_area_divide_conquer([2, 1, 5, 6, 2, 3]) = #{result5}"
  puts "判定: #{result5 == 10 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（事前計算）
  puts '--- 解法3（事前計算）のテスト ---'
  result6 = largest_rectangle_area_precompute([2, 1, 5, 6, 2, 3])
  puts "largest_rectangle_area_precompute([2, 1, 5, 6, 2, 3]) = #{result6}"
  puts "判定: #{result6 == 10 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
