#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 2D行列の範囲合計
# ファイル: 02f_array_string_prefix_sum.md
# ============================================================================
#
# 2D行列が与えられます。複数のクエリがあり、各クエリは矩形領域の合計を求めます。
# クエリを効率的に処理してください。
#
# 入力例:
#   matrix = [[3, 0, 1, 4, 2],
#             [5, 6, 3, 2, 1],
#             [1, 2, 0, 1, 5],
#             [4, 1, 0, 1, 7],
#             [1, 0, 3, 0, 5]]
#   クエリ: [1, 1, 2, 2]  # row1からrow2, col1からcol2
# 出力例: 11  # 6 + 3 + 2 + 0 = 11
#
# 時間計算量: O(m × n)の事前計算、O(1)のクエリ
# 空間計算量: O(m × n)
# ============================================================================

# 解法1: 2D累積和配列
class Matrix2DSum
  def initialize(matrix)
    return if matrix.empty? || matrix[0].empty?

    m = matrix.length
    n = matrix[0].length

    # (m+1) × (n+1) の累積和配列
    @prefix = Array.new(m + 1) { Array.new(n + 1, 0) }

    m.times do |i|
      n.times do |j|
        @prefix[i + 1][j + 1] =
          matrix[i][j] +
          @prefix[i][j + 1] +
          @prefix[i + 1][j] -
          @prefix[i][j]
      end
    end
  end

  def sum_region(row1, col1, row2, col2)
    @prefix[row2 + 1][col2 + 1] -
      @prefix[row1][col2 + 1] -
      @prefix[row2 + 1][col1] +
      @prefix[row1][col1]
  end
end

# 解法2: 関数として実装
def build_2d_prefix_sum(matrix)
  return [] if matrix.empty? || matrix[0].empty?

  m = matrix.length
  n = matrix[0].length
  prefix = Array.new(m + 1) { Array.new(n + 1, 0) }

  m.times do |i|
    n.times do |j|
      prefix[i + 1][j + 1] =
        matrix[i][j] +
        prefix[i][j + 1] +
        prefix[i + 1][j] -
        prefix[i][j]
    end
  end

  prefix
end

def query_2d_sum(prefix, row1, col1, row2, col2)
  prefix[row2 + 1][col2 + 1] -
    prefix[row1][col2 + 1] -
    prefix[row2 + 1][col1] +
    prefix[row1][col1]
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 2D行列の範囲合計 テスト ==='
  puts

  matrix = [[3, 0, 1, 4, 2],
            [5, 6, 3, 2, 1],
            [1, 2, 0, 1, 5],
            [4, 1, 0, 1, 7],
            [1, 0, 3, 0, 5]]

  # 解法1のテスト（クラス）
  puts '--- 解法1（クラス）のテスト ---'
  m2d = Matrix2DSum.new(matrix)

  result1 = m2d.sum_region(1, 1, 2, 2)
  puts 'Test 1: m2d.sum_region(1, 1, 2, 2)'
  puts "結果: #{result1}"
  puts '期待値: 11 (6 + 3 + 2 + 0)'
  puts "判定: #{result1 == 11 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = m2d.sum_region(0, 0, 4, 4)
  puts 'Test 2: m2d.sum_region(0, 0, 4, 4)'
  puts "結果: #{result2}"
  puts '期待値: 58 (全体の合計)'
  puts "判定: #{result2 == 58 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = m2d.sum_region(2, 1, 4, 3)
  puts 'Test 3: m2d.sum_region(2, 1, 4, 3)'
  puts "結果: #{result3}"
  puts '期待値: 8 (2+0+1 + 1+0+1 + 0+3+0)'
  puts "判定: #{result3 == 8 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（関数）
  puts '--- 解法2（関数）のテスト ---'
  prefix = build_2d_prefix_sum(matrix)

  result4 = query_2d_sum(prefix, 1, 1, 2, 2)
  puts "query_2d_sum(prefix, 1, 1, 2, 2) = #{result4}"
  puts "判定: #{result4 == 11 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = query_2d_sum(prefix, 0, 0, 4, 4)
  puts "query_2d_sum(prefix, 0, 0, 4, 4) = #{result5}"
  puts "判定: #{result5 == 58 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
