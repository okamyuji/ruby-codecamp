#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 製品の配列（自分以外）
# ファイル: 02f_array_string_prefix_sum.md
# ============================================================================
#
# 整数の配列が与えられます。output[i]がnums[i]以外のすべての要素の積になるような配列を
# 返してください。除算を使わずにO(n)で解いてください。
#
# 入力例: [1, 2, 3, 4]
# 出力例: [24, 12, 8, 6]
#
# 時間計算量: O(n)
# 空間計算量: O(1) - 出力配列を除く
# ============================================================================

# 解法1: 2パス（O(1)空間）
def product_except_self(nums)
  n = nums.length
  result = Array.new(n)

  # 左からの累積積
  left_product = 1
  n.times do |i|
    result[i] = left_product
    left_product *= nums[i]
  end

  # 右からの累積積を掛ける
  right_product = 1
  (n - 1).downto(0) do |i|
    result[i] *= right_product
    right_product *= nums[i]
  end

  result
end

# 解法2: 左右の配列を明示的に作成（理解しやすい）
def product_except_self_explicit(nums)
  n = nums.length
  left = Array.new(n, 1)
  right = Array.new(n, 1)

  # 左からの累積積
  (1...n).each do |i|
    left[i] = left[i - 1] * nums[i - 1]
  end

  # 右からの累積積
  (n - 2).downto(0) do |i|
    right[i] = right[i + 1] * nums[i + 1]
  end

  # 組み合わせ
  n.times.map { |i| left[i] * right[i] }
end

# 解法3: 除算を使用（0がある場合に注意）
def product_except_self_division(nums)
  total_product = nums.reduce(1, :*)
  zero_count = nums.count(0)

  if zero_count > 1
    return Array.new(nums.length, 0)
  elsif zero_count == 1
    return nums.map { |num| num.zero? ? total_product : 0 }
  end

  nums.map { |num| total_product / num }
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 製品の配列（自分以外） テスト ==='
  puts

  # テストケース1: 通常のケース
  result1 = product_except_self([1, 2, 3, 4])
  puts 'Test 1: product_except_self([1, 2, 3, 4])'
  puts "結果: #{result1}"
  puts '期待値: [24, 12, 8, 6]'
  expected1 = [24, 12, 8, 6]
  puts "判定: #{result1 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 0を2つ含む
  result2 = product_except_self([0, 0])
  puts 'Test 2: product_except_self([0, 0])'
  puts "結果: #{result2}"
  puts '期待値: [0, 0]'
  puts "判定: #{result2 == [0, 0] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 0を複数含む
  result3 = product_except_self([0, 4, 0])
  puts 'Test 3: product_except_self([0, 4, 0])'
  puts "結果: #{result3}"
  puts '期待値: [0, 0, 0]'
  puts "判定: #{result3 == [0, 0, 0] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 0を1つ含む
  result4 = product_except_self([1, 0])
  puts 'Test 4: product_except_self([1, 0])'
  puts "結果: #{result4}"
  puts '期待値: [0, 1]'
  puts "判定: #{result4 == [0, 1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（明示的）
  puts '--- 解法2（明示的）のテスト ---'
  result5 = product_except_self_explicit([1, 2, 3, 4])
  puts "product_except_self_explicit([1, 2, 3, 4]) = #{result5}"
  puts "判定: #{result5 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（除算使用）
  puts '--- 解法3（除算使用）のテスト ---'
  result6 = product_except_self_division([1, 2, 3, 4])
  puts "product_except_self_division([1, 2, 3, 4]) = #{result6}"
  puts "判定: #{result6 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
