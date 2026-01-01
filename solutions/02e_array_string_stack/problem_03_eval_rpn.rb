#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 逆ポーランド記法の評価
# ファイル: 02e_array_string_stack.md
# ============================================================================
#
# 逆ポーランド記法（後置記法）で表現された算術式を評価してください。
#
# 入力例: ["2", "1", "+", "3", "*"]
# 出力例: 9  # ((2 + 1) * 3) = 9
#
# 時間計算量: O(n)
# 空間計算量: O(n)
# ============================================================================

# 解法1: 基本的な実装
def eval_rpn(tokens)
  stack = []
  operators = %w[+ - * /]

  tokens.each do |token|
    if operators.include?(token)
      right = stack.pop
      left = stack.pop

      result = case token
               when '+'
                 left + right
               when '-'
                 left - right
               when '*'
                 left * right
               when '/'
                 (left.to_f / right).to_i
               end

      stack << result
    else
      stack << token.to_i
    end
  end

  stack[0]
end

# 解法2: sendを使用
def eval_rpn_send(tokens)
  stack = []

  tokens.each do |token|
    if %w[+ - * /].include?(token)
      right = stack.pop
      left = stack.pop

      result = if token == '/'
                 (left.to_f / right).to_i
               else
                 left.send(token, right)
               end

      stack << result
    else
      stack << token.to_i
    end
  end

  stack[0]
end

# 解法3: ハッシュで演算子を管理
def eval_rpn_hash(tokens)
  stack = []

  operations = {
    '+' => ->(a, b) { a + b },
    '-' => ->(a, b) { a - b },
    '*' => ->(a, b) { a * b },
    '/' => ->(a, b) { (a.to_f / b).to_i }
  }

  tokens.each do |token|
    if operations.key?(token)
      right = stack.pop
      left = stack.pop
      stack << operations[token].call(left, right)
    else
      stack << token.to_i
    end
  end

  stack[0]
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 逆ポーランド記法の評価 テスト ==='
  puts

  # テストケース1: (2 + 1) * 3 = 9
  result1 = eval_rpn(['2', '1', '+', '3', '*'])
  puts "Test 1: eval_rpn(['2', '1', '+', '3', '*'])"
  puts "結果: #{result1}"
  puts '期待値: 9 ((2 + 1) * 3)'
  puts "判定: #{result1 == 9 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 4 + (13 / 5) = 6
  result2 = eval_rpn(['4', '13', '5', '/', '+'])
  puts "Test 2: eval_rpn(['4', '13', '5', '/', '+'])"
  puts "結果: #{result2}"
  puts '期待値: 6 (4 + (13 / 5))'
  puts "判定: #{result2 == 6 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 複雑な式
  result3 = eval_rpn(['10', '6', '9', '3', '+', '-11', '*', '/', '*', '17', '+', '5', '+'])
  puts "Test 3: eval_rpn(['10', '6', '9', '3', '+', '-11', '*', '/', '*', '17', '+', '5', '+'])"
  puts "結果: #{result3}"
  puts '期待値: 22'
  puts "判定: #{result3 == 22 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 単純な加算
  result4 = eval_rpn(['3', '4', '+'])
  puts "Test 4: eval_rpn(['3', '4', '+'])"
  puts "結果: #{result4}"
  puts '期待値: 7'
  puts "判定: #{result4 == 7 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（send）
  puts '--- 解法2（send）のテスト ---'
  result5 = eval_rpn_send(['2', '1', '+', '3', '*'])
  puts "eval_rpn_send(['2', '1', '+', '3', '*']) = #{result5}"
  puts "判定: #{result5 == 9 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（ハッシュ）
  puts '--- 解法3（ハッシュ）のテスト ---'
  result6 = eval_rpn_hash(['2', '1', '+', '3', '*'])
  puts "eval_rpn_hash(['2', '1', '+', '3', '*']) = #{result6}"
  puts "判定: #{result6 == 9 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
