#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin max_cutter_height
# 解法1: 答えの二分探索
def max_cutter_height(trees, m)
  left = 0
  right = trees.max
  result = 0

  while left <= right
    mid = (left + right) / 2

    # mid の高さで切った場合の木材の量
    wood = trees.sum { |height| [0, height - mid].max }

    if wood >= m
      # 十分な木材が得られる、さらに高く設定できるか試す
      result = mid
      left = mid + 1
    else
      # 木材が不足、もっと低く設定する必要がある
      right = mid - 1
    end
  end

  result
end

# 解法2: より明示的な実装
def max_cutter_height_explicit(trees, m)
  left = 0
  right = trees.max

  while left < right
    # 上界を探索（最大値を求めるため mid を切り上げ）
    mid = (left + right + 1) / 2

    wood = calculate_wood(trees, mid)

    if wood >= m
      left = mid
    else
      right = mid - 1
    end
  end

  left
end

def calculate_wood(trees, height)
  trees.sum { |tree| tree > height ? tree - height : 0 }
end

# テストケース
p max_cutter_height([20, 15, 10, 17], 7) # => 15
p max_cutter_height([4, 42, 40, 26, 46], 20) # => 36
p max_cutter_height([1, 2, 3, 4, 5], 5) # => 2
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 木材の切断（答えの二分探索） テスト ==='
  puts

  result1 = max_cutter_height([20, 15, 10, 17], 7)
  puts 'Test 1: max_cutter_height([20, 15, 10, 17], 7)'
  puts "結果: #{result1}"
  puts '期待値: 15'
  puts "判定: #{result1 == 15 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = max_cutter_height([4, 42, 40, 26, 46], 20)
  puts 'Test 2: max_cutter_height([4, 42, 40, 26, 46], 20)'
  puts "結果: #{result2}"
  puts '期待値: 36'
  puts "判定: #{result2 == 36 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = max_cutter_height([1, 2, 3, 4, 5], 5)
  puts 'Test 3: max_cutter_height([1, 2, 3, 4, 5], 5)'
  puts "結果: #{result3}"
  puts '期待値: 2'
  puts "判定: #{result3 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
