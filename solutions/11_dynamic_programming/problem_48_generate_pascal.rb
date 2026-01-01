#!/usr/bin/env ruby
# frozen_string_literal: true

def generate_pascal(num_rows)
  return [] if num_rows == 0

  result = [[1]]

  (1...num_rows).each do |_i|
    prev_row = result.last
    new_row = [1]

    (0...(prev_row.length - 1)).each do |j|
      new_row << prev_row[j] + prev_row[j + 1]
    end

    new_row << 1
    result << new_row
  end

  result
end

def generate_pascal_cons(num_rows)
  return [] if num_rows == 0

  result = [[1]]

  (1...num_rows).each do
    prev = result.last
    middle = prev.each_cons(2).map { |a, b| a + b }
    result << [1] + middle + [1]
  end

  result
end

def generate_pascal_recursive(num_rows)
  return [] if num_rows == 0
  return [[1]] if num_rows == 1

  prev = generate_pascal_recursive(num_rows - 1)
  last_row = prev.last

  new_row = [1]
  (0...(last_row.length - 1)).each do |i|
    new_row << last_row[i] + last_row[i + 1]
  end
  new_row << 1

  prev + [new_row]
end

def generate_pascal_binomial(num_rows)
  (0...num_rows).map do |n|
    (0..n).map { |k| binomial(n, k) }
  end
end

def binomial(n, k)
  return 1 if k == 0 || k == n

  result = 1
  (1..k).each do |i|
    result = result * (n - i + 1) / i
  end
  result
end

def get_pascal_row(row_index)
  row = [1]

  (1..row_index).each do |i|
    row << row.last * (row_index - i + 1) / i
  end

  row
end

if __FILE__ == $PROGRAM_NAME
  puts '=== パスカルの三角形 テスト ==='
  puts

  result1 = generate_pascal(5)
  puts 'Test 1: generate_pascal(5)'
  puts "結果: #{result1}"
  expected1 = [[1], [1, 1], [1, 2, 1], [1, 3, 3, 1], [1, 4, 6, 4, 1]]
  puts "期待値: #{expected1}"
  puts "判定: #{result1 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = generate_pascal(1)
  puts 'Test 2: generate_pascal(1)'
  puts "結果: #{result2}"
  puts '期待値: [[1]]'
  puts "判定: #{result2 == [[1]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = generate_pascal(0)
  puts 'Test 3: generate_pascal(0)'
  puts "結果: #{result3}"
  puts '期待値: []'
  puts "判定: #{result3 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = get_pascal_row(4)
  puts "get_pascal_row(4) = #{result4}"
  puts '期待値: [1, 4, 6, 4, 1]'
  puts "判定: #{result4 == [1, 4, 6, 4, 1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
