#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 行列のゼロ設定
# ファイル: 02d_array_string_2d_matrix.md
# ============================================================================
#
# m × n の行列が与えられます。要素が0の場合、その行と列のすべての要素を0に設定してください。
# in-placeで行う必要があります。
#
# 入力例:
#   [[1, 1, 1],
#    [1, 0, 1],
#    [1, 1, 1]]
#
# 出力例:
#   [[1, 0, 1],
#    [0, 0, 0],
#    [1, 0, 1]]
#
# 時間計算量: O(m × n)
# 空間計算量: O(1)
# ============================================================================

# 解法1: O(1)空間 - 最初の行と列を記録用に使用
def set_zeroes(matrix)
  m = matrix.length
  n = matrix[0].length

  # 最初の行と列に0があるか確認
  first_row_zero = matrix[0].any?(&:zero?)
  first_col_zero = matrix.any? { |row| row[0].zero? }

  # 残りの要素で0を探し、最初の行・列に記録
  (1...m).each do |i|
    (1...n).each do |j|
      if matrix[i][j].zero?
        matrix[i][0] = 0
        matrix[0][j] = 0
      end
    end
  end

  # 記録を基に0を設定
  (1...m).each do |i|
    (1...n).each do |j|
      matrix[i][j] = 0 if matrix[i][0].zero? || matrix[0][j].zero?
    end
  end

  # 最初の行と列を処理
  matrix[0].fill(0) if first_row_zero
  matrix.each { |row| row[0] = 0 } if first_col_zero

  matrix
end

# 解法2: O(m + n)空間 - セットを使用
def set_zeroes_set(matrix)
  m = matrix.length
  n = matrix[0].length

  zero_rows = Set.new
  zero_cols = Set.new

  # 0の位置を記録
  m.times do |i|
    n.times do |j|
      if matrix[i][j].zero?
        zero_rows << i
        zero_cols << j
      end
    end
  end

  # 0を設定
  m.times do |i|
    n.times do |j|
      matrix[i][j] = 0 if zero_rows.include?(i) || zero_cols.include?(j)
    end
  end

  matrix
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 行列のゼロ設定 テスト ==='
  puts

  # テストケース1: 中央に0
  result1 = set_zeroes([[1, 1, 1], [1, 0, 1], [1, 1, 1]].map(&:dup))
  puts 'Test 1: set_zeroes([[1, 1, 1], [1, 0, 1], [1, 1, 1]])'
  puts "結果: #{result1}"
  puts '期待値: [[1, 0, 1], [0, 0, 0], [1, 0, 1]]'
  expected1 = [[1, 0, 1], [0, 0, 0], [1, 0, 1]]
  puts "判定: #{result1 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 複数の0
  result2 = set_zeroes([[0, 1, 2, 0], [3, 4, 5, 2], [1, 3, 1, 5]].map(&:dup))
  puts 'Test 2: set_zeroes([[0, 1, 2, 0], [3, 4, 5, 2], [1, 3, 1, 5]])'
  puts "結果: #{result2}"
  puts '期待値: [[0, 0, 0, 0], [0, 4, 5, 0], [0, 3, 1, 0]]'
  expected2 = [[0, 0, 0, 0], [0, 4, 5, 0], [0, 3, 1, 0]]
  puts "判定: #{result2 == expected2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 0がない
  result3 = set_zeroes([[1, 2], [3, 4]].map(&:dup))
  puts 'Test 3: set_zeroes([[1, 2], [3, 4]])'
  puts "結果: #{result3}"
  puts '期待値: [[1, 2], [3, 4]]'
  puts "判定: #{result3 == [[1, 2], [3, 4]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 全て0
  result4 = set_zeroes([[0, 0], [0, 0]].map(&:dup))
  puts 'Test 4: set_zeroes([[0, 0], [0, 0]])'
  puts "結果: #{result4}"
  puts '期待値: [[0, 0], [0, 0]]'
  puts "判定: #{result4 == [[0, 0], [0, 0]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（セット使用）
  puts '--- 解法2（セット使用）のテスト ---'
  result5 = set_zeroes_set([[1, 1, 1], [1, 0, 1], [1, 1, 1]].map(&:dup))
  puts "set_zeroes_set([[1, 1, 1], [1, 0, 1], [1, 1, 1]]) = #{result5}"
  puts "判定: #{result5 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
