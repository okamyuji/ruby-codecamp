#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 対角線走査
# ファイル: 02d_array_string_2d_matrix.md
# ============================================================================
#
# m × n の行列が与えられます。対角線順序ですべての要素を返してください。
#
# 入力例:
#   [[1, 2, 3],
#    [4, 5, 6],
#    [7, 8, 9]]
#
# 出力例: [1, 2, 4, 7, 5, 3, 6, 8, 9]
#
# 時間計算量: O(m × n)
# 空間計算量: O(1) - 結果配列を除く
# ============================================================================

# 解法1: 対角線ごとに処理
def find_diagonal_order(matrix)
  return [] if matrix.empty?

  m = matrix.length
  n = matrix[0].length
  result = []

  # 対角線の数は m + n - 1
  (m + n - 1).times do |d|
    diagonal = []

    # 対角線上の要素を収集
    row = [d, m - 1].min
    col = d - row

    while row >= 0 && col < n
      diagonal << matrix[row][col]
      row -= 1
      col += 1
    end

    # 奇数番目の対角線は逆順
    diagonal.reverse! if d.odd?

    result.concat(diagonal)
  end

  result
end

# 解法2: 方向ベクトルを使用
def find_diagonal_order_vector(matrix)
  return [] if matrix.empty?

  m = matrix.length
  n = matrix[0].length
  result = []
  row = 0
  col = 0
  going_up = true

  (m * n).times do
    result << matrix[row][col]

    if going_up
      if col == n - 1
        row += 1
        going_up = false
      elsif row.zero?
        col += 1
        going_up = false
      else
        row -= 1
        col += 1
      end
    elsif row == m - 1
      col += 1
      going_up = true
    elsif col.zero?
      row += 1
      going_up = true
    else
      row += 1
      col -= 1
    end
  end

  result
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 対角線走査 テスト ==='
  puts

  # テストケース1: 3×3行列
  result1 = find_diagonal_order([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
  puts 'Test 1: find_diagonal_order([[1, 2, 3], [4, 5, 6], [7, 8, 9]])'
  puts "結果: #{result1}"
  puts '期待値: [1, 2, 4, 7, 5, 3, 6, 8, 9]'
  expected1 = [1, 2, 4, 7, 5, 3, 6, 8, 9]
  puts "判定: #{result1 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 2×2行列
  result2 = find_diagonal_order([[1, 2], [3, 4]])
  puts 'Test 2: find_diagonal_order([[1, 2], [3, 4]])'
  puts "結果: #{result2}"
  puts '期待値: [1, 2, 3, 4]'
  expected2 = [1, 2, 3, 4]
  puts "判定: #{result2 == expected2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 1×3行列
  result3 = find_diagonal_order([[1, 2, 3]])
  puts 'Test 3: find_diagonal_order([[1, 2, 3]])'
  puts "結果: #{result3}"
  puts '期待値: [1, 2, 3]'
  puts "判定: #{result3 == [1, 2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 3×1行列
  result4 = find_diagonal_order([[1], [2], [3]])
  puts 'Test 4: find_diagonal_order([[1], [2], [3]])'
  puts "結果: #{result4}"
  puts '期待値: [1, 2, 3]'
  puts "判定: #{result4 == [1, 2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（方向ベクトル）
  puts '--- 解法2（方向ベクトル）のテスト ---'
  result5 = find_diagonal_order_vector([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
  puts "find_diagonal_order_vector([[1, 2, 3], [4, 5, 6], [7, 8, 9]]) = #{result5}"
  puts "判定: #{result5 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
