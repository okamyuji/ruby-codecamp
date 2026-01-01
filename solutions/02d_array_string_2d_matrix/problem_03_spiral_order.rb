#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: スパイラル順序で走査
# ファイル: 02d_array_string_2d_matrix.md
# ============================================================================
#
# m × n の行列が与えられます。スパイラル順序（渦巻き状）ですべての要素を返してください。
#
# 入力例:
#   [[1, 2, 3],
#    [4, 5, 6],
#    [7, 8, 9]]
#
# 出力例: [1, 2, 3, 6, 9, 8, 7, 4, 5]
#
# 時間計算量: O(m × n)
# 空間計算量: O(1) - 結果配列を除く
# ============================================================================

# 解法1: 4つの境界を使用
def spiral_order(matrix)
  return [] if matrix.empty?

  result = []
  top = 0
  bottom = matrix.length - 1
  left = 0
  right = matrix[0].length - 1

  while top <= bottom && left <= right
    # 右へ移動
    (left..right).each { |j| result << matrix[top][j] }
    top += 1

    # 下へ移動
    (top..bottom).each { |i| result << matrix[i][right] }
    right -= 1

    if top <= bottom
      # 左へ移動
      right.downto(left).each { |j| result << matrix[bottom][j] }
      bottom -= 1
    end

    next unless left <= right

    # 上へ移動
    bottom.downto(top).each { |i| result << matrix[i][left] }
    left += 1
  end

  result
end

# 解法2: 方向ベクトルを使用
def spiral_order_direction(matrix)
  return [] if matrix.empty?

  m = matrix.length
  n = matrix[0].length
  result = []
  visited = Array.new(m) { Array.new(n, false) }

  # 右、下、左、上
  directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]
  dir_idx = 0

  row = 0
  col = 0

  (m * n).times do
    result << matrix[row][col]
    visited[row][col] = true

    # 次の位置を計算
    next_row = row + directions[dir_idx][0]
    next_col = col + directions[dir_idx][1]

    # 方向転換が必要か確認
    if next_row < 0 || next_row >= m || next_col < 0 || next_col >= n || visited[next_row][next_col]
      dir_idx = (dir_idx + 1) % 4
      next_row = row + directions[dir_idx][0]
      next_col = col + directions[dir_idx][1]
    end

    row = next_row
    col = next_col
  end

  result
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== スパイラル順序で走査 テスト ==='
  puts

  # テストケース1: 3×3行列
  result1 = spiral_order([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
  puts 'Test 1: spiral_order([[1, 2, 3], [4, 5, 6], [7, 8, 9]])'
  puts "結果: #{result1}"
  puts '期待値: [1, 2, 3, 6, 9, 8, 7, 4, 5]'
  expected1 = [1, 2, 3, 6, 9, 8, 7, 4, 5]
  puts "判定: #{result1 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 3×4行列
  result2 = spiral_order([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
  puts 'Test 2: spiral_order([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])'
  puts "結果: #{result2}"
  puts '期待値: [1, 2, 3, 4, 8, 12, 11, 10, 9, 5, 6, 7]'
  expected2 = [1, 2, 3, 4, 8, 12, 11, 10, 9, 5, 6, 7]
  puts "判定: #{result2 == expected2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 1×1行列
  result3 = spiral_order([[1]])
  puts 'Test 3: spiral_order([[1]])'
  puts "結果: #{result3}"
  puts '期待値: [1]'
  puts "判定: #{result3 == [1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 1×4行列
  result4 = spiral_order([[1, 2, 3, 4]])
  puts 'Test 4: spiral_order([[1, 2, 3, 4]])'
  puts "結果: #{result4}"
  puts '期待値: [1, 2, 3, 4]'
  puts "判定: #{result4 == [1, 2, 3, 4] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（方向ベクトル）
  puts '--- 解法2（方向ベクトル）のテスト ---'
  result5 = spiral_order_direction([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
  puts "spiral_order_direction([[1, 2, 3], [4, 5, 6], [7, 8, 9]]) = #{result5}"
  puts "判定: #{result5 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
