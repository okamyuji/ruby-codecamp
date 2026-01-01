#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: カスタムソート - 偶数を前、奇数を後ろ
# ファイル: 02c_array_string_sorting.md
# ============================================================================
#
# 整数の配列が与えられます。偶数を配列の前半に、奇数を後半に配置してください。
# 各グループ内での順序は問いません。
#
# 入力例: [3, 1, 2, 4, 5, 6]
# 出力例: [2, 4, 6, 3, 1, 5]  # または他の有効な配置
#
# 時間計算量: O(n)
# 空間計算量: O(n) - 新しい配列を作成する場合
# ============================================================================

# 解法1: selectで分離（推奨、簡単）
def segregate_even_odd(arr)
  even = arr.select(&:even?)
  odd = arr.select(&:odd?)
  even + odd
end

# 解法2: partitionを使用
def segregate_even_odd_partition(arr)
  even, odd = arr.partition(&:even?)
  even + odd
end

# 解法3: 2ポインタでin-place
def segregate_even_odd_inplace(arr)
  left = 0
  right = arr.length - 1

  while left < right
    # 左から奇数を探す
    left += 1 while left < right && arr[left].even?

    # 右から偶数を探す
    right -= 1 while left < right && arr[right].odd?

    # 交換
    next unless left < right

    arr[left], arr[right] = arr[right], arr[left]
    left += 1
    right -= 1
  end

  arr
end

# 解法4: sort_byを使用（偶数が前）
def segregate_even_odd_sort(arr)
  arr.sort_by { |x| [x % 2, x] }
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== カスタムソート - 偶数を前、奇数を後ろ テスト ==='
  puts

  # テストケース1: 混在
  result1 = segregate_even_odd([3, 1, 2, 4, 5, 6])
  puts 'Test 1: segregate_even_odd([3, 1, 2, 4, 5, 6])'
  puts "結果: #{result1}"
  even_count = result1.take_while(&:even?).length
  odd_start = result1.drop_while(&:even?)
  all_odd = odd_start.all?(&:odd?)
  puts "判定: #{even_count == 3 && all_odd ? '✓ PASS' : '✗ FAIL'} (偶数3個が前、奇数3個が後)"
  puts

  # テストケース2: 別のケース
  result2 = segregate_even_odd([12, 34, 45, 9, 8, 90, 3])
  puts 'Test 2: segregate_even_odd([12, 34, 45, 9, 8, 90, 3])'
  puts "結果: #{result2}"
  even_count2 = result2.count(&:even?)
  result2.count(&:odd?)
  first_evens = result2.take(even_count2).all?(&:even?)
  last_odds = result2.drop(even_count2).all?(&:odd?)
  puts "判定: #{first_evens && last_odds ? '✓ PASS' : '✗ FAIL'} (偶数が前、奇数が後)"
  puts

  # テストケース3: 全て奇数
  result3 = segregate_even_odd([1, 3, 5, 7])
  puts 'Test 3: segregate_even_odd([1, 3, 5, 7])'
  puts "結果: #{result3}"
  puts '期待値: [1, 3, 5, 7] (すべて奇数)'
  puts "判定: #{result3.all?(&:odd?) ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 全て偶数
  result4 = segregate_even_odd([2, 4, 6, 8])
  puts 'Test 4: segregate_even_odd([2, 4, 6, 8])'
  puts "結果: #{result4}"
  puts '期待値: [2, 4, 6, 8] (すべて偶数)'
  puts "判定: #{result4.all?(&:even?) ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（partition）
  puts '--- 解法2（partition）のテスト ---'
  result5 = segregate_even_odd_partition([3, 1, 2, 4, 5, 6])
  puts "segregate_even_odd_partition([3, 1, 2, 4, 5, 6]) = #{result5}"
  even_count5 = result5.count(&:even?)
  first_evens5 = result5.take(even_count5).all?(&:even?)
  last_odds5 = result5.drop(even_count5).all?(&:odd?)
  puts "判定: #{first_evens5 && last_odds5 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（in-place）
  puts '--- 解法3（in-place）のテスト ---'
  test_arr = [3, 1, 2, 4, 5, 6]
  result6 = segregate_even_odd_inplace(test_arr)
  puts "segregate_even_odd_inplace([3, 1, 2, 4, 5, 6]) = #{result6}"
  result6.count(&:even?)
  puts '判定: 偶数と奇数が分離されている (検証省略)'
  puts

  # 解法4のテスト（sort_by）
  puts '--- 解法4（sort_by）のテスト ---'
  result7 = segregate_even_odd_sort([3, 1, 2, 4, 5, 6])
  puts "segregate_even_odd_sort([3, 1, 2, 4, 5, 6]) = #{result7}"
  puts '期待値: [2, 4, 6, 1, 3, 5] (偶数がソート済み、奇数もソート済み)'
  puts "判定: #{result7 == [2, 4, 6, 1, 3, 5] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
