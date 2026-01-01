#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: アナグラムの判定
# ファイル: 02b_array_string_hashtable.md
# ============================================================================
#
# 2つの文字列が与えられます。それらがアナグラム（文字の並び替えで一致する）であるかを
# 判定してください。
#
# 入力例:
#   s = "anagram"
#   t = "nagaram"
# 出力例: true
#
# 時間計算量: O(n) - ハッシュ版、O(n log n) - ソート版
# 空間計算量: O(k) - kは一意な文字の数
# ============================================================================

# 解法1: 文字頻度を比較（推奨）
def is_anagram(s, t)
  return false if s.length != t.length

  freq_s = s.chars.tally
  freq_t = t.chars.tally

  freq_s == freq_t
end

# 解法2: ソートして比較
def is_anagram_sort(s, t)
  s.chars.sort == t.chars.sort
end

# 解法3: 1つのハッシュでカウント
def is_anagram_one_hash(s, t)
  return false if s.length != t.length

  freq = Hash.new(0)

  # sの文字をカウント
  s.each_char { |char| freq[char] += 1 }

  # tの文字を減らす
  t.each_char { |char| freq[char] -= 1 }

  # すべての値が0なら、アナグラム
  freq.values.all?(&:zero?)
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== アナグラムの判定 テスト ==='
  puts

  # テストケース1: アナグラム
  result1 = is_anagram('anagram', 'nagaram')
  puts "Test 1: is_anagram('anagram', 'nagaram')"
  puts "結果: #{result1}"
  puts '期待値: true'
  puts "判定: #{result1 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: アナグラムでない
  result2 = is_anagram('rat', 'car')
  puts "Test 2: is_anagram('rat', 'car')"
  puts "結果: #{result2}"
  puts '期待値: false'
  puts "判定: #{result2 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: アナグラム（listen/silent）
  result3 = is_anagram('listen', 'silent')
  puts "Test 3: is_anagram('listen', 'silent')"
  puts "結果: #{result3}"
  puts '期待値: true'
  puts "判定: #{result3 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: アナグラムでない
  result4 = is_anagram('hello', 'world')
  puts "Test 4: is_anagram('hello', 'world')"
  puts "結果: #{result4}"
  puts '期待値: false'
  puts "判定: #{result4 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（ソート）
  puts '--- 解法2（ソート）のテスト ---'
  result5 = is_anagram_sort('anagram', 'nagaram')
  puts "is_anagram_sort('anagram', 'nagaram') = #{result5}"
  puts "判定: #{result5 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（1つのハッシュ）
  puts '--- 解法3（1つのハッシュ）のテスト ---'
  result6 = is_anagram_one_hash('anagram', 'nagaram')
  puts "is_anagram_one_hash('anagram', 'nagaram') = #{result6}"
  puts "判定: #{result6 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
