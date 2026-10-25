#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin knapsack
# 解法1: 二次元DP（貰うDP）
def knapsack(weights, values, w)
  n = weights.length
  dp = Array.new(n + 1) { Array.new(w + 1, 0) }

  (1..n).each do |i|
    (0..w).each do |cap|
      # アイテム i-1 を選ばない
      dp[i][cap] = dp[i - 1][cap]

      # アイテム i-1 を選ぶ（可能なら）
      next unless cap >= weights[i - 1]

      dp[i][cap] = [
        dp[i][cap],
        dp[i - 1][cap - weights[i - 1]] + values[i - 1]
      ].max
    end
  end

  dp[n][w]
end

# 解法2: 一次元DP（空間最適化）
def knapsack_1d(weights, values, w)
  dp = Array.new(w + 1, 0)

  weights.each_with_index do |weight, i|
    value = values[i]

    # 後ろから更新（上書きを防ぐ）
    w.downto(weight) do |cap|
      dp[cap] = [dp[cap], dp[cap - weight] + value].max
    end
  end

  dp[w]
end

# 解法3: 配るDP
def knapsack_push(weights, values, w)
  dp = Array.new(w + 1, 0)

  weights.each_with_index do |weight, i|
    value = values[i]
    new_dp = dp.dup

    (0..w).each do |cap|
      if cap + weight <= w
        new_dp[cap + weight] = [new_dp[cap + weight], dp[cap] + value].max
      end
    end

    dp = new_dp
  end

  dp[w]
end

# 解法4: 選択したアイテムを追跡
def knapsack_with_items(weights, values, w)
  n = weights.length
  dp = Array.new(n + 1) { Array.new(w + 1, 0) }

  # DP計算
  (1..n).each do |i|
    (0..w).each do |cap|
      dp[i][cap] = dp[i - 1][cap]

      next unless cap >= weights[i - 1]

      dp[i][cap] = [
        dp[i][cap],
        dp[i - 1][cap - weights[i - 1]] + values[i - 1]
      ].max
    end
  end

  # バックトラック
  selected = []
  i = n
  cap = w

  while i > 0 && cap > 0
    # アイテムiが選ばれたか
    if dp[i][cap] != dp[i - 1][cap]
      selected << i - 1
      cap -= weights[i - 1]
    end
    i -= 1
  end

  [dp[n][w], selected.reverse]
end

# テストケース
weights = [1, 3, 4, 5]
values = [1, 4, 5, 7]
p knapsack(weights, values, 7) # => 9
p knapsack_1d(weights, values, 7) # => 9
p knapsack_with_items(weights, values, 7) # => [9, [1, 2]]
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== ナップサック問題（0-1 Knapsack） テスト ==='
  puts

  weights = [1, 3, 4, 5]
  values = [1, 4, 5, 7]

  result1 = knapsack(weights, values, 7)
  puts 'Test 1: knapsack([1, 3, 4, 5], [1, 4, 5, 7], 7)'
  puts "結果: #{result1}"
  puts '期待値: 9'
  puts "判定: #{result1 == 9 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = knapsack_1d(weights, values, 7)
  puts "knapsack_1d([1, 3, 4, 5], [1, 4, 5, 7], 7) = #{result2}"
  puts "判定: #{result2 == 9 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = knapsack_with_items(weights, values, 7)
  puts "knapsack_with_items([1, 3, 4, 5], [1, 4, 5, 7], 7) = #{result3}"
  puts "判定: #{result3[0] == 9 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
