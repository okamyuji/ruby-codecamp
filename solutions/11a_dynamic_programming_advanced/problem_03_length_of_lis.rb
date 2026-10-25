#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin length_of_lis
# 解法1: DP（O(n²)）
def length_of_lis(nums)
  return 0 if nums.empty?

  n = nums.length
  dp = Array.new(n, 1)

  (1...n).each do |i|
    (0...i).each do |j|
      if nums[j] < nums[i]
        dp[i] = [dp[i], dp[j] + 1].max
      end
    end
  end

  dp.max
end

# 解法2: 二分探索（O(n log n)）
def length_of_lis_binary(nums)
  return 0 if nums.empty?

  # tails[i] = 長さ i+1 のLISの末尾の最小値
  tails = []

  nums.each do |num|
    # num が入る位置を二分探索
    idx = tails.bsearch_index { |x| x >= num } || tails.length

    if idx == tails.length
      tails << num
    else
      tails[idx] = num
    end
  end

  tails.length
end

# 解法3: LIS配列を復元
def length_of_lis_with_sequence(nums)
  return [0, []] if nums.empty?

  n = nums.length
  dp = Array.new(n, 1)
  parent = Array.new(n, -1)

  (1...n).each do |i|
    (0...i).each do |j|
      if nums[j] < nums[i] && dp[j] + 1 > dp[i]
        dp[i] = dp[j] + 1
        parent[i] = j
      end
    end
  end

  # 最大長のインデックス
  max_length = dp.max
  max_idx = dp.index(max_length)

  # バックトラック
  lis = []
  idx = max_idx

  while idx != -1
    lis.unshift(nums[idx])
    idx = parent[idx]
  end

  [max_length, lis]
end

# テストケース
p length_of_lis([10, 9, 2, 5, 3, 7, 101, 18]) # => 4
p length_of_lis_binary([10, 9, 2, 5, 3, 7, 101, 18]) # => 4
p length_of_lis_with_sequence([10, 9, 2, 5, 3, 7, 101, 18]) # => [4, [2, 5, 7, 101]]
p length_of_lis([0, 1, 0, 3, 2, 3]) # => 4
p length_of_lis([7, 7, 7, 7, 7, 7, 7]) # => 1
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 最長増加部分列（LIS） テスト ==='
  puts

  result1 = length_of_lis([10, 9, 2, 5, 3, 7, 101, 18])
  puts 'Test 1: length_of_lis([10, 9, 2, 5, 3, 7, 101, 18])'
  puts "結果: #{result1}"
  puts '期待値: 4'
  puts "判定: #{result1 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = length_of_lis_binary([10, 9, 2, 5, 3, 7, 101, 18])
  puts "length_of_lis_binary([10, 9, 2, 5, 3, 7, 101, 18]) = #{result2}"
  puts "判定: #{result2 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = length_of_lis_with_sequence([10, 9, 2, 5, 3, 7, 101, 18])
  puts "length_of_lis_with_sequence([10, 9, 2, 5, 3, 7, 101, 18]) = #{result3}"
  puts "判定: #{result3[0] == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = length_of_lis([0, 1, 0, 3, 2, 3])
  puts "length_of_lis([0, 1, 0, 3, 2, 3]) = #{result4}"
  puts "判定: #{result4 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = length_of_lis([7, 7, 7, 7, 7, 7, 7])
  puts "length_of_lis([7, 7, 7, 7, 7, 7, 7]) = #{result5}"
  puts "判定: #{result5 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
