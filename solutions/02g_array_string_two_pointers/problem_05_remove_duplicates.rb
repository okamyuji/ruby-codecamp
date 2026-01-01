#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 重複を削除（ソート済み配列）
# ファイル: 02g_array_string_two_pointers.md
# ============================================================================
#
# ソート済みの配列が与えられます。重複を削除し、各要素が1回だけ現れるようにしてください。
# in-placeで行い、新しい長さを返してください。
#
# 入力例: [1, 1, 2]
# 出力例: 2  # 配列は [1, 2, ...] になる
#
# 時間計算量: O(n)
# 空間計算量: O(1)
# ============================================================================

# 解法1: Two Pointers
def remove_duplicates(nums)
  return 0 if nums.empty?

  write_pos = 1

  (1...nums.length).each do |i|
    if nums[i] != nums[i - 1]
      nums[write_pos] = nums[i]
      write_pos += 1
    end
  end

  write_pos
end

# 解法2: 各要素が最大2回まで出現を許可
def remove_duplicates_allow_twice(nums)
  return nums.length if nums.length <= 2

  write_pos = 2

  (2...nums.length).each do |i|
    if nums[i] != nums[write_pos - 2]
      nums[write_pos] = nums[i]
      write_pos += 1
    end
  end

  write_pos
end

# 解法3: 新しい配列を作成（in-placeではない）
def remove_duplicates_new_array(nums)
  nums.uniq
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 重複を削除（ソート済み配列） テスト ==='
  puts

  # テストケース1: [1, 1, 2]
  nums1 = [1, 1, 2]
  k1 = remove_duplicates(nums1)
  puts 'Test 1: remove_duplicates([1, 1, 2])'
  puts "新しい長さ: #{k1}"
  puts "配列の最初のk個: #{nums1[0...k1]}"
  puts '期待値: 2, [1, 2]'
  puts "判定: #{k1 == 2 && nums1[0...k1] == [1, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: [0, 0, 1, 1, 1, 2, 2, 3, 3, 4]
  nums2 = [0, 0, 1, 1, 1, 2, 2, 3, 3, 4]
  k2 = remove_duplicates(nums2)
  puts 'Test 2: remove_duplicates([0, 0, 1, 1, 1, 2, 2, 3, 3, 4])'
  puts "新しい長さ: #{k2}"
  puts "配列の最初のk個: #{nums2[0...k2]}"
  puts '期待値: 5, [0, 1, 2, 3, 4]'
  puts "判定: #{k2 == 5 && nums2[0...k2] == [0, 1, 2, 3, 4] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 重複なし
  nums3 = [1, 2, 3]
  k3 = remove_duplicates(nums3)
  puts 'Test 3: remove_duplicates([1, 2, 3])'
  puts "新しい長さ: #{k3}"
  puts "判定: #{k3 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（2回まで許可）
  puts '--- 解法2（2回まで許可）のテスト ---'
  nums4 = [1, 1, 1, 2, 2, 3]
  k4 = remove_duplicates_allow_twice(nums4)
  puts 'remove_duplicates_allow_twice([1, 1, 1, 2, 2, 3])'
  puts "新しい長さ: #{k4}"
  puts "配列の最初のk個: #{nums4[0...k4]}"
  puts '期待値: 5, [1, 1, 2, 2, 3]'
  puts "判定: #{k4 == 5 && nums4[0...k4] == [1, 1, 2, 2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（新しい配列）
  puts '--- 解法3（新しい配列）のテスト ---'
  result5 = remove_duplicates_new_array([1, 1, 2])
  puts "remove_duplicates_new_array([1, 1, 2]) = #{result5}"
  puts "判定: #{result5 == [1, 2] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
