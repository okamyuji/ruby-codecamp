#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 行列の積
# ファイル: 02d_array_string_2d_matrix.md
# ============================================================================
#
# 2つの行列 A (m × k) と B (k × n) が与えられます。行列の積 C = A × B を計算してください。
#
# 入力例:
#   A = [[1, 2, 3],
#        [4, 5, 6]]
#
#   B = [[7, 8],
#        [9, 10],
#        [11, 12]]
#
# 出力例:
#   [[58, 64],
#    [139, 154]]
#
# 時間計算量: O(m × k × n)
# 空間計算量: O(m × n)
# ============================================================================

# 解法1: 基本的な行列の積
def matrix_multiply(a, b)
  m = a.length
  k = a[0].length
  n = b[0].length

  c = Array.new(m) { Array.new(n, 0) }

  m.times do |i|
    n.times do |j|
      k.times do |p|
        c[i][j] += a[i][p] * b[p][j]
      end
    end
  end

  c
end

# 解法2: zipとreduceを使用
def matrix_multiply_functional(a, b)
  b_t = b.transpose

  a.map do |row_a|
    b_t.map do |col_b|
      row_a.zip(col_b).map { |x, y| x * y }.sum
    end
  end
end

# 解法3: 疎行列の積（0が多い場合に最適）
def matrix_multiply_sparse(a, b)
  m = a.length
  k = a[0].length
  n = b[0].length

  c = Array.new(m) { Array.new(n, 0) }

  m.times do |i|
    k.times do |p|
      next if a[i][p].zero? # 0なら計算をスキップ

      n.times do |j|
        c[i][j] += a[i][p] * b[p][j]
      end
    end
  end

  c
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 行列の積 テスト ==='
  puts

  # テストケース1: 2×3 と 3×2
  a1 = [[1, 2, 3], [4, 5, 6]]
  b1 = [[7, 8], [9, 10], [11, 12]]
  result1 = matrix_multiply(a1, b1)
  puts 'Test 1: matrix_multiply([[1, 2, 3], [4, 5, 6]], [[7, 8], [9, 10], [11, 12]])'
  puts "結果: #{result1}"
  puts '期待値: [[58, 64], [139, 154]]'
  expected1 = [[58, 64], [139, 154]]
  puts "判定: #{result1 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 2×2 と 2×2
  a2 = [[1, 2], [3, 4]]
  b2 = [[2, 0], [1, 2]]
  result2 = matrix_multiply(a2, b2)
  puts 'Test 2: matrix_multiply([[1, 2], [3, 4]], [[2, 0], [1, 2]])'
  puts "結果: #{result2}"
  puts '期待値: [[4, 4], [10, 8]]'
  expected2 = [[4, 4], [10, 8]]
  puts "判定: #{result2 == expected2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 単位行列
  a3 = [[1, 0], [0, 1]]
  b3 = [[5, 6], [7, 8]]
  result3 = matrix_multiply(a3, b3)
  puts 'Test 3: matrix_multiply([[1, 0], [0, 1]], [[5, 6], [7, 8]])'
  puts "結果: #{result3}"
  puts '期待値: [[5, 6], [7, 8]]'
  puts "判定: #{result3 == [[5, 6], [7, 8]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（関数型）
  puts '--- 解法2（関数型）のテスト ---'
  result4 = matrix_multiply_functional(a1, b1)
  puts "matrix_multiply_functional(a1, b1) = #{result4}"
  puts "判定: #{result4 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（疎行列）
  puts '--- 解法3（疎行列）のテスト ---'
  result5 = matrix_multiply_sparse(a1, b1)
  puts "matrix_multiply_sparse(a1, b1) = #{result5}"
  puts "判定: #{result5 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
