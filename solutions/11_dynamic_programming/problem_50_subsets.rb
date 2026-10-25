#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin subsets
# 解法1: 組み込みメソッドを使用
def subsets(nums)
  (0..nums.length).flat_map { |k| nums.combination(k).to_a }
end

# 解法2: 反復的に構築（推奨）
def subsets_iterative(nums)
  result = [[]]

  nums.each do |num|
    # 既存の各部分集合にnumを追加した新しい部分集合を作成
    new_subsets = result.map { |subset| subset + [num] }
    result.concat(new_subsets)
  end

  result
end

# 解法3: バックトラッキング
def subsets_backtrack(nums)
  result = []
  backtrack_subsets(nums, 0, [], result)
  result
end

def backtrack_subsets(nums, start, current, result)
  # 現在の部分集合を結果に追加
  result << current.dup

  (start...nums.length).each do |i|
    # 要素を追加
    current << nums[i]
    # 次の要素から再帰
    backtrack_subsets(nums, i + 1, current, result)
    # バックトラック
    current.pop
  end
end

# 解法4: ビット演算を使用
def subsets_bit(nums)
  n = nums.length
  result = []

  # 0から2^n - 1までの各数をビットマスクとして使用
  (0...(1 << n)).each do |mask|
    subset = []

    (0...n).each do |i|
      # i番目のビットが1なら、nums[i]を含める
      subset << nums[i] if (mask & (1 << i)) != 0
    end

    result << subset
  end

  result
end

# 解法5: 再帰的な実装
def subsets_recursive(nums)
  return [[]] if nums.empty?

  first = nums[0]
  rest = nums[1..]

  # 残りの要素の部分集合
  rest_subsets = subsets_recursive(rest)

  # firstを含む部分集合と含まない部分集合
  rest_subsets + rest_subsets.map { |s| [first] + s }
end

# 発展: 重複を含む配列の部分集合
def subsets_with_dup(nums)
  nums.sort!
  result = [[]]
  start = 0

  nums.each_with_index do |num, i|
    # 重複の場合は前回追加した部分集合のみを拡張
    from = i > 0 && num == nums[i - 1] ? start : 0
    start = result.length
    result.concat(result[from...start].map { |subset| subset + [num] })
  end

  result
end

# テストケース
p subsets([1, 2, 3])
# => [[], [1], [2], [3], [1, 2], [1, 3], [2, 3], [1, 2, 3]]

p subsets_iterative([1, 2])
# => [[], [1], [2], [1, 2]]

p subsets_bit([1, 2, 3])
# => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

p subsets([])
# => [[]]

p subsets_with_dup([1, 2, 2])
# => [[], [1], [2], [1, 2], [2, 2], [1, 2, 2]]
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 部分集合（Subsets） テスト ==='
  puts

  result1 = subsets([1, 2, 3])
  puts 'Test 1: subsets([1, 2, 3])'
  puts "結果の数: #{result1.length}"
  puts '期待値: 8個の部分集合'
  puts "判定: #{result1.length == 8 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = subsets_iterative([1, 2])
  puts 'Test 2: subsets_iterative([1, 2])'
  puts "結果: #{result2.map(&:sort).sort}"
  expected2 = [[], [1], [2], [1, 2]]
  puts "期待値: #{expected2.map(&:sort).sort}"
  puts "判定: #{result2.map(&:sort).sort == expected2.map(&:sort).sort ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = subsets_bit([1, 2, 3])
  puts 'Test 3: subsets_bit([1, 2, 3])'
  puts "結果の数: #{result3.length}"
  puts '期待値: 8個の部分集合'
  puts "判定: #{result3.length == 8 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = subsets([])
  puts 'Test 4: subsets([])'
  puts "結果: #{result4}"
  puts '期待値: [[]]'
  puts "判定: #{result4 == [[]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = subsets_with_dup([1, 2, 2])
  puts 'Test 5: subsets_with_dup([1, 2, 2])'
  puts "結果の数: #{result5.length}"
  puts '期待値: 6個の部分集合'
  puts "判定: #{result5.length == 6 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
