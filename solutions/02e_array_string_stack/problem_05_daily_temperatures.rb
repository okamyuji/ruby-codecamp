#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 毎日の気温
# ファイル: 02e_array_string_stack.md
# ============================================================================
#
# 日ごとの気温を表す整数の配列が与えられます。各日について、より暖かい気温になるまでの
# 日数を返してください。より暖かい日が来ない場合は0を返します。
#
# 入力例: [73, 74, 75, 71, 69, 72, 76, 73]
# 出力例: [1, 1, 4, 2, 1, 1, 0, 0]
#
# 時間計算量: O(n)
# 空間計算量: O(n)
# ============================================================================

# 解法1: 単調減少スタック
def daily_temperatures(temperatures)
  n = temperatures.length
  result = Array.new(n, 0)
  stack = []

  temperatures.each_with_index do |temp, i|
    # より暖かい日が来た
    while !stack.empty? && temperatures[stack.last] < temp
      prev_day = stack.pop
      result[prev_day] = i - prev_day
    end

    stack << i
  end

  result
end

# 解法2: 右から左へスキャン
def daily_temperatures_reverse(temperatures)
  n = temperatures.length
  result = Array.new(n, 0)
  stack = []

  (n - 1).downto(0) do |i|
    # 現在以下の気温をスタックから削除
    stack.pop while !stack.empty? && temperatures[stack.last] <= temperatures[i]

    result[i] = stack.last - i unless stack.empty?
    stack << i
  end

  result
end

# 解法3: 最適化版（配列をスタックとして使用）
def daily_temperatures_optimized(temperatures)
  n = temperatures.length
  result = Array.new(n, 0)
  hottest = 0

  (n - 1).downto(0) do |i|
    current = temperatures[i]

    if current >= hottest
      hottest = current
      next
    end

    days = 1

    days += result[i + days] while temperatures[i + days] <= current

    result[i] = days
  end

  result
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 毎日の気温 テスト ==='
  puts

  # テストケース1: 通常のケース
  result1 = daily_temperatures([73, 74, 75, 71, 69, 72, 76, 73])
  puts 'Test 1: daily_temperatures([73, 74, 75, 71, 69, 72, 76, 73])'
  puts "結果: #{result1}"
  puts '期待値: [1, 1, 4, 2, 1, 1, 0, 0]'
  expected1 = [1, 1, 4, 2, 1, 1, 0, 0]
  puts "判定: #{result1 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 昇順
  result2 = daily_temperatures([30, 40, 50, 60])
  puts 'Test 2: daily_temperatures([30, 40, 50, 60])'
  puts "結果: #{result2}"
  puts '期待値: [1, 1, 1, 0]'
  expected2 = [1, 1, 1, 0]
  puts "判定: #{result2 == expected2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 急上昇
  result3 = daily_temperatures([30, 60, 90])
  puts 'Test 3: daily_temperatures([30, 60, 90])'
  puts "結果: #{result3}"
  puts '期待値: [1, 1, 0]'
  expected3 = [1, 1, 0]
  puts "判定: #{result3 == expected3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（右から左）
  puts '--- 解法2（右から左）のテスト ---'
  result4 = daily_temperatures_reverse([73, 74, 75, 71, 69, 72, 76, 73])
  puts "daily_temperatures_reverse([73, 74, 75, 71, 69, 72, 76, 73]) = #{result4}"
  puts "判定: #{result4 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（最適化版）
  puts '--- 解法3（最適化版）のテスト ---'
  result5 = daily_temperatures_optimized([73, 74, 75, 71, 69, 72, 76, 73])
  puts "daily_temperatures_optimized([73, 74, 75, 71, 69, 72, 76, 73]) = #{result5}"
  puts "判定: #{result5 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
