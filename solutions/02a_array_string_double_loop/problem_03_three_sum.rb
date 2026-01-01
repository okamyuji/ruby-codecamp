#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: Three Sum（3つの数の和がゼロ）
# ファイル: 02a_array_string_double_loop.md
# ============================================================================
#
# 整数の配列が与えられます。配列内の3つの要素の和が0になるすべての一意な組み合わせを
# 見つけてください。
#
# 入力例: [-1, 0, 1, 2, -1, -4]
# 出力例: [[-1, -1, 2], [-1, 0, 1]]
#
# 時間計算量: O(n²) - ソートがO(n log n)、各要素についてO(n)の探索
# 空間計算量: O(1) - 結果配列を除く
# ============================================================================

# 解法1: ソート + Two Pointers（推奨）
def three_sum(nums)
  nums.sort!
  result = []

  (0...(nums.length - 2)).each do |i|
    # 重複する値をスキップ
    next if i.positive? && nums[i] == nums[i - 1]

    left = i + 1
    right = nums.length - 1

    while left < right
      sum = nums[i] + nums[left] + nums[right]

      if sum.zero?
        result << [nums[i], nums[left], nums[right]]

        # 重複をスキップ
        left += 1
        right -= 1
        left += 1 while left < right && nums[left] == nums[left - 1]
        right -= 1 while left < right && nums[right] == nums[right + 1]
      elsif sum.negative?
        left += 1
      else
        right -= 1
      end
    end
  end

  result
end

# 解法2: 三重ループ（効率悪い、O(n³)）
def three_sum_brute_force(nums)
  result = []
  seen = Set.new

  (0...nums.length).each do |i|
    ((i + 1)...nums.length).each do |j|
      ((j + 1)...nums.length).each do |k|
        next unless nums[i] + nums[j] + nums[k] == 0

        triplet = [nums[i], nums[j], nums[k]].sort
        result << triplet unless seen.include?(triplet)
        seen.add(triplet)
      end
    end
  end

  result
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== Three Sum テスト ==='
  puts

  # テストケース1: 通常のケース
  result1 = three_sum([-1, 0, 1, 2, -1, -4])
  puts 'Test 1: three_sum([-1, 0, 1, 2, -1, -4])'
  puts "結果: #{result1}"
  puts '期待値: [[-1, -1, 2], [-1, 0, 1]]'
  expected1 = [[-1, -1, 2], [-1, 0, 1]]
  puts "判定: #{result1.sort == expected1.sort ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 全てゼロ
  result2 = three_sum([0, 0, 0])
  puts 'Test 2: three_sum([0, 0, 0])'
  puts "結果: #{result2}"
  puts '期待値: [[0, 0, 0]]'
  puts "判定: #{result2 == [[0, 0, 0]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 解なし
  result3 = three_sum([0, 1, 1])
  puts 'Test 3: three_sum([0, 1, 1])'
  puts "結果: #{result3}"
  puts '期待値: []'
  puts "判定: #{result3 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 複数の解
  result4 = three_sum([-2, 0, 1, 1, 2])
  puts 'Test 4: three_sum([-2, 0, 1, 1, 2])'
  puts "結果: #{result4}"
  puts '期待値: [[-2, 0, 2], [-2, 1, 1]]'
  expected4 = [[-2, 0, 2], [-2, 1, 1]]
  puts "判定: #{result4.sort == expected4.sort ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（三重ループ）
  puts '--- 解法2（三重ループ）のテスト ---'
  result5 = three_sum_brute_force([-1, 0, 1, 2, -1, -4])
  puts "three_sum_brute_force([-1, 0, 1, 2, -1, -4]) = #{result5}"
  expected5 = [[-1, -1, 2], [-1, 0, 1]]
  puts "判定: #{result5.sort == expected5.sort ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
