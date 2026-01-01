#!/usr/bin/env ruby
# frozen_string_literal: true

def find_closest_elements(arr, k, x)
  left = 0
  right = arr.length - k

  while left < right
    mid = (left + right) / 2

    if x - arr[mid] > arr[mid + k] - x
      left = mid + 1
    else
      right = mid
    end
  end

  arr[left, k]
end

def find_closest_elements_two_pointers(arr, k, x)
  left = 0
  right = arr.length - 1

  while right - left >= k
    if (x - arr[left]).abs <= (arr[right] - x).abs
      right -= 1
    else
      left += 1
    end
  end

  arr[left..right]
end

def find_closest_elements_quickselect(arr, k, x)
  distances = arr.map.with_index { |num, i| [i, (num - x).abs, num] }

  quickselect_distance(distances, k)

  distances[0...k].map { |_, _, num| num }.sort
end

def quickselect_distance(arr, k)
  left = 0
  right = arr.length - 1

  loop do
    pivot_idx = partition_distance(arr, left, right)

    if pivot_idx == k - 1
      return
    elsif pivot_idx > k - 1
      right = pivot_idx - 1
    else
      left = pivot_idx + 1
    end
  end
end

def partition_distance(arr, left, right)
  pivot_idx = rand(left..right)
  arr[pivot_idx], arr[right] = arr[right], arr[pivot_idx]

  pivot = arr[right]
  i = left

  (left...right).each do |j|
    if arr[j][1] < pivot[1] || (arr[j][1] == pivot[1] && arr[j][2] < pivot[2])
      arr[i], arr[j] = arr[j], arr[i]
      i += 1
    end
  end

  arr[i], arr[right] = arr[right], arr[i]
  i
end

if __FILE__ == $PROGRAM_NAME
  puts '=== k番目に近い要素 テスト ==='
  puts

  result1 = find_closest_elements([1, 2, 3, 4, 5], 4, 3)
  puts 'Test 1: find_closest_elements([1, 2, 3, 4, 5], 4, 3)'
  puts "結果: #{result1}"
  puts '期待値: [1, 2, 3, 4]'
  puts "判定: #{result1 == [1, 2, 3, 4] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = find_closest_elements([1, 2, 3, 4, 5], 4, -1)
  puts 'Test 2: find_closest_elements([1, 2, 3, 4, 5], 4, -1)'
  puts "結果: #{result2}"
  puts '期待値: [1, 2, 3, 4]'
  puts "判定: #{result2 == [1, 2, 3, 4] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = find_closest_elements([1, 1, 1, 10, 10, 10], 1, 9)
  puts 'Test 3: find_closest_elements([1, 1, 1, 10, 10, 10], 1, 9)'
  puts "結果: #{result3}"
  puts '期待値: [10]'
  puts "判定: #{result3 == [10] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = find_closest_elements_two_pointers([1, 2, 3, 4, 5], 4, 3)
  puts "find_closest_elements_two_pointers([1, 2, 3, 4, 5], 4, 3) = #{result4}"
  puts "判定: #{result4 == [1, 2, 3, 4] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = find_closest_elements_quickselect([1, 2, 3, 4, 5], 4, 3)
  puts "find_closest_elements_quickselect([1, 2, 3, 4, 5], 4, 3) = #{result5}"
  puts "判定: #{result5 == [1, 2, 3, 4] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
