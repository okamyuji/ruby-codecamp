#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin my_sqrt
# 解法1: 二分探索
def my_sqrt(x)
  return x if x < 2

  left = 0
  right = x

  while left <= right
    mid = (left + right) / 2
    square = mid * mid

    return mid if square == x

    if square < x
      left = mid + 1
    else
      right = mid - 1
    end
  end

  right
end

# 解法2: より効率的な範囲設定
def my_sqrt_optimized(x)
  return x if x < 2

  left = 1
  right = x / 2 # √x <= x/2 for x >= 2

  while left <= right
    mid = (left + right) / 2
    square = mid * mid

    return mid if square == x

    if square < x
      left = mid + 1
    else
      right = mid - 1
    end
  end

  right
end

# 解法3: ニュートン法
def my_sqrt_newton(x)
  return x if x < 2

  guess = x.to_f

  guess = (guess + x / guess) / 2 while (guess * guess - x).abs >= 0.5

  guess.to_i
end

# 解法4: 組み込み関数（比較用）
def my_sqrt_builtin(x)
  Math.sqrt(x).to_i
end

# テストケース
p my_sqrt(4)   # => 2
p my_sqrt(8)   # => 2
p my_sqrt(16)  # => 4
p my_sqrt(0)   # => 0
p my_sqrt(1)   # => 1
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 平方根の計算（整数部分） テスト ==='
  puts

  result1 = my_sqrt(4)
  puts 'Test 1: my_sqrt(4)'
  puts "結果: #{result1}"
  puts '期待値: 2'
  puts "判定: #{result1 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = my_sqrt(8)
  puts 'Test 2: my_sqrt(8)'
  puts "結果: #{result2}"
  puts '期待値: 2'
  puts "判定: #{result2 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = my_sqrt(16)
  puts 'Test 3: my_sqrt(16)'
  puts "結果: #{result3}"
  puts '期待値: 4'
  puts "判定: #{result3 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = my_sqrt(0)
  puts 'Test 4: my_sqrt(0)'
  puts "結果: #{result4}"
  puts '期待値: 0'
  puts "判定: #{result4 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = my_sqrt(1)
  puts 'Test 5: my_sqrt(1)'
  puts "結果: #{result5}"
  puts '期待値: 1'
  puts "判定: #{result5 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
