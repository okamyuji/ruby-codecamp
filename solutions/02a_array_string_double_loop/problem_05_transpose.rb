#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 行列の転置
# ファイル: 02a_array_string_double_loop.md
# ============================================================================
#
# m × n の行列が与えられます。この行列を転置（行と列を入れ替え）してください。
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
# 時間計算量: O(m × n) - すべての要素を一度処理
# 空間計算量: O(m × n) - 新しい行列を作成
# ============================================================================

# 解法1: 二重ループで転置
def transpose(matrix)
  return [] if matrix.empty?

  rows = matrix.length
  cols = matrix[0].length
  result = Array.new(cols) { Array.new(rows) }

  # 各要素を転置位置にコピー
  rows.times do |i|
    cols.times do |j|
      result[j][i] = matrix[i][j]
    end
  end

  result
end

# 解法2: Rubyのtransposeメソッド（推奨）
def transpose_builtin(matrix)
  matrix.transpose
end

# 解法3: mapを使った関数型スタイル
def transpose_functional(matrix)
  return [] if matrix.empty?

  cols = matrix[0].length

  (0...cols).map do |j|
    matrix.map { |row| row[j] }
  end
end

# 解法4: zipを使った実装
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

  # テストケース4: 1×3行列
  result4 = transpose([[1, 2, 3]])
  puts 'Test 4: transpose([[1, 2, 3]])'
  puts "結果: #{result4}"
  puts '期待値: [[1], [2], [3]]'
  puts "判定: #{result4 == [[1], [2], [3]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（組み込みメソッド）
  puts '--- 解法2（組み込みメソッド）のテスト ---'
  result5 = transpose_builtin([[1, 2, 3], [4, 5, 6]])
  puts "transpose_builtin([[1, 2, 3], [4, 5, 6]]) = #{result5}"
  puts "判定: #{result5 == [[1, 4], [2, 5], [3, 6]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（関数型）
  puts '--- 解法3（関数型）のテスト ---'
  result6 = transpose_functional([[1, 2, 3], [4, 5, 6]])
  puts "transpose_functional([[1, 2, 3], [4, 5, 6]]) = #{result6}"
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
