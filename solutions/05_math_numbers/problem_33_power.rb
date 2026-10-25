#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin power
# 解法1: 組み込み演算子を使用（推奨）
def power(x, n)
  x**n
end

# 解法2: 二分累乗法（効率的）
def power_fast(x, n)
  # 負の指数の処理
  if n < 0
    x = 1.0 / x
    n = -n
  end

  result = 1.0

  while n > 0
    # nが奇数なら、結果にxを掛ける
    result *= x if n.odd?
    # xを2乗
    x *= x
    # nを半分にする
    n /= 2
  end

  result
end

# 解法3: 再帰的な二分累乗法
def power_recursive(x, n)
  return 1.0 if n == 0

  if n < 0
    x = 1.0 / x
    n = -n
  end

  half = power_recursive(x, n / 2)

  if n.even?
    half * half
  else
    half * half * x
  end
end

# 解法4: 反復での単純な実装（遅い）
def power_simple(x, n)
  return 1.0 if n == 0

  if n < 0
    x = 1.0 / x
    n = -n
  end

  result = 1.0
  n.times { result *= x }
  result
end

# テストケース
puts power(2.0, 10)    # => 1024.0
puts power(2.1, 3)     # => 9.261000000000001（浮動小数点の丸め誤差）
puts power(2.0, -2)    # => 0.25
puts power(0.0, 1)     # => 0.0
puts power(1.0, 1000)  # => 1.0
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== べき乗の計算 テスト ==='
  puts

  result1 = power(2.0, 10)
  puts 'Test 1: power(2.0, 10)'
  puts "結果: #{result1}"
  puts '期待値: 1024.0'
  puts "判定: #{result1 == 1024.0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = power(2.1, 3)
  puts 'Test 2: power(2.1, 3)'
  puts "結果: #{result2.round(3)}"
  puts '期待値: 9.261'
  puts "判定: #{result2.round(3) == 9.261 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = power(2.0, -2)
  puts 'Test 3: power(2.0, -2)'
  puts "結果: #{result3}"
  puts '期待値: 0.25'
  puts "判定: #{result3 == 0.25 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = power(0.0, 1)
  puts 'Test 4: power(0.0, 1)'
  puts "結果: #{result4}"
  puts '期待値: 0.0'
  puts "判定: #{result4 == 0.0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = power(1.0, 1000)
  puts 'Test 5: power(1.0, 1000)'
  puts "結果: #{result5}"
  puts '期待値: 1.0'
  puts "判定: #{result5 == 1.0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
