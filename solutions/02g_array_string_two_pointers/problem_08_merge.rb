#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: ソート済み配列のマージ
# ファイル: 02g_array_string_two_pointers.md
# ============================================================================
#
# 2つのソート済み配列 nums1 と nums2 が与えられます。nums1 の末尾には nums2 を格納するための
# 十分な空きスペースがあります。2つの配列を nums1 にマージしてください。
#
# 入力例:
#   nums1 = [1, 2, 3, 0, 0, 0], m = 3
#   nums2 = [2, 5, 6], n = 3
# 出力例: [1, 2, 2, 3, 5, 6]
#
# 時間計算量: O(m + n)
# 空間計算量: O(1)
# ============================================================================

# 解法1: 後ろから埋める
def merge(nums1, m, nums2, n)
  p1 = m - 1
  p2 = n - 1
  write_pos = m + n - 1

  while p2 >= 0
    if p1 >= 0 && nums1[p1] > nums2[p2]
      nums1[write_pos] = nums1[p1]
      p1 -= 1
    else
      nums1[write_pos] = nums2[p2]
      p2 -= 1
    end

    write_pos -= 1
  end

  nums1
end

# 解法2: 前から埋める（コピーが必要）
def merge_forward(nums1, m, nums2, n)
  nums1_copy = nums1[0...m].dup
  p1 = 0
  p2 = 0
  write_pos = 0

  while p1 < m && p2 < n
    if nums1_copy[p1] <= nums2[p2]
      nums1[write_pos] = nums1_copy[p1]
      p1 += 1
    else
      nums1[write_pos] = nums2[p2]
      p2 += 1
    end

    write_pos += 1
  end

  # 残りをコピー
  nums1[write_pos...(write_pos + m - p1)] = nums1_copy[p1...m] if p1 < m
  nums1[write_pos...(write_pos + n - p2)] = nums2[p2...n] if p2 < n

  nums1
end

# 解法3: Rubyの組み込みメソッドを使用
def merge_builtin(nums1, m, nums2, n)
  nums1[0...m].concat(nums2[0...n]).sort!
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== ソート済み配列のマージ テスト ==='
  puts

  # テストケース1: 通常のケース
  nums1 = [1, 2, 3, 0, 0, 0]
  result1 = merge(nums1, 3, [2, 5, 6], 3)
  puts 'Test 1: merge([1, 2, 3, 0, 0, 0], 3, [2, 5, 6], 3)'
  puts "結果: #{result1}"
  puts '期待値: [1, 2, 2, 3, 5, 6]'
  expected1 = [1, 2, 2, 3, 5, 6]
  puts "判定: #{result1 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: nums2が空
  nums2 = [1]
  result2 = merge(nums2, 1, [], 0)
  puts 'Test 2: merge([1], 1, [], 0)'
  puts "結果: #{result2}"
  puts '期待値: [1]'
  puts "判定: #{result2 == [1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: nums1が空
  nums3 = [0]
  result3 = merge(nums3, 0, [1], 1)
  puts 'Test 3: merge([0], 0, [1], 1)'
  puts "結果: #{result3}"
  puts '期待値: [1]'
  puts "判定: #{result3 == [1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 重複なし
  nums4 = [1, 2, 3, 0, 0, 0]
  result4 = merge(nums4, 3, [4, 5, 6], 3)
  puts 'Test 4: merge([1, 2, 3, 0, 0, 0], 3, [4, 5, 6], 3)'
  puts "結果: #{result4}"
  puts '期待値: [1, 2, 3, 4, 5, 6]'
  puts "判定: #{result4 == [1, 2, 3, 4, 5, 6] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（前から埋める）
  puts '--- 解法2（前から埋める）のテスト ---'
  nums5 = [1, 2, 3, 0, 0, 0]
  result5 = merge_forward(nums5, 3, [2, 5, 6], 3)
  puts "merge_forward([1, 2, 3, 0, 0, 0], 3, [2, 5, 6], 3) = #{result5}"
  puts "判定: #{result5 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（組み込みメソッド）
  puts '--- 解法3（組み込みメソッド）のテスト ---'
  nums6 = [1, 2, 3, 0, 0, 0]
  result6 = merge_builtin(nums6, 3, [2, 5, 6], 3)
  puts "merge_builtin([1, 2, 3, 0, 0, 0], 3, [2, 5, 6], 3) = #{result6}"
  puts "判定: #{result6 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
