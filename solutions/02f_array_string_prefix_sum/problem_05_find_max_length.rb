#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 等しい0と1の最長部分配列
# ファイル: 02f_array_string_prefix_sum.md
# ============================================================================
#
# 0と1のみからなる配列が与えられます。0と1の個数が等しい最長の連続部分配列の長さを
# 返してください。
#
# 入力例: [0, 1, 0]
# 出力例: 2  # [0, 1] または [1, 0]
#
# 時間計算量: O(n)
# 空間計算量: O(n)
# ============================================================================

# 解法1: 累積和とハッシュマップ
def find_max_length(nums)
  max_len = 0
  sum = 0
  sum_map = { 0 => -1 }

  nums.each_with_index do |num, i|
    # 0を-1として扱う
    sum += num == 1 ? 1 : -1

    if sum_map.key?(sum)
      length = i - sum_map[sum]
      max_len = [max_len, length].max
    else
      sum_map[sum] = i
    end
  end

  max_len
end

# 解法2: 配列を変換してから処理
def find_max_length_transform(nums)
  # 0を-1に変換
  transformed = nums.map { |x| x == 1 ? 1 : -1 }

  max_len = 0
  sum = 0
  sum_map = { 0 => -1 }

  transformed.each_with_index do |num, i|
    sum += num

    if sum_map.key?(sum)
      max_len = [max_len, i - sum_map[sum]].max
    else
      sum_map[sum] = i
    end
  end

  max_len
end

# 解法3: 部分配列のインデックスも返す
def find_max_length_with_indices(nums)
  max_len = 0
  start_idx = 0
  end_idx = -1
  sum = 0
  sum_map = { 0 => -1 }

  nums.each_with_index do |num, i|
    sum += num == 1 ? 1 : -1

    if sum_map.key?(sum)
      length = i - sum_map[sum]

      if length > max_len
        max_len = length
        start_idx = sum_map[sum] + 1
        end_idx = i
      end
    else
      sum_map[sum] = i
    end
  end

  { length: max_len, start: start_idx, end: end_idx }
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 等しい0と1の最長部分配列 テスト ==='
  puts

  # テストケース1: [0, 1]
  result1 = find_max_length([0, 1])
  puts 'Test 1: find_max_length([0, 1])'
  puts "結果: #{result1}"
  puts '期待値: 2'
  puts "判定: #{result1 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: [0, 1, 0]
  result2 = find_max_length([0, 1, 0])
  puts 'Test 2: find_max_length([0, 1, 0])'
  puts "結果: #{result2}"
  puts '期待値: 2 ([0, 1]または[1, 0])'
  puts "判定: #{result2 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 長い配列
  result3 = find_max_length([0, 0, 1, 0, 0, 0, 1, 1])
  puts 'Test 3: find_max_length([0, 0, 1, 0, 0, 0, 1, 1])'
  puts "結果: #{result3}"
  puts '期待値: 6 ([1, 0, 0, 0, 1, 1])'
  puts "判定: #{result3 == 6 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 全て0
  result4 = find_max_length([0, 0, 0])
  puts 'Test 4: find_max_length([0, 0, 0])'
  puts "結果: #{result4}"
  puts '期待値: 0'
  puts "判定: #{result4 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（変換）
  puts '--- 解法2（変換）のテスト ---'
  result5 = find_max_length_transform([0, 1, 0])
  puts "find_max_length_transform([0, 1, 0]) = #{result5}"
  puts "判定: #{result5 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（インデックス付き）
  puts '--- 解法3（インデックス付き）のテスト ---'
  result6 = find_max_length_with_indices([0, 1, 0])
  puts "find_max_length_with_indices([0, 1, 0]) = #{result6}"
  puts '期待値: { length: 2, start: 0, end: 1 }'
  puts "判定: #{result6[:length] == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
