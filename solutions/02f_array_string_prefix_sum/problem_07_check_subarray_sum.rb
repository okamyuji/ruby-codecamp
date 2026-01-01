#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 部分配列の合計がKの倍数
# ファイル: 02f_array_string_prefix_sum.md
# ============================================================================
#
# 整数の配列と整数kが与えられます。合計がkの倍数になる長さが少なくとも2の連続部分配列が
# 存在するかどうかを判定してください。
#
# 入力例:
#   nums = [23, 2, 4, 6, 7], k = 6
# 出力例: true  # [2, 4] の合計6はkの倍数
#
# 時間計算量: O(n)
# 空間計算量: O(k)
# ============================================================================

# 解法1: 余りを記録
def check_subarray_sum(nums, k)
  sum = 0
  remainder_map = { 0 => -1 }

  nums.each_with_index do |num, i|
    sum += num
    remainder = sum % k

    if remainder_map.key?(remainder)
      return true if i - remainder_map[remainder] >= 2
    else
      remainder_map[remainder] = i
    end
  end

  false
end

# 解法2: すべての有効な部分配列を見つける
def find_all_subarray_sum_multiple(nums, k)
  result = []
  sum = 0
  remainder_map = Hash.new { |h, key| h[key] = [] }
  remainder_map[0] << -1

  nums.each_with_index do |num, i|
    sum += num
    remainder = sum % k

    remainder_map[remainder].each do |start_idx|
      result << [start_idx + 1, i] if i - start_idx >= 2
    end

    remainder_map[remainder] << i
  end

  result
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 部分配列の合計がKの倍数 テスト ==='
  puts

  # テストケース1: 存在する
  result1 = check_subarray_sum([23, 2, 4, 6, 7], 6)
  puts 'Test 1: check_subarray_sum([23, 2, 4, 6, 7], 6)'
  puts "結果: #{result1}"
  puts '期待値: true ([2, 4]の合計6)'
  puts "判定: #{result1 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 存在する（連続0）
  result2 = check_subarray_sum([23, 2, 6, 4, 7], 6)
  puts 'Test 2: check_subarray_sum([23, 2, 6, 4, 7], 6)'
  puts "結果: #{result2}"
  puts '期待値: true ([6]は長さ1なのでfalse、[2, 6, 4]の合計12)'
  puts "判定: #{result2 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 存在する
  result3 = check_subarray_sum([23, 2, 4, 6, 7], 13)
  puts 'Test 3: check_subarray_sum([23, 2, 4, 6, 7], 13)'
  puts "結果: #{result3}"
  puts '期待値: true ([6, 7]の合計13)'
  puts "判定: #{result3 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 0を含む
  result4 = check_subarray_sum([0, 0], 1)
  puts 'Test 4: check_subarray_sum([0, 0], 1)'
  puts "結果: #{result4}"
  puts '期待値: true ([0, 0]の合計0は任意の数の倍数)'
  puts "判定: #{result4 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（全ての部分配列）
  puts '--- 解法2（全ての部分配列）のテスト ---'
  result5 = find_all_subarray_sum_multiple([23, 2, 4, 6, 7], 6)
  puts "find_all_subarray_sum_multiple([23, 2, 4, 6, 7], 6) = #{result5}"
  puts '期待値: 複数の部分配列（[2, 4], [2, 4, 6, 7]など）'
  puts "判定: #{result5.length >= 1 ? '✓ PASS' : '✗ FAIL'} (#{result5.length}個)"
  puts

  puts '=== 完了 ==='
end
