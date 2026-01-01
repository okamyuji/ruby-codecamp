#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: トップK頻出要素（ソート版）
# ファイル: 02c_array_string_sorting.md
# ============================================================================
#
# 整数の配列が与えられます。最も頻繁に出現するK個の要素を返してください。
#
# 入力例:
#   nums = [1, 1, 1, 2, 2, 3]
#   k = 2
# 出力例: [1, 2]
#
# 時間計算量: O(n log n) - ソートが支配的
# 空間計算量: O(n)
# ============================================================================

# 解法1: ハッシュとソート（推奨）
def top_k_frequent(nums, k)
  freq = nums.tally

  # 頻度の降順でソートし、トップk個の要素を取得
  freq.sort_by { |_, count| -count }.first(k).map(&:first)
end

# 解法2: sort_byとtake
def top_k_frequent_take(nums, k)
  nums.tally
      .sort_by { |_num, count| -count }
      .take(k)
      .map { |num, _| num }
end

# 解法3: max_byを使用（k個取得）
def top_k_frequent_max(nums, k)
  freq = nums.tally

  result = []
  k.times do
    break if freq.empty?

    max_num = freq.max_by { |_, count| count }[0]
    result << max_num
    freq.delete(max_num)
  end

  result
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== トップK頻出要素（ソート版） テスト ==='
  puts

  # テストケース1: 通常のケース
  result1 = top_k_frequent([1, 1, 1, 2, 2, 3], 2)
  puts 'Test 1: top_k_frequent([1, 1, 1, 2, 2, 3], 2)'
  puts "結果: #{result1}"
  puts '期待値: [1, 2]'
  puts "判定: #{result1.sort == [1, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 単一要素
  result2 = top_k_frequent([1], 1)
  puts 'Test 2: top_k_frequent([1], 1)'
  puts "結果: #{result2}"
  puts '期待値: [1]'
  puts "判定: #{result2 == [1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 複数の頻出要素
  result3 = top_k_frequent([4, 1, -1, 2, -1, 2, 3], 2)
  puts 'Test 3: top_k_frequent([4, 1, -1, 2, -1, 2, 3], 2)'
  puts "結果: #{result3.sort}"
  puts '期待値: [-1, 2] (順序は問わない)'
  puts "判定: #{result3.sort == [-1, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: k=1
  result4 = top_k_frequent([1, 2, 2, 3, 3, 3], 1)
  puts 'Test 4: top_k_frequent([1, 2, 2, 3, 3, 3], 1)'
  puts "結果: #{result4}"
  puts '期待値: [3]'
  puts "判定: #{result4 == [3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（take）
  puts '--- 解法2（take）のテスト ---'
  result5 = top_k_frequent_take([1, 1, 1, 2, 2, 3], 2)
  puts "top_k_frequent_take([1, 1, 1, 2, 2, 3], 2) = #{result5}"
  puts "判定: #{result5.sort == [1, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（max_by）
  puts '--- 解法3（max_by）のテスト ---'
  result6 = top_k_frequent_max([1, 1, 1, 2, 2, 3], 2)
  puts "top_k_frequent_max([1, 1, 1, 2, 2, 3], 2) = #{result6}"
  puts "判定: #{result6.sort == [1, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
