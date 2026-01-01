#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 最初の重複しない文字を見つける
# ファイル: 02b_array_string_hashtable.md
# ============================================================================
#
# 文字列が与えられます。最初に出現する重複しない文字を返してください。
# 存在しない場合はnilを返します。
#
# 入力例: "leetcode"
# 出力例: "l"
#
# 時間計算量: O(n) - 文字列を2回走査
# 空間計算量: O(k) - kは一意な文字の数
# ============================================================================

# 解法1: 2パス（頻度カウント + 検索）
def first_unique_char(str)
  freq = Hash.new(0)

  # 1パス目: 頻度をカウント
  str.each_char { |char| freq[char] += 1 }

  # 2パス目: 最初の一意な文字を見つける
  str.each_char do |char|
    return char if freq[char] == 1
  end

  nil
end

# 解法2: インデックスを返す版
def first_unique_char_index(str)
  freq = str.chars.tally

  str.each_char.with_index do |char, i|
    return i if freq[char] == 1
  end

  -1
end

# 解法3: tallyを使った簡潔版
def first_unique_char_tally(str)
  freq = str.chars.tally
  str.chars.find { |char| freq[char] == 1 }
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 最初の重複しない文字を見つける テスト ==='
  puts

  # テストケース1: "leetcode"
  result1 = first_unique_char('leetcode')
  puts "Test 1: first_unique_char('leetcode')"
  puts "結果: #{result1.inspect}"
  puts '期待値: "l"'
  puts "判定: #{result1 == 'l' ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: "loveleetcode"
  result2 = first_unique_char('loveleetcode')
  puts "Test 2: first_unique_char('loveleetcode')"
  puts "結果: #{result2.inspect}"
  puts '期待値: "v"'
  puts "判定: #{result2 == 'v' ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 全て重複
  result3 = first_unique_char('aabb')
  puts "Test 3: first_unique_char('aabb')"
  puts "結果: #{result3.inspect}"
  puts '期待値: nil'
  puts "判定: #{result3.nil? ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 単一文字
  result4 = first_unique_char('z')
  puts "Test 4: first_unique_char('z')"
  puts "結果: #{result4.inspect}"
  puts '期待値: "z"'
  puts "判定: #{result4 == 'z' ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（インデックスを返す）
  puts '--- 解法2（インデックスを返す）のテスト ---'
  result5 = first_unique_char_index('leetcode')
  puts "first_unique_char_index('leetcode') = #{result5}"
  puts '期待値: 0'
  puts "判定: #{result5 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result6 = first_unique_char_index('loveleetcode')
  puts "first_unique_char_index('loveleetcode') = #{result6}"
  puts '期待値: 2'
  puts "判定: #{result6 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（tally）
  puts '--- 解法3（tally）のテスト ---'
  result7 = first_unique_char_tally('leetcode')
  puts "first_unique_char_tally('leetcode') = #{result7.inspect}"
  puts "判定: #{result7 == 'l' ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
