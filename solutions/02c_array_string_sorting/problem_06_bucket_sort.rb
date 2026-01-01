#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: バケットソート
# ファイル: 02c_array_string_sorting.md
# ============================================================================
#
# 0.0から1.0の範囲の浮動小数点数の配列が与えられます。バケットソートを使用して
# ソートしてください。
#
# 入力例: [0.897, 0.565, 0.656, 0.1234, 0.665, 0.3434]
# 出力例: [0.1234, 0.3434, 0.565, 0.656, 0.665, 0.897]
#
# 時間計算量: O(n + k) - 平均ケース、O(n²) - 最悪ケース
# 空間計算量: O(n + k)
# ============================================================================

# 解法1: 基本的なバケットソート
def bucket_sort(arr, bucket_count = 10)
  return arr if arr.empty?

  # バケットを初期化
  buckets = Array.new(bucket_count) { [] }

  # 各要素を適切なバケットに配置
  arr.each do |num|
    index = (num * bucket_count).to_i
    index = bucket_count - 1 if index >= bucket_count
    buckets[index] << num
  end

  # 各バケットをソートして連結
  buckets.flat_map { |bucket| bucket.sort }
end

# 解法2: 整数配列用のバケットソート
def bucket_sort_integers(arr, bucket_size = 5)
  return arr if arr.empty?

  min_val = arr.min
  max_val = arr.max
  bucket_count = ((max_val - min_val) / bucket_size).to_i + 1

  buckets = Array.new(bucket_count) { [] }

  arr.each do |num|
    index = ((num - min_val) / bucket_size).to_i
    buckets[index] << num
  end

  buckets.flat_map { |bucket| bucket.sort }
end

# 解法3: 挿入ソートを使ったバケットソート
def bucket_sort_with_insertion(arr, bucket_count = 10)
  return arr if arr.empty?

  buckets = Array.new(bucket_count) { [] }

  arr.each do |num|
    index = (num * bucket_count).to_i
    index = bucket_count - 1 if index >= bucket_count
    buckets[index] << num
  end

  # 各バケットを挿入ソート
  buckets.each do |bucket|
    (1...bucket.length).each do |i|
      key = bucket[i]
      j = i - 1
      while j >= 0 && bucket[j] > key
        bucket[j + 1] = bucket[j]
        j -= 1
      end
      bucket[j + 1] = key
    end
  end

  buckets.flatten
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== バケットソート テスト ==='
  puts

  # テストケース1: 浮動小数点数
  result1 = bucket_sort([0.897, 0.565, 0.656, 0.1234, 0.665, 0.3434])
  puts 'Test 1: bucket_sort([0.897, 0.565, 0.656, 0.1234, 0.665, 0.3434])'
  puts "結果: #{result1}"
  puts '期待値: [0.1234, 0.3434, 0.565, 0.656, 0.665, 0.897]'
  expected1 = [0.1234, 0.3434, 0.565, 0.656, 0.665, 0.897]
  puts "判定: #{result1 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 別のケース
  result2 = bucket_sort([0.5, 0.1, 0.9, 0.3, 0.7])
  puts 'Test 2: bucket_sort([0.5, 0.1, 0.9, 0.3, 0.7])'
  puts "結果: #{result2}"
  puts '期待値: [0.1, 0.3, 0.5, 0.7, 0.9]'
  puts "判定: #{result2 == [0.1, 0.3, 0.5, 0.7, 0.9] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 単一要素
  result3 = bucket_sort([0.5])
  puts 'Test 3: bucket_sort([0.5])'
  puts "結果: #{result3}"
  puts '期待値: [0.5]'
  puts "判定: #{result3 == [0.5] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（整数配列用）
  puts '--- 解法2（整数配列用）のテスト ---'
  result4 = bucket_sort_integers([29, 25, 3, 49, 9, 37, 21, 43])
  puts "bucket_sort_integers([29, 25, 3, 49, 9, 37, 21, 43]) = #{result4}"
  puts '期待値: [3, 9, 21, 25, 29, 37, 43, 49]'
  puts "判定: #{result4 == [3, 9, 21, 25, 29, 37, 43, 49] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（挿入ソート使用）
  puts '--- 解法3（挿入ソート使用）のテスト ---'
  result5 = bucket_sort_with_insertion([0.897, 0.565, 0.656, 0.1234, 0.665, 0.3434])
  puts 'bucket_sort_with_insertion([0.897, 0.565, 0.656, 0.1234, 0.665, 0.3434])'
  puts "結果: #{result5}"
  puts "判定: #{result5 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
