#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 文字の出現回数をカウント
# ファイル: 02b_array_string_hashtable.md
# ============================================================================
#
# 文字列が与えられます。各文字が何回出現するかをカウントして、ハッシュとして返してください。
#
# 入力例: "hello"
# 出力例: {"h"=>1, "e"=>1, "l"=>2, "o"=>1}
#
# 時間計算量: O(n) - 文字列の長さに比例
# 空間計算量: O(k) - kは一意な文字の数
# ============================================================================

# 解法1: Hash.new(0)を使用
def character_frequency(str)
  freq = Hash.new(0)

  str.each_char do |char|
    freq[char] += 1
  end

  freq
end

# 解法2: tallyメソッド（Ruby 2.7+、推奨）
def character_frequency_tally(str)
  str.chars.tally
end

# 解法3: group_byとmapを使用
def character_frequency_group_by(str)
  str.chars.group_by(&:itself).transform_values(&:count)
end

# 解法4: reduceを使用
def character_frequency_reduce(str)
  str.each_char.reduce(Hash.new(0)) do |freq, char|
    freq[char] += 1
    freq
  end
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 文字の出現回数をカウント テスト ==='
  puts

  # テストケース1: 通常の文字列
  result1 = character_frequency('hello')
  puts "Test 1: character_frequency('hello')"
  puts "結果: #{result1}"
  puts '期待値: {"h"=>1, "e"=>1, "l"=>2, "o"=>1}'
  expected1 = { 'h' => 1, 'e' => 1, 'l' => 2, 'o' => 1 }
  puts "判定: #{result1 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 繰り返しの多い文字列
  result2 = character_frequency('mississippi')
  puts "Test 2: character_frequency('mississippi')"
  puts "結果: #{result2}"
  puts '期待値: {"m"=>1, "i"=>4, "s"=>4, "p"=>2}'
  expected2 = { 'm' => 1, 'i' => 4, 's' => 4, 'p' => 2 }
  puts "判定: #{result2 == expected2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 空文字列
  result3 = character_frequency('')
  puts "Test 3: character_frequency('')"
  puts "結果: #{result3}"
  puts '期待値: {}'
  puts "判定: #{result3 == {} ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 同じ文字のみ
  result4 = character_frequency('aaa')
  puts "Test 4: character_frequency('aaa')"
  puts "結果: #{result4}"
  puts '期待値: {"a"=>3}'
  expected4 = { 'a' => 3 }
  puts "判定: #{result4 == expected4 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（tally）
  puts '--- 解法2（tally）のテスト ---'
  result5 = character_frequency_tally('hello')
  puts "character_frequency_tally('hello') = #{result5}"
  puts "判定: #{result5 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（group_by）
  puts '--- 解法3（group_by）のテスト ---'
  result6 = character_frequency_group_by('hello')
  puts "character_frequency_group_by('hello') = #{result6}"
  puts "判定: #{result6 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法4のテスト（reduce）
  puts '--- 解法4（reduce）のテスト ---'
  result7 = character_frequency_reduce('hello')
  puts "character_frequency_reduce('hello') = #{result7}"
  puts "判定: #{result7 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
