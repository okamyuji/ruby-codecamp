#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin permute
# 解法1: バックトラック（使用済み配列）
def permute(nums)
  result = []
  used = Array.new(nums.length, false)
  backtrack_permute(nums, [], used, result)
  result
end

def backtrack_permute(nums, current, used, result)
  # ベースケース
  if current.length == nums.length
    result << current.dup
    return
  end

  # 各要素を試す
  nums.each_with_index do |num, i|
    next if used[i]

    # 選択
    current << num
    used[i] = true

    # 再帰
    backtrack_permute(nums, current, used, result)

    # バックトラック
    current.pop
    used[i] = false
  end
end

# 解法2: スワップを使用
def permute_swap(nums)
  result = []
  backtrack_swap(nums.dup, 0, result)
  result
end

def backtrack_swap(nums, start, result)
  if start == nums.length
    result << nums.dup
    return
  end

  (start...nums.length).each do |i|
    # スワップ
    nums[start], nums[i] = nums[i], nums[start]

    # 再帰
    backtrack_swap(nums, start + 1, result)

    # バックトラック
    nums[start], nums[i] = nums[i], nums[start]
  end
end

# 解法3: 再帰的に構築
def permute_recursive(nums)
  return [[]] if nums.empty?
  return [nums] if nums.length == 1

  result = []

  nums.each_with_index do |num, i|
    # 現在の要素を除いた残りで順列を生成
    rest = nums[0...i] + nums[(i + 1)..]

    permute_recursive(rest).each do |perm|
      result << [num] + perm
    end
  end

  result
end

# テストケース
p permute([1, 2, 3]) # => [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
p permute([0, 1]) # => [[0, 1], [1, 0]]
p permute([1]) # => [[1]]
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 順列の生成 テスト ==='
  puts

  result1 = permute([1, 2, 3])
  puts 'Test 1: permute([1, 2, 3])'
  puts "結果の数: #{result1.length}"
  puts '期待値: 6個の順列'
  puts "判定: #{result1.length == 6 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = permute([0, 1])
  puts 'Test 2: permute([0, 1])'
  puts "結果: #{result2}"
  puts '期待値: [[0,1], [1,0]]'
  puts "判定: #{result2.sort == [[0, 1], [1, 0]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = permute([1])
  puts 'Test 3: permute([1])'
  puts "結果: #{result3}"
  puts '期待値: [[1]]'
  puts "判定: #{result3 == [[1]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
