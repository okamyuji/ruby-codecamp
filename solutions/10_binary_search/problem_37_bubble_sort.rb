#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin bubble_sort
# 解法1: 基本的なバブルソート（最適化あり）
def bubble_sort(arr)
  arr = arr.dup # 元の配列を変更しない
  n = arr.length

  (0...n).each do |i|
    swapped = false

    # 各パスで最大の要素が末尾に移動
    (0...(n - i - 1)).each do |j|
      next unless arr[j] > arr[j + 1]

      # 隣接要素を交換
      arr[j], arr[j + 1] = arr[j + 1], arr[j]
      swapped = true
    end

    # 交換がなければソート完了
    break unless swapped
  end

  arr
end

# 解法2: 破壊的なバブルソート
def bubble_sort!(arr)
  n = arr.length

  loop do
    swapped = false

    (0...(n - 1)).each do |i|
      if arr[i] > arr[i + 1]
        arr[i], arr[i + 1] = arr[i + 1], arr[i]
        swapped = true
      end
    end

    break unless swapped
  end

  arr
end

# 解法3: whileループを使用
def bubble_sort_while(arr)
  arr = arr.dup
  n = arr.length

  sorted = false
  until sorted
    sorted = true

    (0...(n - 1)).each do |i|
      if arr[i] > arr[i + 1]
        arr[i], arr[i + 1] = arr[i + 1], arr[i]
        sorted = false
      end
    end
  end

  arr
end

# 比較: 組み込みsortを使用（推奨）
def sort_builtin(arr)
  arr.sort
end

# テストケース
p bubble_sort([64, 34, 25, 12, 22, 11, 90])  # => [11, 12, 22, 25, 34, 64, 90]
p bubble_sort([5, 1, 4, 2, 8])               # => [1, 2, 4, 5, 8]
p bubble_sort([1, 2, 3])                     # => [1, 2, 3]（既にソート済み）
p bubble_sort([])                            # => []
p bubble_sort([1])                           # => [1]
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== バブルソート テスト ==='
  puts

  result1 = bubble_sort([64, 34, 25, 12, 22, 11, 90])
  puts 'Test 1: bubble_sort([64, 34, 25, 12, 22, 11, 90])'
  puts "結果: #{result1}"
  puts '期待値: [11, 12, 22, 25, 34, 64, 90]'
  puts "判定: #{result1 == [11, 12, 22, 25, 34, 64, 90] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = bubble_sort([5, 1, 4, 2, 8])
  puts 'Test 2: bubble_sort([5, 1, 4, 2, 8])'
  puts "結果: #{result2}"
  puts '期待値: [1, 2, 4, 5, 8]'
  puts "判定: #{result2 == [1, 2, 4, 5, 8] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = bubble_sort([1, 2, 3])
  puts 'Test 3: bubble_sort([1, 2, 3])'
  puts "結果: #{result3}"
  puts '期待値: [1, 2, 3]'
  puts "判定: #{result3 == [1, 2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = bubble_sort([])
  puts 'Test 4: bubble_sort([])'
  puts "結果: #{result4}"
  puts '期待値: []'
  puts "判定: #{result4 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = bubble_sort([1])
  puts 'Test 5: bubble_sort([1])'
  puts "結果: #{result5}"
  puts '期待値: [1]'
  puts "判定: #{result5 == [1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
