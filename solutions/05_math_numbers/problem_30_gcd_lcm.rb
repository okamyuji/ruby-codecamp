#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin gcd_lcm
# 解法1: 組み込みメソッドを使用（推奨）
def gcd_lcm(a, b)
  {
    gcd: a.gcd(b),
    lcm: a.lcm(b)
  }
end

# 解法2: ユークリッドの互除法（反復）
def gcd_iterative(a, b)
  a, b = b, a % b while b != 0
  a
end

def lcm_from_gcd(a, b)
  # オーバーフローを避けるため、先に除算
  a / gcd_iterative(a, b) * b
end

# 解法3: ユークリッドの互除法（再帰）
def gcd_recursive(a, b)
  return a if b == 0

  gcd_recursive(b, a % b)
end

# 解法4: 減算法（遅いが理解しやすい）
def gcd_subtraction(a, b)
  while a != b
    if a > b
      a -= b
    else
      b -= a
    end
  end
  a
end

# 解法5: 複数の数のGCD/LCM
def gcd_multiple(*nums)
  nums.reduce { |acc, n| acc.gcd(n) }
end

def lcm_multiple(*nums)
  nums.reduce { |acc, n| acc.lcm(n) }
end

# テストケース
p gcd_lcm(12, 18)  # => {gcd: 6, lcm: 36}
p gcd_lcm(7, 13)   # => {gcd: 1, lcm: 91}
p gcd_lcm(100, 25) # => {gcd: 25, lcm: 100}

puts gcd_iterative(12, 18)      # => 6
puts lcm_from_gcd(12, 18)       # => 36
puts gcd_multiple(12, 18, 24)   # => 6
puts lcm_multiple(4, 6, 8)      # => 24
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 最大公約数と最小公倍数 テスト ==='
  puts

  result1 = gcd_lcm(12, 18)
  puts 'Test 1: gcd_lcm(12, 18)'
  puts "結果: #{result1}"
  puts '期待値: {gcd: 6, lcm: 36}'
  puts "判定: #{result1 == { gcd: 6, lcm: 36 } ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = gcd_lcm(7, 13)
  puts 'Test 2: gcd_lcm(7, 13)'
  puts "結果: #{result2}"
  puts '期待値: {gcd: 1, lcm: 91}'
  puts "判定: #{result2 == { gcd: 1, lcm: 91 } ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = gcd_lcm(100, 25)
  puts 'Test 3: gcd_lcm(100, 25)'
  puts "結果: #{result3}"
  puts '期待値: {gcd: 25, lcm: 100}'
  puts "判定: #{result3 == { gcd: 25, lcm: 100 } ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = gcd_iterative(12, 18)
  puts "gcd_iterative(12, 18) = #{result4}"
  puts "判定: #{result4 == 6 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = lcm_from_gcd(12, 18)
  puts "lcm_from_gcd(12, 18) = #{result5}"
  puts "判定: #{result5 == 36 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result6 = gcd_multiple(12, 18, 24)
  puts "gcd_multiple(12, 18, 24) = #{result6}"
  puts "判定: #{result6 == 6 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result7 = lcm_multiple(4, 6, 8)
  puts "lcm_multiple(4, 6, 8) = #{result7}"
  puts "判定: #{result7 == 24 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
