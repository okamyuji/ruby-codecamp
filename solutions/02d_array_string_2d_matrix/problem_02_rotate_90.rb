#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 90度回転
# ファイル: 02d_array_string_2d_matrix.md
# ============================================================================
#
# n × n の正方行列が与えられます。時計回りに90度回転させてください。
# 回転はin-placeで行ってください。
#
# 入力例:
#   [[1, 2, 3],
#    [4, 5, 6],
#    [7, 8, 9]]
#
# 出力例:
#   [[7, 4, 1],
#    [8, 5, 2],
#    [9, 6, 3]]
#
# 時間計算量: O(n²)
# 空間計算量: O(1) - in-place
# ============================================================================

# 解法1: 転置してから各行を反転
def rotate_90(matrix)
  n = matrix.length

  # 転置
  (n - 1).times do |i|
    ((i + 1)...n).each do |j|
      matrix[i][j], matrix[j][i] = matrix[j][i], matrix[i][j]
    end
  end

  # 各行を反転
  matrix.each { |row| row.reverse! }

  matrix
end

# 解法2: 4つの要素を一度に回転
def rotate_90_four_way(matrix)
  n = matrix.length

  (n / 2).times do |i|
    (i...(n - i - 1)).each do |j|
      temp = matrix[i][j]

      # 左から上へ
      matrix[i][j] = matrix[n - j - 1][i]

      # 下から左へ
      matrix[n - j - 1][i] = matrix[n - i - 1][n - j - 1]

      # 右から下へ
      matrix[n - i - 1][n - j - 1] = matrix[j][n - i - 1]

      # 上から右へ
      matrix[j][n - i - 1] = temp
    end
  end

  matrix
end

# 解法3: 新しい配列を作成（in-placeではない）
def rotate_90_new_array(matrix)
  n = matrix.length

  Array.new(n) do |i|
    Array.new(n) { |j| matrix[n - j - 1][i] }
  end
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 90度回転 テスト ==='
  puts

  # テストケース1: 3×3行列
  result1 = rotate_90([[1, 2, 3], [4, 5, 6], [7, 8, 9]].map(&:dup))
  puts 'Test 1: rotate_90([[1, 2, 3], [4, 5, 6], [7, 8, 9]])'
  puts "結果: #{result1}"
  puts '期待値: [[7, 4, 1], [8, 5, 2], [9, 6, 3]]'
  expected1 = [[7, 4, 1], [8, 5, 2], [9, 6, 3]]
  puts "判定: #{result1 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 2×2行列
  result2 = rotate_90([[1, 2], [3, 4]].map(&:dup))
  puts 'Test 2: rotate_90([[1, 2], [3, 4]])'
  puts "結果: #{result2}"
  puts '期待値: [[3, 1], [4, 2]]'
  expected2 = [[3, 1], [4, 2]]
  puts "判定: #{result2 == expected2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 1×1行列
  result3 = rotate_90([[1]].map(&:dup))
  puts 'Test 3: rotate_90([[1]])'
  puts "結果: #{result3}"
  puts '期待値: [[1]]'
  puts "判定: #{result3 == [[1]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 4×4行列
  result4 = rotate_90([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]].map(&:dup))
  puts 'Test 4: rotate_90([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]])'
  puts "結果: #{result4}"
  expected4 = [[13, 9, 5, 1], [14, 10, 6, 2], [15, 11, 7, 3], [16, 12, 8, 4]]
  puts '期待値: [[13, 9, 5, 1], [14, 10, 6, 2], [15, 11, 7, 3], [16, 12, 8, 4]]'
  puts "判定: #{result4 == expected4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（4つの要素を一度に）
  puts '--- 解法2（4つの要素を一度に）のテスト ---'
  result5 = rotate_90_four_way([[1, 2, 3], [4, 5, 6], [7, 8, 9]].map(&:dup))
  puts "rotate_90_four_way([[1, 2, 3], [4, 5, 6], [7, 8, 9]]) = #{result5}"
  puts "判定: #{result5 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（新しい配列）
  puts '--- 解法3（新しい配列）のテスト ---'
  result6 = rotate_90_new_array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
  puts "rotate_90_new_array([[1, 2, 3], [4, 5, 6], [7, 8, 9]]) = #{result6}"
  puts "判定: #{result6 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
