#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 行列の転置
# ファイル: 02d_array_string_2d_matrix.md
# ============================================================================
#
# m × n の行列が与えられます。転置行列を返してください。
# 転置とは、行と列を入れ替えることです。
#
# 入力例:
#   [[1, 2, 3],
#    [4, 5, 6]]
#
# 出力例:
#   [[1, 4],
#    [2, 5],
#    [3, 6]]
#
# 時間計算量: O(m × n)
# 空間計算量: O(m × n) - 新しい行列を作成
# ============================================================================

# 解法1: 基本的な転置
def transpose(matrix)
  m = matrix.length
  n = matrix[0].length

  result = Array.new(n) { Array.new(m) }

  m.times do |i|
    n.times do |j|
      result[j][i] = matrix[i][j]
    end
  end

  result
end

# 解法2: Rubyのtransposeメソッドを使用
def transpose_builtin(matrix)
  matrix.transpose
end

# 解法3: mapを使用
def transpose_map(matrix)
  matrix[0].length.times.map do |col|
    matrix.map { |row| row[col] }
  end
end

# 解法4: zipを使用
def transpose_zip(matrix)
  matrix[0].zip(*matrix[1..])
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 行列の転置 テスト ==='
  puts

  # テストケース1: 2×3行列
  result1 = transpose([[1, 2, 3], [4, 5, 6]])
  puts 'Test 1: transpose([[1, 2, 3], [4, 5, 6]])'
  puts "結果: #{result1}"
  puts '期待値: [[1, 4], [2, 5], [3, 6]]'
  puts "判定: #{result1 == [[1, 4], [2, 5], [3, 6]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 3×2行列
  result2 = transpose([[1, 2], [3, 4], [5, 6]])
  puts 'Test 2: transpose([[1, 2], [3, 4], [5, 6]])'
  puts "結果: #{result2}"
  puts '期待値: [[1, 3, 5], [2, 4, 6]]'
  puts "判定: #{result2 == [[1, 3, 5], [2, 4, 6]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 1×1行列
  result3 = transpose([[1]])
  puts 'Test 3: transpose([[1]])'
  puts "結果: #{result3}"
  puts '期待値: [[1]]'
  puts "判定: #{result3 == [[1]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 正方行列
  result4 = transpose([[1, 2], [3, 4]])
  puts 'Test 4: transpose([[1, 2], [3, 4]])'
  puts "結果: #{result4}"
  puts '期待値: [[1, 3], [2, 4]]'
  puts "判定: #{result4 == [[1, 3], [2, 4]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（組み込みメソッド）
  puts '--- 解法2（組み込みメソッド）のテスト ---'
  result5 = transpose_builtin([[1, 2, 3], [4, 5, 6]])
  puts "transpose_builtin([[1, 2, 3], [4, 5, 6]]) = #{result5}"
  puts "判定: #{result5 == [[1, 4], [2, 5], [3, 6]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（map）
  puts '--- 解法3（map）のテスト ---'
  result6 = transpose_map([[1, 2, 3], [4, 5, 6]])
  puts "transpose_map([[1, 2, 3], [4, 5, 6]]) = #{result6}"
  puts "判定: #{result6 == [[1, 4], [2, 5], [3, 6]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法4のテスト（zip）
  puts '--- 解法4（zip）のテスト ---'
  result7 = transpose_zip([[1, 2, 3], [4, 5, 6]])
  puts "transpose_zip([[1, 2, 3], [4, 5, 6]]) = #{result7}"
  puts "判定: #{result7 == [[1, 4], [2, 5], [3, 6]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
