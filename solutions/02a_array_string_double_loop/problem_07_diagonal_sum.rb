#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 行列の対角線の和
# ファイル: 02a_array_string_double_loop.md
# ============================================================================
#
# n × n の正方行列が与えられます。主対角線と副対角線の要素の和を求めてください。
# ただし、中央の要素が重複する場合は1回だけカウントします。
#
# 入力例:
#   [[1, 2, 3],
#    [4, 5, 6],
#    [7, 8, 9]]
#
# 出力例: 25  # 1+5+9+3+7 = 25
#
# 時間計算量: O(n) - 対角線の要素数
# 空間計算量: O(1)
# ============================================================================

# 解法1: 効率的な1パス実装
def diagonal_sum(matrix)
  n = matrix.length
  sum = 0

  n.times do |i|
    # 主対角線
    sum += matrix[i][i]
    # 副対角線
    sum += matrix[i][n - 1 - i]
  end

  # nが奇数の場合、中央要素が重複するので引く
  sum -= matrix[n / 2][n / 2] if n.odd?

  sum
end

# 解法2: 二重ループで条件チェック
def diagonal_sum_loop(matrix)
  n = matrix.length
  sum = 0

  n.times do |i|
    n.times do |j|
      # 主対角線または副対角線の要素
      sum += matrix[i][j] if i == j || i + j == n - 1
    end
  end

  sum
end

# 解法3: 主対角線と副対角線を別々に計算
def diagonal_sum_separate(matrix)
  n = matrix.length

  # 主対角線の和
  primary = (0...n).sum { |i| matrix[i][i] }

  # 副対角線の和
  secondary = (0...n).sum { |i| matrix[i][n - 1 - i] }

  # 合計から中央要素の重複を引く（nが奇数の場合）
  total = primary + secondary
  total -= matrix[n / 2][n / 2] if n.odd?

  total
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 行列の対角線の和 テスト ==='
  puts

  # テストケース1: 3×3行列
  result1 = diagonal_sum([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
  puts 'Test 1: diagonal_sum([[1, 2, 3], [4, 5, 6], [7, 8, 9]])'
  puts "結果: #{result1}"
  puts '期待値: 25 (1+5+9+3+7)'
  puts "判定: #{result1 == 25 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 4×4行列（全て1）
  result2 = diagonal_sum([[1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1]])
  puts 'Test 2: diagonal_sum([[1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1]])'
  puts "結果: #{result2}"
  puts '期待値: 8 (すべて1なので、8個の対角線要素)'
  puts "判定: #{result2 == 8 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 1×1行列
  result3 = diagonal_sum([[5]])
  puts 'Test 3: diagonal_sum([[5]])'
  puts "結果: #{result3}"
  puts '期待値: 5 (1×1行列)'
  puts "判定: #{result3 == 5 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 2×2行列
  result4 = diagonal_sum([[1, 2], [3, 4]])
  puts 'Test 4: diagonal_sum([[1, 2], [3, 4]])'
  puts "結果: #{result4}"
  puts '期待値: 10 (1+4+2+3)'
  puts "判定: #{result4 == 10 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（二重ループ）
  puts '--- 解法2（二重ループ）のテスト ---'
  result5 = diagonal_sum_loop([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
  puts "diagonal_sum_loop([[1, 2, 3], [4, 5, 6], [7, 8, 9]]) = #{result5}"
  puts "判定: #{result5 == 25 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（別々に計算）
  puts '--- 解法3（別々に計算）のテスト ---'
  result6 = diagonal_sum_separate([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
  puts "diagonal_sum_separate([[1, 2, 3], [4, 5, 6], [7, 8, 9]]) = #{result6}"
  puts "判定: #{result6 == 25 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
