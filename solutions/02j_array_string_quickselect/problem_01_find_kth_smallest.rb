#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin find_kth_smallest
# 解法1: Quickselect
def find_kth_smallest(nums, k)
  left = 0
  right = nums.length - 1

  loop do
    return nums[left] if left == right

    # パーティション
    pivot_idx = partition(nums, left, right)

    # k-1 はゼロインデックス
    if k - 1 == pivot_idx
      return nums[pivot_idx]
    elsif k - 1 < pivot_idx
      right = pivot_idx - 1
    else
      left = pivot_idx + 1
    end
  end
end

def partition(nums, left, right)
  # ランダムなピボットを選んで右端と交換（最悪ケースを回避）
  pivot_idx = rand(left..right)
  nums[pivot_idx], nums[right] = nums[right], nums[pivot_idx]

  pivot = nums[right]
  i = left

  (left...right).each do |j|
    if nums[j] < pivot
      nums[i], nums[j] = nums[j], nums[i]
      i += 1
    end
  end

  nums[i], nums[right] = nums[right], nums[i]
  i
end

# 解法2: ソートを使用（比較用）
def find_kth_smallest_sort(nums, k)
  nums.sort[k - 1]
end

# 解法3: MinHeapを使用
def find_kth_smallest_heap(nums, k)
  # Rubyには組み込みのMinHeapがないので、MaxHeapを負の値で使用
  heap = []

  nums.each do |num|
    heap << -num
    heap.sort! # 簡易実装（実際はheapifyを使用）
    heap.shift if heap.size > k
  end

  -heap[0]
end

# テストケース
p find_kth_smallest([3, 2, 1, 5, 6, 4], 2) # => 2
p find_kth_smallest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4) # => 3
p find_kth_smallest([1], 1) # => 1
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 配列のk番目に小さい要素 テスト ==='
  puts

  result1 = find_kth_smallest([3, 2, 1, 5, 6, 4].dup, 2)
  puts 'Test 1: find_kth_smallest([3, 2, 1, 5, 6, 4], 2)'
  puts "結果: #{result1}"
  puts '期待値: 2'
  puts "判定: #{result1 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = find_kth_smallest([3, 2, 3, 1, 2, 4, 5, 5, 6].dup, 4)
  puts 'Test 2: find_kth_smallest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4)'
  puts "結果: #{result2}"
  puts '期待値: 3'
  puts "判定: #{result2 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = find_kth_smallest([1].dup, 1)
  puts 'Test 3: find_kth_smallest([1], 1)'
  puts "結果: #{result3}"
  puts '期待値: 1'
  puts "判定: #{result3 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = find_kth_smallest_sort([3, 2, 1, 5, 6, 4], 2)
  puts "find_kth_smallest_sort([3, 2, 1, 5, 6, 4], 2) = #{result4}"
  puts "判定: #{result4 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = find_kth_smallest_heap([3, 2, 1, 5, 6, 4], 2)
  puts "find_kth_smallest_heap([3, 2, 1, 5, 6, 4], 2) = #{result5}"
  puts "判定: #{result5 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
