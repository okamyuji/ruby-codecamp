#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 配列のパーティション
# ファイル: 02g_array_string_two_pointers.md
# ============================================================================
#
# 整数の配列とピボット値が与えられます。ピボットより小さい要素を左に、ピボット以上の要素を
# 右に配置してください。
#
# 入力例:
#   nums = [3, 5, 2, 1, 6, 4], pivot = 3
# 出力例: [2, 1, 3, 5, 6, 4]  # または他の有効な配置
#
# 時間計算量: O(n)
# 空間計算量: O(1)
# ============================================================================

# 解法1: Two Pointers
def partition(nums, pivot)
  left = 0
  right = nums.length - 1

  while left <= right
    # 左から pivot 以上の要素を探す
    left += 1 while left < right && nums[left] < pivot

    # 右から pivot より小さい要素を探す
    right -= 1 while left < right && nums[right] >= pivot

    # 交換
    next unless left < right

    nums[left], nums[right] = nums[right], nums[left]
    left += 1
    right -= 1
  end

  nums
end

# 解法2: 3-way partition（pivot未満、等しい、より大きい）
def three_way_partition(nums, pivot)
  less = 0
  equal = 0
  greater = nums.length - 1

  while equal <= greater
    if nums[equal] < pivot
      nums[less], nums[equal] = nums[equal], nums[less]
      less += 1
      equal += 1
    elsif nums[equal] == pivot
      equal += 1
    else
      nums[equal], nums[greater] = nums[greater], nums[equal]
      greater -= 1
    end
  end

  nums
end

# 解法3: selectで新しい配列を作成
def partition_new_array(nums, pivot)
  less = nums.select { |x| x < pivot }
  equal = nums.select { |x| x == pivot }
  greater = nums.select { |x| x > pivot }

  less + equal + greater
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 配列のパーティション テスト ==='
  puts

  # テストケース1: 通常のケース
  nums1 = [3, 5, 2, 1, 6, 4]
  result1 = partition(nums1.dup, 3)
  puts 'Test 1: partition([3, 5, 2, 1, 6, 4], 3)'
  puts "結果: #{result1}"
  # pivot未満の要素が左、pivot以上の要素が右にあることを確認
  pivot_pos = result1.index { |x| x >= 3 }
  left_ok = pivot_pos.nil? || result1[0...pivot_pos].all? { |x| x < 3 }
  right_ok = pivot_pos.nil? || result1[pivot_pos..].all? { |x| x >= 3 }
  puts "判定: #{left_ok && right_ok ? '✓ PASS' : '✗ FAIL'} (pivot未満が左、以上が右)"
  puts

  # テストケース2: 全て小さい
  nums2 = [1, 2, 1]
  result2 = partition(nums2.dup, 5)
  puts 'Test 2: partition([1, 2, 1], 5)'
  puts "結果: #{result2}"
  puts "判定: #{result2.all? { |x| x < 5 } ? '✓ PASS' : '✗ FAIL'} (全てpivot未満)"
  puts

  # 解法2のテスト（3-way partition）
  puts '--- 解法2（3-way partition）のテスト ---'
  nums3 = [3, 5, 2, 1, 6, 4, 3]
  result3 = three_way_partition(nums3.dup, 3)
  puts "three_way_partition([3, 5, 2, 1, 6, 4, 3], 3) = #{result3}"
  # pivot未満、等しい、より大きいの順になっていることを確認
  less_count = result3.count { |x| x < 3 }
  equal_count = result3.count { |x| x == 3 }
  less_ok = result3[0...less_count].all? { |x| x < 3 }
  equal_ok = result3[less_count...(less_count + equal_count)].all? { |x| x == 3 }
  greater_ok = result3[(less_count + equal_count)..].all? { |x| x > 3 }
  puts "判定: #{less_ok && equal_ok && greater_ok ? '✓ PASS' : '✗ FAIL'} (未満、等しい、より大きいの順)"
  puts

  # 解法3のテスト（新しい配列）
  puts '--- 解法3（新しい配列）のテスト ---'
  result4 = partition_new_array([3, 5, 2, 1, 6, 4], 3)
  puts "partition_new_array([3, 5, 2, 1, 6, 4], 3) = #{result4}"
  puts '期待値: [2, 1, 3, 5, 6, 4]'
  puts "判定: #{result4 == [2, 1, 3, 5, 6, 4] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
