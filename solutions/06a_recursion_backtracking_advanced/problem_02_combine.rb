#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin combine
# 解法1: バックトラック
def combine(n, k)
  result = []
  backtrack_combine(1, n, k, [], result)
  result
end

def backtrack_combine(start, n, k, current, result)
  # ベースケース
  if current.length == k
    result << current.dup
    return
  end

  # 枝刈り: 残りの要素が足りない場合はスキップ
  needed = k - current.length

  (start..n).each do |i|
    # 枝刈り: 残りの要素が足りない
    break if n - i + 1 < needed

    # 選択
    current << i

    # 再帰
    backtrack_combine(i + 1, n, k, current, result)

    # バックトラック
    current.pop
  end
end

# 解法2: 再帰的に構築
def combine_recursive(n, k)
  return [[]] if k == 0
  return (1..n).map { |i| [i] } if k == 1

  result = []

  (1..n).each do |i|
    # i を含む組み合わせ
    combine_recursive(n - 1, k - 1).each do |comb|
      result << [i] + comb.map { |x| x + i }
    end
  end

  result
end

# 解法3: イテレーティブ（レベルごと）
def combine_iterative(n, k)
  return [[]] if k == 0

  result = (1..n).map { |i| [i] }

  (k - 1).times do
    new_result = []

    result.each do |comb|
      last = comb.last
      ((last + 1)..n).each do |i|
        new_result << comb + [i]
      end
    end

    result = new_result
  end

  result
end

# テストケース
p combine(4, 2)  # => [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]
p combine(1, 1)  # => [[1]]
p combine(5, 3)  # => [[1, 2, 3], [1, 2, 4], [1, 2, 5], [1, 3, 4], [1, 3, 5], [1, 4, 5], [2, 3, 4], [2, 3, 5], [2, 4, 5], [3, 4, 5]]
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 組み合わせの生成 テスト ==='
  puts

  result1 = combine(4, 2)
  puts 'Test 1: combine(4, 2)'
  puts "結果: #{result1}"
  expected1 = [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]
  puts "期待値: #{expected1}"
  puts "判定: #{result1 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = combine(1, 1)
  puts 'Test 2: combine(1, 1)'
  puts "結果: #{result2}"
  puts '期待値: [[1]]'
  puts "判定: #{result2 == [[1]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = combine(5, 3)
  puts 'Test 3: combine(5, 3)'
  puts "結果の数: #{result3.length}"
  puts '期待値: 10個の組み合わせ'
  puts "判定: #{result3.length == 10 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
