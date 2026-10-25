#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin group_anagrams
# 解法1: ソートをキーとして使用（推奨）
def group_anagrams(strs)
  # デフォルト値として空配列を持つハッシュ
  groups = Hash.new { |hash, key| hash[key] = [] }

  strs.each do |str|
    # ソートした文字列をキーとして使用
    key = str.chars.sort.join
    groups[key] << str
  end

  groups.values
end

# 解法2: group_byを使用
def group_anagrams_group_by(strs)
  strs.group_by { |str| str.chars.sort.join }.values
end

# 解法3: 文字カウントをキーとして使用
def group_anagrams_count(strs)
  groups = Hash.new { |hash, key| hash[key] = [] }

  strs.each do |str|
    # 文字カウントをキーとして使用（ソートより効率的な場合あり）
    count = Array.new(26, 0)
    str.each_char { |char| count[char.ord - 'a'.ord] += 1 }
    key = count.join(',')
    groups[key] << str
  end

  groups.values
end

# 解法4: tallyをキーとして使用
def group_anagrams_tally(strs)
  groups = Hash.new { |hash, key| hash[key] = [] }

  strs.each do |str|
    # tallyの結果をソートしてキーにする
    key = str.chars.tally.sort.to_s
    groups[key] << str
  end

  groups.values
end

# テストケース
p group_anagrams(['eat', 'tea', 'tan', 'ate', 'nat', 'bat'])
# => [["eat", "tea", "ate"], ["tan", "nat"], ["bat"]] （順序は異なる可能性あり）

p group_anagrams([''])
# => [[""]]

p group_anagrams(['a'])
# => [["a"]]
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== グループアナグラム テスト ==='
  puts

  result1 = group_anagrams(['eat', 'tea', 'tan', 'ate', 'nat', 'bat'])
  puts "Test 1: group_anagrams(['eat', 'tea', 'tan', 'ate', 'nat', 'bat'])"
  puts "結果: #{result1.map(&:sort).sort}"
  expected1 = [['ate', 'eat', 'tea'], ['bat'], ['nat', 'tan']]
  puts "期待値: #{expected1.map(&:sort).sort}"
  puts "判定: #{result1.map(&:sort).sort == expected1.map(&:sort).sort ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = group_anagrams([''])
  puts "Test 2: group_anagrams([''])"
  puts "結果: #{result2}"
  puts "期待値: [['']]"
  puts "判定: #{result2 == [['']] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = group_anagrams(['a'])
  puts "Test 3: group_anagrams(['a'])"
  puts "結果: #{result3}"
  puts "期待値: [['a']]"
  puts "判定: #{result3 == [['a']] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
