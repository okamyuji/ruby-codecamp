#!/usr/bin/env ruby
# frozen_string_literal: true

def max_min_distance(positions, m)
  positions.sort!

  left = 1
  right = positions[-1] - positions[0]
  result = 0

  while left <= right
    mid = (left + right) / 2

    if can_place_balls(positions, m, mid)
      result = mid
      left = mid + 1
    else
      right = mid - 1
    end
  end

  result
end

def can_place_balls(positions, m, min_distance)
  count = 1
  last_pos = positions[0]

  positions.each do |pos|
    next unless pos - last_pos >= min_distance

    count += 1
    last_pos = pos

    return true if count == m
  end

  false
end

def max_min_distance_explicit(positions, m)
  positions.sort!

  min_possible = 1
  max_possible = (positions[-1] - positions[0]) / (m - 1)

  result = 0

  while min_possible <= max_possible
    mid = (min_possible + max_possible) / 2

    placed = place_balls(positions, m, mid)

    if placed >= m
      result = mid
      min_possible = mid + 1
    else
      max_possible = mid - 1
    end
  end

  result
end

def place_balls(positions, m, min_distance)
  count = 1
  last_pos = positions[0]

  (1...positions.length).each do |i|
    if positions[i] - last_pos >= min_distance
      count += 1
      last_pos = positions[i]
    end
  end

  count
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 最小の最大距離（答えの二分探索） テスト ==='
  puts

  result1 = max_min_distance([1, 2, 8, 4, 9], 3)
  puts 'Test 1: max_min_distance([1, 2, 8, 4, 9], 3)'
  puts "結果: #{result1}"
  puts '期待値: 3'
  puts "判定: #{result1 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = max_min_distance([1, 2, 3, 4, 7], 3)
  puts 'Test 2: max_min_distance([1, 2, 3, 4, 7], 3)'
  puts "結果: #{result2}"
  puts '期待値: 3'
  puts "判定: #{result2 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = max_min_distance([5, 4, 3, 2, 1, 1_000_000_000], 2)
  puts 'Test 3: max_min_distance([5, 4, 3, 2, 1, 1000000000], 2)'
  puts "結果: #{result3}"
  puts '期待値: 999999995'
  puts "判定: #{result3 == 999_999_995 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
