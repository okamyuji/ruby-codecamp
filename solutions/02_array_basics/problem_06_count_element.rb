#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 配列内の特定要素のカウント
# ファイル: 02_array_basics.md
# ============================================================================
#
# 配列と検索する値が与えられます。配列内でその値が何回出現するかをカウントしてください。
#
# 入力例:
#   配列: [1, 2, 2, 3, 2, 4, 2]
#   値: 2
# 出力例: 4
#
# 時間計算量: O(n) - 全要素をチェック
# 空間計算量: O(1) - カウンター変数のみ
# ============================================================================

# 解法1: countメソッドを使用（推奨）
def count_element(arr, target)
  # countメソッドに引数を渡すと、その値の出現回数を返す
  arr.count(target)
end

# 解法2: countメソッドとブロック
def count_element_block(arr, target)
  # ブロックで条件を指定することも可能
  arr.count { |elem| elem == target }
end

# 解法3: 手動でカウント
def count_element_manual(arr, target)
  count = 0

  arr.each do |elem|
    # 一致する要素をカウント
    count += 1 if elem == target
  end

  count
end

# 解法4: selectしてサイズを取得
def count_element_select(arr, target)
  arr.select { |elem| elem == target }.size
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 配列内の特定要素のカウント テスト ==='
  puts

  # テストケース1: 複数回出現
  result1 = count_element([1, 2, 2, 3, 2, 4, 2], 2)
  puts 'Test 1: count_element([1, 2, 2, 3, 2, 4, 2], 2)'
  puts "結果: #{result1}"
  puts '期待値: 4'
  puts "判定: #{result1 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 全て同じ要素
  result2 = count_element([1, 1, 1, 1, 1], 1)
  puts 'Test 2: count_element([1, 1, 1, 1, 1], 1)'
  puts "結果: #{result2}"
  puts '期待値: 5'
  puts "判定: #{result2 == 5 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 存在しない要素
  result3 = count_element([1, 2, 3], 5)
  puts 'Test 3: count_element([1, 2, 3], 5)'
  puts "結果: #{result3}"
  puts '期待値: 0'
  puts "判定: #{result3 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 空配列
  result4 = count_element([], 1)
  puts 'Test 4: count_element([], 1)'
  puts "結果: #{result4}"
  puts '期待値: 0'
  puts "判定: #{result4 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース5: 文字列の配列
  result5 = count_element(['a', 'b', 'a'], 'a')
  puts "Test 5: count_element(['a', 'b', 'a'], 'a')"
  puts "結果: #{result5}"
  puts '期待値: 2'
  puts "判定: #{result5 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト
  puts '--- 解法2（ブロック）のテスト ---'
  result6 = count_element_block([1, 2, 2, 3, 2, 4, 2], 2)
  puts "count_element_block([1, 2, 2, 3, 2, 4, 2], 2) = #{result6}"
  puts "判定: #{result6 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト
  puts '--- 解法3（手動カウント）のテスト ---'
  result7 = count_element_manual([1, 2, 2, 3, 2, 4, 2], 2)
  puts "count_element_manual([1, 2, 2, 3, 2, 4, 2], 2) = #{result7}"
  puts "判定: #{result7 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法4のテスト
  puts '--- 解法4（select + size）のテスト ---'
  result8 = count_element_select([1, 2, 2, 3, 2, 4, 2], 2)
  puts "count_element_select([1, 2, 2, 3, 2, 4, 2], 2) = #{result8}"
  puts "判定: #{result8 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
