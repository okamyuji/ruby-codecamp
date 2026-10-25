#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin first_unique_char
# 解法1: tallyを使用（推奨）
def first_unique_char(str)
  # 文字の出現回数をカウント
  count = str.chars.tally

  # 最初の出現回数1の文字のインデックスを返す
  str.chars.each_with_index do |char, index|
    return index if count[char] == 1
  end

  -1 # 見つからない場合
end

# 解法2: find_indexを使用
def first_unique_char_find(str)
  count = str.chars.tally

  # find_indexは条件を満たす最初の要素のインデックスを返す
  str.chars.find_index { |char| count[char] == 1 } || -1
end

# 解法3: 2回のループで手動実装
def first_unique_char_manual(str)
  count = Hash.new(0)

  # 1回目のループ: カウント
  str.each_char { |char| count[char] += 1 }

  # 2回目のループ: 最初の非重複文字を探す
  str.each_char.with_index do |char, index|
    return index if count[char] == 1
  end

  -1
end

# 解法4: indexとrindexを比較
def first_unique_char_index(str)
  str.chars.each_with_index do |char, index|
    # 最初と最後の出現位置が同じなら、1回だけ出現
    return index if str.index(char) == str.rindex(char)
  end

  -1
end

# テストケース
puts first_unique_char('leetcode')     # => 0（'l'）
puts first_unique_char('loveleetcode') # => 2（'v'）
puts first_unique_char('aabb')         # => -1
puts first_unique_char('z')            # => 0
puts first_unique_char('')             # => -1
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 最初の非重複文字を見つける テスト ==='
  puts

  result1 = first_unique_char('leetcode')
  puts "Test 1: first_unique_char('leetcode')"
  puts "結果: #{result1}"
  puts "期待値: 0 ('l')"
  puts "判定: #{result1 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = first_unique_char('loveleetcode')
  puts "Test 2: first_unique_char('loveleetcode')"
  puts "結果: #{result2}"
  puts "期待値: 2 ('v')"
  puts "判定: #{result2 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = first_unique_char('aabb')
  puts "Test 3: first_unique_char('aabb')"
  puts "結果: #{result3}"
  puts '期待値: -1'
  puts "判定: #{result3 == -1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = first_unique_char('z')
  puts "Test 4: first_unique_char('z')"
  puts "結果: #{result4}"
  puts '期待値: 0'
  puts "判定: #{result4 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = first_unique_char('')
  puts "Test 5: first_unique_char('')"
  puts "結果: #{result5}"
  puts '期待値: -1'
  puts "判定: #{result5 == -1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
