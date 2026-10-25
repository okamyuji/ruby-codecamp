#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin two_sum
# 解法1: ハッシュマップを使用（推奨）
def two_sum(nums, target)
  # 値をキー、インデックスを値とするハッシュ
  num_to_index = {}

  nums.each_with_index do |num, index|
    # 目標値を達成するために必要な数（補数）
    complement = target - num

    # 補数が既にハッシュに存在すれば、答えを見つけた
    if num_to_index.key?(complement)
      return [num_to_index[complement], index]
    end

    # 現在の数とそのインデックスをハッシュに追加
    num_to_index[num] = index
  end

  nil # 解が見つからない場合
end

# 解法2: ブルートフォース（参考）
def two_sum_brute_force(nums, target)
  # O(n^2)の時間計算量だが、シンプル
  (0...nums.length).each do |i|
    ((i + 1)...nums.length).each do |j|
      return [i, j] if nums[i] + nums[j] == target
    end
  end

  nil
end

# 解法3: 2パス方式
def two_sum_two_pass(nums, target)
  num_to_index = {}

  # 第1パス: ハッシュを構築
  nums.each_with_index { |num, index| num_to_index[num] = index }

  # 第2パス: 補数を探す
  nums.each_with_index do |num, index|
    complement = target - num

    # 補数が存在し、自分自身でない場合
    if num_to_index.key?(complement) && num_to_index[complement] != index
      return [index, num_to_index[complement]]
    end
  end

  nil
end

# テストケース
p two_sum([2, 7, 11, 15], 9)   # => [0, 1]
p two_sum([3, 2, 4], 6)        # => [1, 2]
p two_sum([3, 3], 6)           # => [0, 1]
p two_sum([1, 2, 3, 4], 10)    # => nil
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 2つの数の合計（Two Sum） テスト ==='
  puts

  result1 = two_sum([2, 7, 11, 15], 9)
  puts 'Test 1: two_sum([2, 7, 11, 15], 9)'
  puts "結果: #{result1}"
  puts '期待値: [0, 1]'
  puts "判定: #{result1 == [0, 1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = two_sum([3, 2, 4], 6)
  puts 'Test 2: two_sum([3, 2, 4], 6)'
  puts "結果: #{result2}"
  puts '期待値: [1, 2]'
  puts "判定: #{result2 == [1, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = two_sum([3, 3], 6)
  puts 'Test 3: two_sum([3, 3], 6)'
  puts "結果: #{result3}"
  puts '期待値: [0, 1]'
  puts "判定: #{result3 == [0, 1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = two_sum([1, 2, 3, 4], 10)
  puts 'Test 4: two_sum([1, 2, 3, 4], 10)'
  puts "結果: #{result4.inspect}"
  puts '期待値: nil'
  puts "判定: #{result4.nil? ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
