#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin binary_search
# 解法1: 反復的な二分探索（推奨）
def binary_search(nums, target)
  left = 0
  right = nums.length - 1

  while left <= right
    # オーバーフローを避ける計算方法
    mid = left + (right - left) / 2

    if nums[mid] == target
      return mid
    elsif nums[mid] < target
      # 目標値は右半分にある
      left = mid + 1
    else
      # 目標値は左半分にある
      right = mid - 1
    end
  end

  -1  # 見つからない
end

# 解法2: 組み込みメソッドを使用
def binary_search_builtin(nums, target)
  # bsearchはブロックの戻り値で探索方向を決定
  index = nums.bsearch_index { |x| x >= target }
  index && nums[index] == target ? index : -1
end

# 解法3: 再帰的な二分探索
def binary_search_recursive(nums, target, left = 0, right = nil)
  right ||= nums.length - 1

  return -1 if left > right

  mid = left + (right - left) / 2

  if nums[mid] == target
    mid
  elsif nums[mid] < target
    binary_search_recursive(nums, target, mid + 1, right)
  else
    binary_search_recursive(nums, target, left, mid - 1)
  end
end

# 解法4: indexを使用（線形探索、参考）
def linear_search(nums, target)
  nums.index(target) || -1
end

# テストケース
puts binary_search([-1, 0, 3, 5, 9, 12], 9)   # => 4
puts binary_search([-1, 0, 3, 5, 9, 12], 2)   # => -1
puts binary_search([5], 5)                     # => 0
puts binary_search([], 5)                      # => -1
puts binary_search([1, 2, 3, 4, 5], 1) # => 0
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 二分探索 テスト ==='
  puts

  result1 = binary_search([-1, 0, 3, 5, 9, 12], 9)
  puts 'Test 1: binary_search([-1, 0, 3, 5, 9, 12], 9)'
  puts "結果: #{result1}"
  puts '期待値: 4'
  puts "判定: #{result1 == 4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = binary_search([-1, 0, 3, 5, 9, 12], 2)
  puts 'Test 2: binary_search([-1, 0, 3, 5, 9, 12], 2)'
  puts "結果: #{result2}"
  puts '期待値: -1'
  puts "判定: #{result2 == -1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = binary_search([5], 5)
  puts 'Test 3: binary_search([5], 5)'
  puts "結果: #{result3}"
  puts '期待値: 0'
  puts "判定: #{result3 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = binary_search([], 5)
  puts 'Test 4: binary_search([], 5)'
  puts "結果: #{result4}"
  puts '期待値: -1'
  puts "判定: #{result4 == -1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = binary_search([1, 2, 3, 4, 5], 1)
  puts 'Test 5: binary_search([1, 2, 3, 4, 5], 1)'
  puts "結果: #{result5}"
  puts '期待値: 0'
  puts "判定: #{result5 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
