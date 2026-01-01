#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 偶数のみをフィルタリング
# ファイル: 02_array_basics.md
# ============================================================================
#
# 整数の配列が与えられます。偶数のみを含む新しい配列を返してください。
#
# 入力例: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# 出力例: [2, 4, 6, 8, 10]
#
# 時間計算量: O(n) - 各要素を一度チェック
# 空間計算量: O(k) - kは偶数の個数
# ============================================================================

# 解法1: selectメソッドを使用（推奨）
# selectは条件を満たす要素のみを含む新しい配列を返す
def filter_even(arr)
  # even?メソッドは偶数の場合trueを返す
  arr.select { |num| num.even? }
end

# 解法2: 条件式を明示的に記述
def filter_even_explicit(arr)
  arr.select { |num| num % 2 == 0 }
end

# 解法3: 手動でループ
def filter_even_loop(arr)
  result = []

  arr.each do |num|
    # 偶数かどうかをチェック
    result << num if num.even?
  end

  result
end

# 解法4: rejectを使用して奇数を除外
def filter_even_reject(arr)
  # rejectは条件を満たす要素を除外する
  arr.reject { |num| num.odd? }
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 偶数のみをフィルタリング テスト ==='
  puts

  # テストケース1: 通常の配列
  result1 = filter_even([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
  puts 'Test 1: filter_even([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])'
  puts "結果: #{result1}"
  puts '期待値: [2, 4, 6, 8, 10]'
  puts "判定: #{result1 == [2, 4, 6, 8, 10] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 奇数のみ
  result2 = filter_even([1, 3, 5])
  puts 'Test 2: filter_even([1, 3, 5])'
  puts "結果: #{result2}"
  puts '期待値: []'
  puts "判定: #{result2 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 偶数のみ
  result3 = filter_even([2, 4, 6])
  puts 'Test 3: filter_even([2, 4, 6])'
  puts "結果: #{result3}"
  puts '期待値: [2, 4, 6]'
  puts "判定: #{result3 == [2, 4, 6] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 空配列
  result4 = filter_even([])
  puts 'Test 4: filter_even([])'
  puts "結果: #{result4}"
  puts '期待値: []'
  puts "判定: #{result4 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース5: 負の数を含む
  result5 = filter_even([-2, -1, 0, 1, 2])
  puts 'Test 5: filter_even([-2, -1, 0, 1, 2])'
  puts "結果: #{result5}"
  puts '期待値: [-2, 0, 2]'
  puts "判定: #{result5 == [-2, 0, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト
  puts '--- 解法2（明示的条件）のテスト ---'
  result6 = filter_even_explicit([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
  puts "filter_even_explicit([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) = #{result6}"
  puts "判定: #{result6 == [2, 4, 6, 8, 10] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト
  puts '--- 解法3（ループ）のテスト ---'
  result7 = filter_even_loop([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
  puts "filter_even_loop([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) = #{result7}"
  puts "判定: #{result7 == [2, 4, 6, 8, 10] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法4のテスト
  puts '--- 解法4（reject）のテスト ---'
  result8 = filter_even_reject([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
  puts "filter_even_reject([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) = #{result8}"
  puts "判定: #{result8 == [2, 4, 6, 8, 10] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
