#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin subsets
# 解法1: バックトラック
def subsets(nums)
  result = []
  backtrack_subsets(nums, 0, [], result)
  result
end

def backtrack_subsets(nums, start, current, result)
  # 現在の部分集合を追加
  result << current.dup

  # 次の要素を追加
  (start...nums.length).each do |i|
    current << nums[i]
    backtrack_subsets(nums, i + 1, current, result)
    current.pop
  end
end

# 解法2: ビット演算
def subsets_bit(nums)
  n = nums.length
  result = []

  # 2^n 個の部分集合
  (0...(2**n)).each do |mask|
    subset = []

    n.times do |i|
      # i番目のビットが立っているか
      subset << nums[i] if (mask >> i) & 1 == 1
    end

    result << subset
  end

  result
end

# 解法3: イテレーティブ（カスケード）
def subsets_iterative(nums)
  result = [[]]

  nums.each do |num|
    # 既存の各部分集合に num を追加した新しい部分集合を作成
    new_subsets = result.map { |subset| subset + [num] }
    result.concat(new_subsets)
  end

  result
end

# 解法4: 再帰的
def subsets_recursive(nums)
  return [[]] if nums.empty?

  # 最初の要素を取り出す
  first = nums[0]
  rest_subsets = subsets_recursive(nums[1..])

  # 最初の要素を含まない部分集合と含む部分集合
  rest_subsets + rest_subsets.map { |subset| [first] + subset }
end

# テストケース
p subsets([1, 2, 3]) # => [[], [1], [1, 2], [1, 2, 3], [1, 3], [2], [2, 3], [3]]
p subsets([0]) # => [[], [0]]
p subsets([]) # => [[]]
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 部分集合の生成 テスト ==='
  puts

  result1 = subsets([1, 2, 3])
  puts 'Test 1: subsets([1, 2, 3])'
  puts "結果の数: #{result1.length}"
  puts '期待値: 8個の部分集合'
  puts "判定: #{result1.length == 8 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = subsets([0])
  puts 'Test 2: subsets([0])'
  puts "結果: #{result2.sort}"
  puts '期待値: [[], [0]]'
  puts "判定: #{result2.sort == [[], [0]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = subsets([])
  puts 'Test 3: subsets([])'
  puts "結果: #{result3}"
  puts '期待値: [[]]'
  puts "判定: #{result3 == [[]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
