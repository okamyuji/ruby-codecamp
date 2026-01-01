#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 配列の要素を2倍にする
# ファイル: 02_array_basics.md
# ============================================================================
#
# 整数の配列が与えられます。各要素を2倍にした新しい配列を返してください。
#
# 入力例: [1, 2, 3, 4, 5]
# 出力例: [2, 4, 6, 8, 10]
#
# 時間計算量: O(n) - 各要素を一度処理
# 空間計算量: O(n) - 新しい配列を作成
# ============================================================================

# 解法1: mapメソッドを使用（推奨）
# mapは各要素にブロックを適用し、新しい配列を返す
def double_array(arr)
  arr.map { |num| num * 2 }
end

# 解法2: 手動でループ
def double_array_loop(arr)
  result = []

  arr.each do |num|
    # 各要素を2倍にして結果配列に追加
    result << num * 2
  end

  result
end

# 解法3: 破壊的メソッドを使用（元の配列を変更）
def double_array_destructive!(arr)
  # map!は元の配列を直接変更する
  arr.map! { |num| num * 2 }
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 配列の要素を2倍にする テスト ==='
  puts

  # テストケース1: 通常の配列
  result1 = double_array([1, 2, 3, 4, 5])
  puts 'Test 1: double_array([1, 2, 3, 4, 5])'
  puts "結果: #{result1}"
  puts '期待値: [2, 4, 6, 8, 10]'
  puts "判定: #{result1 == [2, 4, 6, 8, 10] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: ゼロを含む
  result2 = double_array([0])
  puts 'Test 2: double_array([0])'
  puts "結果: #{result2}"
  puts '期待値: [0]'
  puts "判定: #{result2 == [0] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 負の数
  result3 = double_array([-1, -2])
  puts 'Test 3: double_array([-1, -2])'
  puts "結果: #{result3}"
  puts '期待値: [-2, -4]'
  puts "判定: #{result3 == [-2, -4] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 空配列
  result4 = double_array([])
  puts 'Test 4: double_array([])'
  puts "結果: #{result4}"
  puts '期待値: []'
  puts "判定: #{result4 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト
  puts '--- 解法2（ループ）のテスト ---'
  result5 = double_array_loop([1, 2, 3, 4, 5])
  puts "double_array_loop([1, 2, 3, 4, 5]) = #{result5}"
  puts "判定: #{result5 == [2, 4, 6, 8, 10] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（破壊的）
  puts '--- 解法3（破壊的）のテスト ---'
  test_arr = [1, 2, 3, 4, 5]
  result6 = double_array_destructive!(test_arr)
  puts "double_array_destructive!([1, 2, 3, 4, 5]) = #{result6}"
  puts "元の配列も変更: #{test_arr}"
  puts "判定: #{result6 == [2, 4, 6, 8, 10] && test_arr == [2, 4, 6, 8, 10] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
