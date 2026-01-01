#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 3つの数の合計
# ファイル: 02g_array_string_two_pointers.md
# ============================================================================
#
# 整数の配列が与えられます。合計が0になる3つの数の組み合わせをすべて返してください。
# 重複する組み合わせは含めません。
#
# 入力例: [-1, 0, 1, 2, -1, -4]
# 出力例: [[-1, -1, 2], [-1, 0, 1]]
#
# 時間計算量: O(n²)
# 空間計算量: O(1) - 出力配列を除く
# ============================================================================

# 解法1: ソート + Two Pointers
def three_sum(nums)
  nums.sort!
  result = []

  (nums.length - 2).times do |i|
    # 重複をスキップ
    next if i.positive? && nums[i] == nums[i - 1]

    left = i + 1
    right = nums.length - 1

    while left < right
      sum = nums[i] + nums[left] + nums[right]

      if sum.zero?
        result << [nums[i], nums[left], nums[right]]

        left += 1
        right -= 1

        # 重複をスキップ
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

# 解法2: ハッシュを使用
def three_sum_hash(nums)
  result = Set.new

  nums.length.times do |i|
    seen = Set.new

    ((i + 1)...nums.length).each do |j|
      complement = -(nums[i] + nums[j])

      if seen.include?(complement)
        triplet = [nums[i], nums[j], complement].sort
        result << triplet
      end

      seen << nums[j]
    end
  end

  result.to_a
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 3つの数の合計 テスト ==='
  puts

  # テストケース1: 通常のケース
  result1 = three_sum([-1, 0, 1, 2, -1, -4])
  puts 'Test 1: three_sum([-1, 0, 1, 2, -1, -4])'
  puts "結果: #{result1}"
  puts '期待値: [[-1, -1, 2], [-1, 0, 1]]'
  expected1 = [[-1, -1, 2], [-1, 0, 1]]
  puts "判定: #{result1.sort == expected1.sort ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 全て0
  result2 = three_sum([0, 0, 0])
  puts 'Test 2: three_sum([0, 0, 0])'
  puts "結果: #{result2}"
  puts '期待値: [[0, 0, 0]]'
  puts "判定: #{result2 == [[0, 0, 0]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 空配列
  result3 = three_sum([])
  puts 'Test 3: three_sum([])'
  puts "結果: #{result3}"
  puts '期待値: []'
  puts "判定: #{result3 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 解なし
  result4 = three_sum([1, 2, 3])
  puts 'Test 4: three_sum([1, 2, 3])'
  puts "結果: #{result4}"
  puts '期待値: []'
  puts "判定: #{result4 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（ハッシュ）
  puts '--- 解法2（ハッシュ）のテスト ---'
  result5 = three_sum_hash([-1, 0, 1, 2, -1, -4])
  puts "three_sum_hash([-1, 0, 1, 2, -1, -4]) = #{result5.sort}"
  puts "判定: #{result5.sort == expected1.sort ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
