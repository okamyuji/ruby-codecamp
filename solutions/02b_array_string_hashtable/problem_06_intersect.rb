#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 2つの配列の積集合
# ファイル: 02b_array_string_hashtable.md
# ============================================================================
#
# 2つの整数配列が与えられます。両方の配列に含まれる要素（積集合）を重複を含めて
# 返してください。
#
# 入力例:
#   nums1 = [1, 2, 2, 1]
#   nums2 = [2, 2]
# 出力例: [2, 2]
#
# 時間計算量: O(n + m)
# 空間計算量: O(min(n, m))
# ============================================================================

# 解法1: ハッシュで頻度管理（推奨）
def intersect(nums1, nums2)
  freq = Hash.new(0)
  result = []

  # nums1の頻度をカウント
  nums1.each { |num| freq[num] += 1 }

  # nums2を走査して共通要素を探す
  nums2.each do |num|
    if freq[num].positive?
      result << num
      freq[num] -= 1
    end
  end

  result
end

# 解法2: 両方をソートして2ポインタ
def intersect_sorted(nums1, nums2)
  nums1.sort!
  nums2.sort!

  result = []
  i = j = 0

  while i < nums1.length && j < nums2.length
    if nums1[i] == nums2[j]
      result << nums1[i]
      i += 1
      j += 1
    elsif nums1[i] < nums2[j]
      i += 1
    else
      j += 1
    end
  end

  result
end

# 解法3: tallyを使用
def intersect_tally(nums1, nums2)
  freq1 = nums1.tally
  result = []

  nums2.each do |num|
    if freq1[num]&.positive?
      result << num
      freq1[num] -= 1
    end
  end

  result
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 2つの配列の積集合 テスト ==='
  puts

  # テストケース1: 重複を含む
  result1 = intersect([1, 2, 2, 1], [2, 2])
  puts 'Test 1: intersect([1, 2, 2, 1], [2, 2])'
  puts "結果: #{result1}"
  puts '期待値: [2, 2]'
  puts "判定: #{result1.sort == [2, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 複数の共通要素
  result2 = intersect([4, 9, 5], [9, 4, 9, 8, 4])
  puts 'Test 2: intersect([4, 9, 5], [9, 4, 9, 8, 4])'
  puts "結果: #{result2.sort}"
  puts '期待値: [4, 9]（順序は問わない）'
  puts "判定: #{result2.sort == [4, 9] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 共通要素なし
  result3 = intersect([1, 2, 3], [4, 5, 6])
  puts 'Test 3: intersect([1, 2, 3], [4, 5, 6])'
  puts "結果: #{result3}"
  puts '期待値: []'
  puts "判定: #{result3 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 全て共通
  result4 = intersect([1, 2, 3], [1, 2, 3])
  puts 'Test 4: intersect([1, 2, 3], [1, 2, 3])'
  puts "結果: #{result4.sort}"
  puts '期待値: [1, 2, 3]'
  puts "判定: #{result4.sort == [1, 2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（ソート + 2ポインタ）
  puts '--- 解法2（ソート + 2ポインタ）のテスト ---'
  result5 = intersect_sorted([1, 2, 2, 1].dup, [2, 2].dup)
  puts "intersect_sorted([1, 2, 2, 1], [2, 2]) = #{result5}"
  puts "判定: #{result5 == [2, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（tally）
  puts '--- 解法3（tally）のテスト ---'
  result6 = intersect_tally([1, 2, 2, 1], [2, 2])
  puts "intersect_tally([1, 2, 2, 1], [2, 2]) = #{result6}"
  puts "判定: #{result6.sort == [2, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
