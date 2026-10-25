#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin find_peak_element
# 解法1: 二分探索
def find_peak_element(nums)
  left = 0
  right = nums.length - 1

  while left < right
    mid = (left + right) / 2

    if nums[mid] < nums[mid + 1]
      # 上り坂、ピークは右側
      left = mid + 1
    else
      # 下り坂、ピークは左側または mid
      right = mid
    end
  end

  left
end

# 解法2: 線形探索（比較用）
def find_peak_element_linear(nums)
  (0...(nums.length - 1)).each do |i|
    return i if nums[i] > nums[i + 1]
  end

  nums.length - 1
end

# 解法3: 再帰的二分探索
def find_peak_element_recursive(nums)
  search_peak(nums, 0, nums.length - 1)
end

def search_peak(nums, left, right)
  return left if left == right

  mid = (left + right) / 2

  if nums[mid] < nums[mid + 1]
    search_peak(nums, mid + 1, right)
  else
    search_peak(nums, left, mid)
  end
end

# テストケース
p find_peak_element([1, 2, 3, 1]) # => 2
p find_peak_element([1, 2, 1, 3, 5, 6, 4]) # => 1 または 5
p find_peak_element([1]) # => 0
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 山の配列でのピーク要素の検索 テスト ==='
  puts

  result1 = find_peak_element([1, 2, 3, 1])
  puts 'Test 1: find_peak_element([1, 2, 3, 1])'
  puts "結果: #{result1}"
  puts '期待値: 2'
  puts "判定: #{result1 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = find_peak_element([1, 2, 1, 3, 5, 6, 4])
  puts 'Test 2: find_peak_element([1, 2, 1, 3, 5, 6, 4])'
  puts "結果: #{result2}"
  puts '期待値: 1 または 5'
  puts "判定: #{[1, 5].include?(result2) ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = find_peak_element([1])
  puts 'Test 3: find_peak_element([1])'
  puts "結果: #{result3}"
  puts '期待値: 0'
  puts "判定: #{result3 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
