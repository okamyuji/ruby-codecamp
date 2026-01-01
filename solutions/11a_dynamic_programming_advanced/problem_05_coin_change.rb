#!/usr/bin/env ruby
# frozen_string_literal: true

def coin_change(coins, amount)
  dp = Array.new(amount + 1, Float::INFINITY)
  dp[0] = 0

  (1..amount).each do |i|
    coins.each do |coin|
      dp[i] = [dp[i], dp[i - coin] + 1].min if i >= coin
    end
  end

  dp[amount] == Float::INFINITY ? -1 : dp[amount]
end

def coin_change_push(coins, amount)
  dp = Array.new(amount + 1, Float::INFINITY)
  dp[0] = 0

  (0...amount).each do |i|
    next if dp[i] == Float::INFINITY

    coins.each do |coin|
      dp[i + coin] = [dp[i + coin], dp[i] + 1].min if i + coin <= amount
    end
  end

  dp[amount] == Float::INFINITY ? -1 : dp[amount]
end

def coin_change_with_coins(coins, amount)
  dp = Array.new(amount + 1, Float::INFINITY)
  parent = Array.new(amount + 1, -1)
  dp[0] = 0

  (1..amount).each do |i|
    coins.each do |coin|
      if i >= coin && dp[i - coin] + 1 < dp[i]
        dp[i] = dp[i - coin] + 1
        parent[i] = coin
      end
    end
  end

  return [-1, []] if dp[amount] == Float::INFINITY

  result = []
  curr = amount

  while curr > 0
    coin = parent[curr]
    result << coin
    curr -= coin
  end

  [dp[amount], result.sort]
end

if __FILE__ == $PROGRAM_NAME
  puts '=== コイン両替（Coin Change） テスト ==='
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

  result4 = coin_change_with_coins([1, 2, 5], 11)
  puts "coin_change_with_coins([1, 2, 5], 11) = #{result4}"
  puts "判定: #{result4[0] == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
