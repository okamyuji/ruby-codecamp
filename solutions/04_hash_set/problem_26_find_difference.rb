#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin find_difference
# 解法1: セットの差集合演算を使用（推奨）
def find_difference(nums1, nums2)
  set1 = nums1.to_set
  set2 = nums2.to_set

  # -演算子で差集合を計算
  [
    (set1 - set2).to_a,
    (set2 - set1).to_a
  ]
end

# 解法2: 配列の-演算子を使用
def find_difference_array(nums1, nums2)
  # 配列の-演算子も差集合を計算（重複は除去される）
  [
    (nums1 - nums2).uniq,
    (nums2 - nums1).uniq
  ]
end

# 解法3: rejectを使用
def find_difference_reject(nums1, nums2)
  set1 = nums1.to_set
  set2 = nums2.to_set

  [
    nums1.uniq.reject { |n| set2.include?(n) },
    nums2.uniq.reject { |n| set1.include?(n) }
  ]
end

# 解法4: 手動で実装
def find_difference_manual(nums1, nums2)
  in_nums1 = {}
  in_nums2 = {}

  nums1.each { |n| in_nums1[n] = true }
  nums2.each { |n| in_nums2[n] = true }

  diff1 = []
  diff2 = []

  in_nums1.each_key { |n| diff1 << n unless in_nums2[n] }
  in_nums2.each_key { |n| diff2 << n unless in_nums1[n] }

  [diff1, diff2]
end

# テストケース
p find_difference([1, 2, 3], [2, 4, 6])
# => [[1, 3], [4, 6]] または [[3, 1], [6, 4]]

p find_difference([1, 2, 3, 3], [1, 1, 2, 2])
# => [[3], []]

p find_difference([], [1, 2])
# => [[], [1, 2]]
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 配列の差分 テスト ==='
  puts

  result1 = find_difference([1, 2, 3], [2, 4, 6])
  puts 'Test 1: find_difference([1, 2, 3], [2, 4, 6])'
  puts "結果: #{result1.map(&:sort)}"
  expected1 = [[1, 3], [4, 6]]
  puts "期待値: #{expected1}"
  puts "判定: #{result1.map(&:sort).sort == expected1.map(&:sort).sort ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = find_difference([1, 2, 3, 3], [1, 1, 2, 2])
  puts 'Test 2: find_difference([1, 2, 3, 3], [1, 1, 2, 2])'
  puts "結果: #{result2}"
  puts '期待値: [[3], []]'
  puts "判定: #{result2 == [[3], []] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = find_difference([], [1, 2])
  puts 'Test 3: find_difference([], [1, 2])'
  puts "結果: #{result3.map(&:sort)}"
  puts '期待値: [[], [1, 2]]'
  puts "判定: #{result3.map(&:sort) == [[], [1, 2]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
