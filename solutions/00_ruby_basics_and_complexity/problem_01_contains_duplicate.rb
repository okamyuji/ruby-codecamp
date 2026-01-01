#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 重複要素の検出
# ファイル: 00_ruby_basics_and_complexity.md
# ============================================================================
#
# 配列内に重複する要素があるかどうかを判定する関数を、O(n)の時間計算量で実装してください。
#
# 入力例: [1, 2, 3, 1]
# 出力例: true
#
# 入力例: [1, 2, 3, 4]
# 出力例: false
#
# 時間計算量: O(n) - 配列を一度走査
# 空間計算量: O(n) - ハッシュに最大n個の要素を格納
# ============================================================================

# ハッシュを使用して重複を検出
# 各要素を走査しながら、既に見た要素をハッシュに記録
# 既に記録されている要素が見つかったら、重複があると判定
def contains_duplicate(nums)
  seen = {}

  nums.each do |num|
    return true if seen.key?(num)

    seen[num] = true
  end

  false
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 重複要素の検出 テスト ==='
  puts

  # テストケース1: 重複あり
  result1 = contains_duplicate([1, 2, 3, 1])
  puts 'Test 1: contains_duplicate([1, 2, 3, 1])'
  puts "結果: #{result1}"
  puts '期待値: true'
  puts "判定: #{result1 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 重複なし
  result2 = contains_duplicate([1, 2, 3, 4])
  puts 'Test 2: contains_duplicate([1, 2, 3, 4])'
  puts "結果: #{result2}"
  puts '期待値: false'
  puts "判定: #{result2 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 空配列
  result3 = contains_duplicate([])
  puts 'Test 3: contains_duplicate([])'
  puts "結果: #{result3}"
  puts '期待値: false'
  puts "判定: #{result3 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 単一要素
  result4 = contains_duplicate([1])
  puts 'Test 4: contains_duplicate([1])'
  puts "結果: #{result4}"
  puts '期待値: false'
  puts "判定: #{result4 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース5: 全て同じ要素
  result5 = contains_duplicate([1, 1, 1, 1])
  puts 'Test 5: contains_duplicate([1, 1, 1, 1])'
  puts "結果: #{result5}"
  puts '期待値: true'
  puts "判定: #{result5 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
