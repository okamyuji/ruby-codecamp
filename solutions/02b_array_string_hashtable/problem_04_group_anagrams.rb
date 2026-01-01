#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: アナグラムのグループ化
# ファイル: 02b_array_string_hashtable.md
# ============================================================================
#
# 文字列の配列が与えられます。アナグラム同士をグループ化してください。
#
# 入力例: ["eat", "tea", "tan", "ate", "nat", "bat"]
# 出力例: [["eat", "tea", "ate"], ["tan", "nat"], ["bat"]]
#
# 時間計算量: O(n × k log k) - nは文字列の数、kは文字列の平均長
# 空間計算量: O(n × k)
# ============================================================================

# 解法1: ソートをキーにする（推奨）
def group_anagrams(strs)
  groups = Hash.new { |h, k| h[k] = [] }

  strs.each do |str|
    # ソートした文字列をキーとする
    key = str.chars.sort.join
    groups[key] << str
  end

  groups.values
end

# 解法2: 文字頻度をキーにする
def group_anagrams_frequency(strs)
  groups = Hash.new { |h, k| h[k] = [] }

  strs.each do |str|
    # 文字頻度の配列をキーとする（a-zの26文字）
    freq = Array.new(26, 0)
    str.each_char { |char| freq[char.ord - 'a'.ord] += 1 }
    groups[freq] << str
  end

  groups.values
end

# 解法3: group_byを使用
def group_anagrams_group_by(strs)
  strs.group_by { |str| str.chars.sort }.values
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== アナグラムのグループ化 テスト ==='
  puts

  # テストケース1: 複数のグループ
  result1 = group_anagrams(['eat', 'tea', 'tan', 'ate', 'nat', 'bat'])
  puts "Test 1: group_anagrams(['eat', 'tea', 'tan', 'ate', 'nat', 'bat'])"
  puts "結果: #{result1.map(&:sort).sort}"
  expected1 = [['ate', 'eat', 'tea'], ['bat'], ['nat', 'tan']]
  puts "期待値: #{expected1.map(&:sort).sort}"
  puts "判定: #{result1.map(&:sort).sort == expected1.map(&:sort).sort ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 空文字列
  result2 = group_anagrams([''])
  puts "Test 2: group_anagrams([''])"
  puts "結果: #{result2}"
  puts '期待値: [[""]]'
  puts "判定: #{result2 == [['']] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 単一文字列
  result3 = group_anagrams(['a'])
  puts "Test 3: group_anagrams(['a'])"
  puts "結果: #{result3}"
  puts '期待値: [["a"]]'
  puts "判定: #{result3 == [['a']] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 全て異なる
  result4 = group_anagrams(['abc', 'def', 'ghi'])
  puts "Test 4: group_anagrams(['abc', 'def', 'ghi'])"
  puts "結果: #{result4.map(&:sort).sort}"
  expected4 = [['abc'], ['def'], ['ghi']]
  puts "期待値: #{expected4.map(&:sort).sort}"
  puts "判定: #{result4.map(&:sort).sort == expected4.map(&:sort).sort ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（文字頻度）
  puts '--- 解法2（文字頻度）のテスト ---'
  result5 = group_anagrams_frequency(['eat', 'tea', 'tan', 'ate', 'nat', 'bat'])
  puts "group_anagrams_frequency(['eat', 'tea', 'tan', 'ate', 'nat', 'bat'])"
  puts "結果グループ数: #{result5.length}"
  puts "判定: #{result5.length == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（group_by）
  puts '--- 解法3（group_by）のテスト ---'
  result6 = group_anagrams_group_by(['eat', 'tea', 'tan', 'ate', 'nat', 'bat'])
  puts "group_anagrams_group_by(['eat', 'tea', 'tan', 'ate', 'nat', 'bat'])"
  puts "結果グループ数: #{result6.length}"
  puts "判定: #{result6.length == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
