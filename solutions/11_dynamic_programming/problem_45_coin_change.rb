#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin coin_change
# 解法1: 動的計画法（ボトムアップ、推奨）
def coin_change(coins, amount)
  return 0 if amount == 0

  # dp[i]は金額iを作るのに必要な最小コイン枚数
  # amount + 1 は不可能を表す（最大でもamount枚あれば作れる）
  dp = Array.new(amount + 1, amount + 1)
  dp[0] = 0

  (1..amount).each do |i|
    coins.each do |coin|
      if coin <= i
        # このコインを使う場合と使わない場合の最小を選択
        dp[i] = [dp[i], dp[i - coin] + 1].min
      end
    end
  end

  dp[amount] > amount ? -1 : dp[amount]
end

# 解法2: 動的計画法（メモ化再帰）
def coin_change_memo(coins, amount, memo = {})
  return 0 if amount == 0
  return -1 if amount < 0
  return memo[amount] if memo.key?(amount)

  min_coins = Float::INFINITY

  coins.each do |coin|
    result = coin_change_memo(coins, amount - coin, memo)
    if result >= 0 && result < min_coins
      min_coins = result + 1
    end
  end

  memo[amount] = min_coins == Float::INFINITY ? -1 : min_coins
end

# 解法3: BFS（最短経路として捉える）
def coin_change_bfs(coins, amount)
  return 0 if amount == 0

  visited = Array.new(amount + 1, false)
  queue = [[0, 0]] # [現在の金額, コイン枚数]
  visited[0] = true

  until queue.empty?
    current_amount, num_coins = queue.shift

    coins.each do |coin|
      new_amount = current_amount + coin

      return num_coins + 1 if new_amount == amount

      if new_amount < amount && !visited[new_amount]
        visited[new_amount] = true
        queue << [new_amount, num_coins + 1]
      end
    end
  end

  -1
end

# 解法4: 使用したコインも返す
def coin_change_with_coins(coins, amount)
  return { count: 0, coins_used: [] } if amount == 0

  dp = Array.new(amount + 1, amount + 1)
  dp[0] = 0
  parent = Array.new(amount + 1, -1)

  (1..amount).each do |i|
    coins.each do |coin|
      if coin <= i && dp[i - coin] + 1 < dp[i]
        dp[i] = dp[i - coin] + 1
        parent[i] = coin
      end
    end
  end

  return { count: -1, coins_used: [] } if dp[amount] > amount

  # 使用したコインを復元
  coins_used = []
  current = amount
  while current > 0
    coins_used << parent[current]
    current -= parent[current]
  end

  { count: dp[amount], coins_used: coins_used }
end

# テストケース
puts coin_change([1, 2, 5], 11)   # => 3
puts coin_change([2], 3)          # => -1
puts coin_change([1], 0)          # => 0
puts coin_change([1, 2, 5], 100)  # => 20

p coin_change_with_coins([1, 2, 5], 11)
# => {count: 3, coins_used: [1, 5, 5]}
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== コイン問題（最小枚数） テスト ==='
  puts

  result1 = coin_change([1, 2, 5], 11)
  puts 'Test 1: coin_change([1, 2, 5], 11)'
  puts "結果: #{result1}"
  puts '期待値: 3'
  puts "判定: #{result1 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = coin_change([2], 3)
  puts 'Test 2: coin_change([2], 3)'
  puts "結果: #{result2}"
  puts '期待値: -1'
  puts "判定: #{result2 == -1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = coin_change([1], 0)
  puts 'Test 3: coin_change([1], 0)'
  puts "結果: #{result3}"
  puts '期待値: 0'
  puts "判定: #{result3 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = coin_change([1, 2, 5], 100)
  puts 'Test 4: coin_change([1, 2, 5], 100)'
  puts "結果: #{result4}"
  puts '期待値: 20'
  puts "判定: #{result4 == 20 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = coin_change_with_coins([1, 2, 5], 11)
  puts "coin_change_with_coins([1, 2, 5], 11) = #{result5}"
  puts "判定: #{result5[:count] == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
