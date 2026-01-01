#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: ソート済み配列の2つの数の合計
# ファイル: 02g_array_string_two_pointers.md
# ============================================================================
#
# ソート済みの整数配列と目標値が与えられます。合計が目標値になる2つの数のインデックスを
# 返してください（1-indexed）。
#
# 入力例:
#   numbers = [2, 7, 11, 15], target = 9
# 出力例: [1, 2]  # numbers[0] + numbers[1] = 2 + 7 = 9
#
# 時間計算量: O(n)
# 空間計算量: O(1)
# ============================================================================

# 解法1: Two Pointers
def two_sum(numbers, target)
  left = 0
  right = numbers.length - 1

  while left < right
    sum = numbers[left] + numbers[right]

    return [left + 1, right + 1] if sum == target

    if sum < target
      left += 1
    else
      right -= 1
    end
  end

  []
end

# 解法2: すべてのペアを見つける
def find_all_two_sum(numbers, target)
  result = []
  left = 0
  right = numbers.length - 1

  while left < right
    sum = numbers[left] + numbers[right]

    if sum == target
      result << [left + 1, right + 1]
      left += 1
      right -= 1
    elsif sum < target
      left += 1
    else
      right -= 1
    end
  end

  result
end

# 解法3: ハッシュを使用（ソート不要）
def two_sum_hash(numbers, target)
  seen = {}

  numbers.each_with_index do |num, i|
    complement = target - num

    return [seen[complement] + 1, i + 1] if seen.key?(complement)

    seen[num] = i
  end

  []
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== ソート済み配列の2つの数の合計 テスト ==='
  puts

  # テストケース1: 通常のケース
  result1 = two_sum([2, 7, 11, 15], 9)
  puts 'Test 1: two_sum([2, 7, 11, 15], 9)'
  puts "結果: #{result1}"
  puts '期待値: [1, 2]'
  puts "判定: #{result1 == [1, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 別のケース
  result2 = two_sum([2, 3, 4], 6)
  puts 'Test 2: two_sum([2, 3, 4], 6)'
  puts "結果: #{result2}"
  puts '期待値: [1, 3]'
  puts "判定: #{result2 == [1, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 負の数
  result3 = two_sum([-1, 0], -1)
  puts 'Test 3: two_sum([-1, 0], -1)'
  puts "結果: #{result3}"
  puts '期待値: [1, 2]'
  puts "判定: #{result3 == [1, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（全てのペア）
  puts '--- 解法2（全てのペア）のテスト ---'
  result4 = find_all_two_sum([1, 2, 3, 4, 5], 6)
  puts "find_all_two_sum([1, 2, 3, 4, 5], 6) = #{result4}"
  puts '期待値: [[1, 5], [2, 4]] または [[2, 4], [1, 5]]'
  expected4 = [[2, 4], [1, 5]]
  puts "判定: #{result4.sort == expected4.sort ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（ハッシュ）
  puts '--- 解法3（ハッシュ）のテスト ---'
  result5 = two_sum_hash([2, 7, 11, 15], 9)
  puts "two_sum_hash([2, 7, 11, 15], 9) = #{result5}"
  puts "判定: #{result5 == [1, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
