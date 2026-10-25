#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin missing_number
# 解法1: 合計の差を使用
def missing_number(nums)
  n = nums.length
  expected_sum = n * (n + 1) / 2
  actual_sum = nums.sum

  expected_sum - actual_sum
end

# 解法2: XOR演算を使用
def missing_number_xor(nums)
  result = nums.length

  nums.each_with_index do |num, i|
    result ^= i ^ num
  end

  result
end

# 解法3: Negative Markingを使用
def missing_number_marking(nums)
  n = nums.length
  # 0 は負にできずマークが残らないため、値を1ずらしてからマークする
  nums.map! { |num| num + 1 }

  # 各数字に対応する位置を負にしてマーク（n は配列外なので飛ばす）
  nums.each do |num|
    idx = num.abs - 1
    nums[idx] = -nums[idx].abs if idx < n
  end

  # 正の値のインデックスが消えた数字
  nums.each_with_index do |num, i|
    return i if num.positive?
  end

  n
end

# テストケース
p missing_number([3, 0, 1])        # => 2
p missing_number([0, 1])           # => 2
p missing_number([9, 6, 4, 2, 3, 5, 7, 0, 1]) # => 8

p missing_number_xor([3, 0, 1]) # => 2
p missing_number_marking([3, 0, 1])  # => 2
p missing_number_marking([0, 1])     # => 2
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 消えた数字を見つける テスト ==='
  puts

  result1 = missing_number([3, 0, 1])
  puts 'Test 1: missing_number([3, 0, 1])'
  puts "結果: #{result1}"
  puts '期待値: 2'
  puts "判定: #{result1 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = missing_number([0, 1])
  puts 'Test 2: missing_number([0, 1])'
  puts "結果: #{result2}"
  puts '期待値: 2'
  puts "判定: #{result2 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = missing_number([9, 6, 4, 2, 3, 5, 7, 0, 1])
  puts 'Test 3: missing_number([9, 6, 4, 2, 3, 5, 7, 0, 1])'
  puts "結果: #{result3}"
  puts '期待値: 8'
  puts "判定: #{result3 == 8 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = missing_number_xor([3, 0, 1])
  puts "missing_number_xor([3, 0, 1]) = #{result4}"
  puts "判定: #{result4 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = missing_number_marking([3, 0, 1].dup)
  puts "missing_number_marking([3, 0, 1]) = #{result5}"
  puts "判定: #{result5 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
