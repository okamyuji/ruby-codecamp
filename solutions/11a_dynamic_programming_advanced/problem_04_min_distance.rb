#!/usr/bin/env ruby
# frozen_string_literal: true

def min_distance(word1, word2)
  m = word1.length
  n = word2.length

  dp = Array.new(m + 1) { Array.new(n + 1, 0) }

  (0..m).each { |i| dp[i][0] = i }
  (0..n).each { |j| dp[0][j] = j }

  (1..m).each do |i|
    (1..n).each do |j|
      if word1[i - 1] == word2[j - 1]
        dp[i][j] = dp[i - 1][j - 1]
      else
        dp[i][j] = 1 + [
          dp[i - 1][j],
          dp[i][j - 1],
          dp[i - 1][j - 1]
        ].min
      end
    end
  end

  dp[m][n]
end

def min_distance_1d(word1, word2)
  word1, word2 = word2, word1 if word1.length > word2.length

  m = word1.length
  n = word2.length

  prev = (0..n).to_a

  (1..m).each do |i|
    curr = [i] + Array.new(n, 0)

    (1..n).each do |j|
      if word1[i - 1] == word2[j - 1]
        curr[j] = prev[j - 1]
      else
        curr[j] = 1 + [prev[j], curr[j - 1], prev[j - 1]].min
      end
    end

    prev = curr
  end

  prev[n]
end

def min_distance_with_operations(word1, word2)
  m = word1.length
  n = word2.length

  dp = Array.new(m + 1) { Array.new(n + 1, 0) }
  operations = Array.new(m + 1) { Array.new(n + 1, '') }

  (0..m).each do |i|
    dp[i][0] = i
    operations[i][0] = 'delete' * i
  end

  (0..n).each do |j|
    dp[0][j] = j
    operations[0][j] = 'insert' * j
  end

  (1..m).each do |i|
    (1..n).each do |j|
      if word1[i - 1] == word2[j - 1]
        dp[i][j] = dp[i - 1][j - 1]
        operations[i][j] = operations[i - 1][j - 1]
      else
        delete_cost = dp[i - 1][j]
        insert_cost = dp[i][j - 1]
        replace_cost = dp[i - 1][j - 1]

        min_cost = [delete_cost, insert_cost, replace_cost].min
        dp[i][j] = 1 + min_cost

        if min_cost == delete_cost
          operations[i][j] = "#{operations[i - 1][j]}D"
        elsif min_cost == insert_cost
          operations[i][j] = "#{operations[i][j - 1]}I"
        else
          operations[i][j] = "#{operations[i - 1][j - 1]}R"
        end
      end
    end
  end

  [dp[m][n], operations[m][n]]
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 編集距離（Edit Distance） テスト ==='
  puts

  result1 = min_distance('horse', 'ros')
  puts "Test 1: min_distance('horse', 'ros')"
  puts "結果: #{result1}"
  puts '期待値: 3'
  puts "判定: #{result1 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = min_distance('intention', 'execution')
  puts "Test 2: min_distance('intention', 'execution')"
  puts "結果: #{result2}"
  puts '期待値: 5'
  puts "判定: #{result2 == 5 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = min_distance('', 'a')
  puts "Test 3: min_distance('', 'a')"
  puts "結果: #{result3}"
  puts '期待値: 1'
  puts "判定: #{result3 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = min_distance_with_operations('horse', 'ros')
  puts "min_distance_with_operations('horse', 'ros') = #{result4}"
  puts "判定: #{result4[0] == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
