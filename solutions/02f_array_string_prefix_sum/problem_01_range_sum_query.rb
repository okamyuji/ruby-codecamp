#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 範囲の合計クエリ
# ファイル: 02f_array_string_prefix_sum.md
# ============================================================================
#
# 整数の配列が与えられます。複数のクエリがあり、各クエリは[left, right]の範囲の合計を求めます。
# クエリを効率的に処理してください。
#
# 入力例:
#   nums = [1, 2, 3, 4, 5]
#   クエリ: [[0, 2], [1, 4], [2, 3]]
# 出力例: [6, 14, 7]  # [1+2+3, 2+3+4+5, 3+4]
#
# 時間計算量: O(n)の事前計算、O(1)のクエリ
# 空間計算量: O(n)
# ============================================================================

# 解法1: クラスとして実装
class RangeSumQuery
  def initialize(nums)
    @prefix = [0]

    nums.each do |num|
      @prefix << @prefix.last + num
    end
  end

  def sum_range(left, right)
    @prefix[right + 1] - @prefix[left]
  end
end

# 解法2: 関数として実装
def build_prefix_sum(nums)
  prefix = [0]

  nums.each do |num|
    prefix << prefix.last + num
  end

  prefix
end

def range_sum(prefix, left, right)
  prefix[right + 1] - prefix[left]
end

# 解法3: scanを使用
def build_prefix_sum_scan(nums)
  nums.each_with_object([0]) { |num, acc| acc << acc.last + num }
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 範囲の合計クエリ テスト ==='
  puts

  nums = [1, 2, 3, 4, 5]

  # 解法1のテスト（クラス）
  puts '--- 解法1（クラス）のテスト ---'
  rsq = RangeSumQuery.new(nums)

  result1 = rsq.sum_range(0, 2)
  puts 'Test 1: rsq.sum_range(0, 2)'
  puts "結果: #{result1}"
  puts '期待値: 6 (1 + 2 + 3)'
  puts "判定: #{result1 == 6 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = rsq.sum_range(1, 4)
  puts 'Test 2: rsq.sum_range(1, 4)'
  puts "結果: #{result2}"
  puts '期待値: 14 (2 + 3 + 4 + 5)'
  puts "判定: #{result2 == 14 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = rsq.sum_range(2, 3)
  puts 'Test 3: rsq.sum_range(2, 3)'
  puts "結果: #{result3}"
  puts '期待値: 7 (3 + 4)'
  puts "判定: #{result3 == 7 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（関数）
  puts '--- 解法2（関数）のテスト ---'
  prefix = build_prefix_sum(nums)

  result4 = range_sum(prefix, 0, 2)
  puts "range_sum(prefix, 0, 2) = #{result4}"
  puts "判定: #{result4 == 6 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = range_sum(prefix, 1, 4)
  puts "range_sum(prefix, 1, 4) = #{result5}"
  puts "判定: #{result5 == 14 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（scan）
  puts '--- 解法3（scan）のテスト ---'
  prefix2 = build_prefix_sum_scan(nums)
  puts "build_prefix_sum_scan([1, 2, 3, 4, 5]) = #{prefix2}"
  puts "判定: #{prefix2 == [0, 1, 3, 6, 10, 15] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
