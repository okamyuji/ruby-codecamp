#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 2D行列の検索
# ファイル: 02d_array_string_2d_matrix.md
# ============================================================================
#
# 各行が左から右へソートされ、各列が上から下へソートされている m × n の行列が与えられます。
# ターゲット値が存在するか判定してください。
#
# 入力例:
#   matrix = [[1,  4,  7,  11, 15],
#             [2,  5,  8,  12, 19],
#             [3,  6,  9,  16, 22],
#             [10, 13, 14, 17, 24],
#             [18, 21, 23, 26, 30]]
#   target = 5
# 出力例: true
#
# 時間計算量: O(m + n)
# 空間計算量: O(1)
# ============================================================================

# 解法1: 右上から検索
def search_matrix(matrix, target)
  return false if matrix.empty? || matrix[0].empty?

  row = 0
  col = matrix[0].length - 1

  while row < matrix.length && col >= 0
    current = matrix[row][col]

    return true if current == target

    if current > target
      col -= 1  # 左へ移動
    else
      row += 1  # 下へ移動
    end
  end

  false
end

# 解法2: 左下から検索
def search_matrix_bottom_left(matrix, target)
  return false if matrix.empty? || matrix[0].empty?

  row = matrix.length - 1
  col = 0

  while row >= 0 && col < matrix[0].length
    current = matrix[row][col]

    return true if current == target

    if current > target
      row -= 1  # 上へ移動
    else
      col += 1  # 右へ移動
    end
  end

  false
end

# 解法3: 各行で二分探索（O(m log n)）
def search_matrix_binary(matrix, target)
  matrix.any? do |row|
    row.bsearch { |x| x >= target } == target
  end
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 2D行列の検索 テスト ==='
  puts

  # テスト用の行列
  matrix = [[1, 4, 7, 11, 15],
            [2, 5, 8, 12, 19],
            [3, 6, 9, 16, 22],
            [10, 13, 14, 17, 24],
            [18, 21, 23, 26, 30]]

  # テストケース1: 存在する（5）
  result1 = search_matrix(matrix, 5)
  puts 'Test 1: search_matrix(matrix, 5)'
  puts "結果: #{result1}"
  puts '期待値: true'
  puts "判定: #{result1 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 存在しない（20）
  result2 = search_matrix(matrix, 20)
  puts 'Test 2: search_matrix(matrix, 20)'
  puts "結果: #{result2}"
  puts '期待値: false'
  puts "判定: #{result2 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 存在する（30、右下隅）
  result3 = search_matrix(matrix, 30)
  puts 'Test 3: search_matrix(matrix, 30)'
  puts "結果: #{result3}"
  puts '期待値: true'
  puts "判定: #{result3 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 存在する（1、左上隅）
  result4 = search_matrix(matrix, 1)
  puts 'Test 4: search_matrix(matrix, 1)'
  puts "結果: #{result4}"
  puts '期待値: true'
  puts "判定: #{result4 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（左下から）
  puts '--- 解法2（左下から）のテスト ---'
  result5 = search_matrix_bottom_left(matrix, 5)
  puts "search_matrix_bottom_left(matrix, 5) = #{result5}"
  puts "判定: #{result5 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result6 = search_matrix_bottom_left(matrix, 20)
  puts "search_matrix_bottom_left(matrix, 20) = #{result6}"
  puts "判定: #{result6 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（二分探索）
  puts '--- 解法3（二分探索）のテスト ---'
  result7 = search_matrix_binary(matrix, 5)
  puts "search_matrix_binary(matrix, 5) = #{result7}"
  puts "判定: #{result7 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
