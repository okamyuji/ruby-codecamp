#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: バケットソート（計数ソート）
# ファイル: 02c_array_string_sorting.md
# ============================================================================
#
# 0からkの範囲の整数配列が与えられます。計数ソート（カウンティングソート）を使用して
# O(n + k)の時間でソートしてください。
#
# 入力例:
#   [4, 2, 2, 8, 3, 3, 1]
#   k = 8
# 出力例: [1, 2, 2, 3, 3, 4, 8]
#
# 時間計算量: O(n + k) - nは配列の長さ、kは値の範囲
# 空間計算量: O(k)
# ============================================================================

# 解法1: 基本的な計数ソート
def counting_sort(arr, k)
  count = Array.new(k + 1, 0)

  # 各値の出現回数をカウント
  arr.each { |num| count[num] += 1 }

  # カウントから結果配列を構築
  result = []
  count.each_with_index do |freq, value|
    freq.times { result << value }
  end

  result
end

# 解法2: 累積カウントを使用（安定ソート版）
def counting_sort_stable(arr, k)
  count = Array.new(k + 1, 0)
  output = Array.new(arr.length)

  # 各値の出現回数をカウント
  arr.each { |num| count[num] += 1 }

  # 累積カウントに変換
  (1..k).each { |i| count[i] += count[i - 1] }

  # 結果配列を構築（逆順で安定性を保証）
  (arr.length - 1).downto(0) do |i|
    value = arr[i]
    output[count[value] - 1] = value
    count[value] -= 1
  end

  output
end

# 解法3: ハッシュを使用（値の範囲が大きい場合）
def counting_sort_hash(arr)
  freq = Hash.new(0)
  arr.each { |num| freq[num] += 1 }

  result = []
  freq.keys.sort.each do |value|
    freq[value].times { result << value }
  end

  result
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== バケットソート（計数ソート） テスト ==='
  puts

  # テストケース1: 通常のケース
  result1 = counting_sort([4, 2, 2, 8, 3, 3, 1], 8)
  puts 'Test 1: counting_sort([4, 2, 2, 8, 3, 3, 1], 8)'
  puts "結果: #{result1}"
  puts '期待値: [1, 2, 2, 3, 3, 4, 8]'
  puts "判定: #{result1 == [1, 2, 2, 3, 3, 4, 8] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 別のケース
  result2 = counting_sort([1, 0, 3, 1, 3, 1], 3)
  puts 'Test 2: counting_sort([1, 0, 3, 1, 3, 1], 3)'
  puts "結果: #{result2}"
  puts '期待値: [0, 1, 1, 1, 3, 3]'
  puts "判定: #{result2 == [0, 1, 1, 1, 3, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 単一要素
  result3 = counting_sort([5], 5)
  puts 'Test 3: counting_sort([5], 5)'
  puts "結果: #{result3}"
  puts '期待値: [5]'
  puts "判定: #{result3 == [5] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（安定ソート）
  puts '--- 解法2（安定ソート）のテスト ---'
  result4 = counting_sort_stable([4, 2, 2, 8, 3, 3, 1], 8)
  puts "counting_sort_stable([4, 2, 2, 8, 3, 3, 1], 8) = #{result4}"
  puts "判定: #{result4 == [1, 2, 2, 3, 3, 4, 8] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（ハッシュ）
  puts '--- 解法3（ハッシュ）のテスト ---'
  result5 = counting_sort_hash([64, 25, 12, 22, 11])
  puts "counting_sort_hash([64, 25, 12, 22, 11]) = #{result5}"
  puts '期待値: [11, 12, 22, 25, 64]'
  puts "判定: #{result5 == [11, 12, 22, 25, 64] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
