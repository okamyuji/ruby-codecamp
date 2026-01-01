#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 最頻出要素
# ファイル: 00_ruby_basics_and_complexity.md
# ============================================================================
#
# 配列内で最も頻繁に出現する要素を返す関数を実装してください。
#
# 入力例: [1, 2, 2, 3, 3, 3]
# 出力例: 3
#
# 入力例: [1, 1, 2, 2]
# 出力例: 1 または 2（どちらも同じ頻度）
#
# 時間計算量: O(n) - 配列を一度走査してカウント、ハッシュを一度走査して最大値を検索
# 空間計算量: O(n) - ハッシュに最大n個の要素を格納
# ============================================================================

# ハッシュを使用して各要素の出現回数をカウント
# Hash.new(0)でデフォルト値を0に設定し、カウントを簡潔に記述
# max_byメソッドで最大の出現回数を持つ要素を取得
def most_frequent(nums)
  freq = Hash.new(0)

  nums.each { |num| freq[num] += 1 }

  freq.max_by { |_k, v| v }[0]
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 最頻出要素 テスト ==='
  puts

  # テストケース1: 明確な最頻出要素
  result1 = most_frequent([1, 2, 2, 3, 3, 3])
  puts 'Test 1: most_frequent([1, 2, 2, 3, 3, 3])'
  puts "結果: #{result1}"
  puts '期待値: 3'
  puts "判定: #{result1 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 同じ頻度の要素（どちらかが返される）
  result2 = most_frequent([1, 1, 2, 2])
  puts 'Test 2: most_frequent([1, 1, 2, 2])'
  puts "結果: #{result2}"
  puts '期待値: 1 または 2'
  puts "判定: #{[1, 2].include?(result2) ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 単一要素
  result3 = most_frequent([5])
  puts 'Test 3: most_frequent([5])'
  puts "結果: #{result3}"
  puts '期待値: 5'
  puts "判定: #{result3 == 5 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 全て同じ要素
  result4 = most_frequent([7, 7, 7, 7])
  puts 'Test 4: most_frequent([7, 7, 7, 7])'
  puts "結果: #{result4}"
  puts '期待値: 7'
  puts "判定: #{result4 == 7 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース5: 大きな配列
  result5 = most_frequent([1, 2, 3, 4, 5, 5, 5, 6, 7, 8, 9])
  puts 'Test 5: most_frequent([1, 2, 3, 4, 5, 5, 5, 6, 7, 8, 9])'
  puts "結果: #{result5}"
  puts '期待値: 5'
  puts "判定: #{result5 == 5 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
