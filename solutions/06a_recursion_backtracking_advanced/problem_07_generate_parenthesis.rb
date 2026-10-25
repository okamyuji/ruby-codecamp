#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin generate_parenthesis
# 解法1: バックトラック
def generate_parenthesis(n)
  result = []
  backtrack_paren('', 0, 0, n, result)
  result
end

def backtrack_paren(current, open_count, close_count, n, result)
  # ベースケース
  if current.length == 2 * n
    result << current
    return
  end

  # 開き括弧を追加
  if open_count < n
    backtrack_paren("#{current}(", open_count + 1, close_count, n, result)
  end

  # 閉じ括弧を追加（開き括弧より少ない場合のみ）
  if close_count < open_count
    backtrack_paren("#{current})", open_count, close_count + 1, n, result)
  end
end

# 解法2: クロージャーナンバー
def generate_parenthesis_closure(n)
  return [''] if n == 0

  result = []

  (0...n).each do |c|
    (0...n).each do |i|
      left = generate_parenthesis_closure(c)
      right = generate_parenthesis_closure(i)

      next unless c + i + 1 == n

      left.each do |l|
        right.each do |r|
          result << "(#{l})#{r}"
        end
      end
    end
  end

  result
end

# 解法3: 動的計画法
def generate_parenthesis_dp(n)
  dp = Array.new(n + 1) { [] }
  dp[0] = ['']

  (1..n).each do |i|
    (0...i).each do |c|
      dp[c].each do |left|
        dp[i - 1 - c].each do |right|
          dp[i] << "(#{left})#{right}"
        end
      end
    end
  end

  dp[n]
end

# テストケース
p generate_parenthesis(3)
# => ["((()))", "(()())", "(())()", "()(())", "()()()"]
p generate_parenthesis(1)
# => ["()"]
p generate_parenthesis(2)
# => ["(())", "()()"]
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 括弧の生成 テスト ==='
  puts

  result1 = generate_parenthesis(3)
  puts 'Test 1: generate_parenthesis(3)'
  puts "結果: #{result1.sort}"
  expected1 = ['((()))', '(()())', '(())()', '()(())', '()()()']
  puts "期待値: #{expected1.sort}"
  puts "判定: #{result1.sort == expected1.sort ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = generate_parenthesis(1)
  puts 'Test 2: generate_parenthesis(1)'
  puts "結果: #{result2}"
  puts "期待値: ['()']"
  puts "判定: #{result2 == ['()'] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = generate_parenthesis(2)
  puts 'Test 3: generate_parenthesis(2)'
  puts "結果: #{result3.sort}"
  expected3 = ['(())', '()()']
  puts "期待値: #{expected3.sort}"
  puts "判定: #{result3.sort == expected3.sort ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
