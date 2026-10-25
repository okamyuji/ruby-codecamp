#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin contains_nearby_duplicate
# 解法1: ハッシュで最後のインデックスを追跡（推奨）
def contains_nearby_duplicate(nums, k)
  # 値をキー、最後に出現したインデックスを値とするハッシュ
  last_index = {}

  nums.each_with_index do |num, index|
    if last_index.key?(num) && (index - last_index[num] <= k)
      # 同じ値が見つかったら、インデックスの差を確認
      return true
    end

    # 最後に出現したインデックスを更新
    last_index[num] = index
  end

  false
end

# 解法2: スライディングウィンドウとセットを使用
def contains_nearby_duplicate_window(nums, k)
  # サイズkのウィンドウ内の要素を追跡
  window = Set.new

  nums.each_with_index do |num, index|
    # ウィンドウがkを超えたら、最も古い要素を削除
    window.delete(nums[index - k - 1]) if index > k

    # 既にウィンドウ内に存在すれば重複
    return true unless window.add?(num)
  end

  false
end

# 解法3: すべてのインデックスを記録
def contains_nearby_duplicate_all_indices(nums, k)
  indices = Hash.new { |h, k| h[k] = [] }

  nums.each_with_index { |num, i| indices[num] << i }

  indices.values.any? do |idx_list|
    idx_list.each_cons(2).any? { |i, j| j - i <= k }
  end
end

# テストケース
puts contains_nearby_duplicate([1, 2, 3, 1], 3)         # => true
puts contains_nearby_duplicate([1, 0, 1, 1], 1)         # => true
puts contains_nearby_duplicate([1, 2, 3, 1, 2, 3], 2)   # => false
puts contains_nearby_duplicate([], 0)                   # => false
puts contains_nearby_duplicate([1], 1)                  # => false
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 近くの重複要素（Contains Nearby Duplicate） テスト ==='
  puts

  result1 = contains_nearby_duplicate([1, 2, 3, 1], 3)
  puts 'Test 1: contains_nearby_duplicate([1, 2, 3, 1], 3)'
  puts "結果: #{result1}"
  puts '期待値: true'
  puts "判定: #{result1 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = contains_nearby_duplicate([1, 0, 1, 1], 1)
  puts 'Test 2: contains_nearby_duplicate([1, 0, 1, 1], 1)'
  puts "結果: #{result2}"
  puts '期待値: true'
  puts "判定: #{result2 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = contains_nearby_duplicate([1, 2, 3, 1, 2, 3], 2)
  puts 'Test 3: contains_nearby_duplicate([1, 2, 3, 1, 2, 3], 2)'
  puts "結果: #{result3}"
  puts '期待値: false'
  puts "判定: #{result3 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = contains_nearby_duplicate([], 0)
  puts 'Test 4: contains_nearby_duplicate([], 0)'
  puts "結果: #{result4}"
  puts '期待値: false'
  puts "判定: #{result4 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = contains_nearby_duplicate([1], 1)
  puts 'Test 5: contains_nearby_duplicate([1], 1)'
  puts "結果: #{result5}"
  puts '期待値: false'
  puts "判定: #{result5 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
