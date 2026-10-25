#!/usr/bin/env ruby
# frozen_string_literal: true

require 'prime'

# docs:begin prime?
# 解法1: 効率的な実装（推奨）
def prime?(n)
  # 1以下は素数ではない
  return false if n < 2
  # 2は唯一の偶数の素数
  return true if n == 2
  # 2より大きい偶数は素数ではない
  return false if n.even?

  # 3からsqrt(n)までの奇数でチェック
  limit = Math.sqrt(n).to_i
  (3..limit).step(2).none? { |i| n % i == 0 }
end

# 解法2: Rubyの組み込みを使用

def prime_builtin?(n)
  Prime.prime?(n)
end

# 解法3: シンプルな実装
def prime_simple?(n)
  return false if n < 2

  (2...n).none? { |i| n % i == 0 }
end

# 解法4: 6k ± 1 最適化
def prime_optimized?(n)
  return false if n < 2
  return true if n == 2 || n == 3
  return false if n % 2 == 0 || n % 3 == 0

  # すべての素数は6k ± 1の形（2と3を除く）
  i = 5
  while i * i <= n
    return false if n % i == 0 || n % (i + 2) == 0

    i += 6
  end

  true
end

# テストケース
puts prime?(17)   # => true
puts prime?(4)    # => false
puts prime?(2)    # => true
puts prime?(1)    # => false
puts prime?(97)   # => true
puts prime?(100)  # => false
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 素数判定 テスト ==='
  puts

  result1 = prime?(17)
  puts 'Test 1: prime?(17)'
  puts "結果: #{result1}"
  puts '期待値: true'
  puts "判定: #{result1 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = prime?(4)
  puts 'Test 2: prime?(4)'
  puts "結果: #{result2}"
  puts '期待値: false'
  puts "判定: #{result2 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = prime?(2)
  puts 'Test 3: prime?(2)'
  puts "結果: #{result3}"
  puts '期待値: true'
  puts "判定: #{result3 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = prime?(1)
  puts 'Test 4: prime?(1)'
  puts "結果: #{result4}"
  puts '期待値: false'
  puts "判定: #{result4 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = prime?(97)
  puts 'Test 5: prime?(97)'
  puts "結果: #{result5}"
  puts '期待値: true'
  puts "判定: #{result5 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result6 = prime?(100)
  puts 'Test 6: prime?(100)'
  puts "結果: #{result6}"
  puts '期待値: false'
  puts "判定: #{result6 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
