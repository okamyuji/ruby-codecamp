#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin find_kth_largest
# 解法1: ソートを使用（シンプル）
def find_kth_largest(nums, k)
  # 降順にソートしてk番目を取得
  nums.sort.reverse[k - 1]
end

# 解法2: sort_byを使用
def find_kth_largest_sort_by(nums, k)
  nums.sort_by { |x| -x }[k - 1]
end

# 解法3: 最大ヒープを使用（概念的な実装）
def find_kth_largest_heap(nums, k)
  # Rubyには標準のヒープがないが、maxを使用して模倣
  heap = nums.dup

  (k - 1).times do
    max_val = heap.max
    heap.delete_at(heap.index(max_val))
  end

  heap.max
end

# 解法4: クイックセレクト
def find_kth_largest_quickselect(nums, k)
  # k番目に大きい = (n - k + 1)番目に小さい
  quickselect(nums.dup, nums.length - k)
end

def quickselect(arr, k)
  pivot = arr.sample

  smaller = arr.select { |x| x < pivot }
  equal = arr.select { |x| x == pivot }
  larger = arr.select { |x| x > pivot }

  if k < smaller.length
    quickselect(smaller, k)
  elsif k < smaller.length + equal.length
    pivot
  else
    quickselect(larger, k - smaller.length - equal.length)
  end
end

# 解法5: 部分ソートを使用
def find_kth_largest_partial(nums, k)
  nums.max(k).last
end

# テストケース
puts find_kth_largest([3, 2, 1, 5, 6, 4], 2)          # => 5
puts find_kth_largest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4) # => 4
puts find_kth_largest([1], 1)                         # => 1
puts find_kth_largest([7, 6, 5, 4, 3, 2, 1], 5)       # => 3
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== K番目に大きい要素 テスト ==='
  puts

  result1 = find_kth_largest([3, 2, 1, 5, 6, 4], 2)
  puts 'Test 1: find_kth_largest([3, 2, 1, 5, 6, 4], 2)'
  puts "結果: #{result1}"
  puts '期待値: 5'
  puts "判定: #{result1 == 5 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = find_kth_largest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4)
  puts 'Test 2: find_kth_largest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4)'
  puts "結果: #{result2}"
  puts '期待値: 4'
  puts "判定: #{result2 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = find_kth_largest([1], 1)
  puts 'Test 3: find_kth_largest([1], 1)'
  puts "結果: #{result3}"
  puts '期待値: 1'
  puts "判定: #{result3 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = find_kth_largest([7, 6, 5, 4, 3, 2, 1], 5)
  puts 'Test 4: find_kth_largest([7, 6, 5, 4, 3, 2, 1], 5)'
  puts "結果: #{result4}"
  puts '期待値: 3'
  puts "判定: #{result4 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
