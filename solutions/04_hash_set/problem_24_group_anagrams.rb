#!/usr/bin/env ruby
# frozen_string_literal: true

def group_anagrams(strs)
  groups = Hash.new { |hash, key| hash[key] = [] }

  strs.each do |str|
    key = str.chars.sort.join
    groups[key] << str
  end

  groups.values
end

def group_anagrams_group_by(strs)
  strs.group_by { |str| str.chars.sort.join }.values
end

def group_anagrams_count(strs)
  groups = Hash.new { |hash, key| hash[key] = [] }

  strs.each do |str|
    count = Array.new(26, 0)
    str.each_char { |char| count[char.ord - 'a'.ord] += 1 }
    key = count.join(',')
    groups[key] << str
  end

  groups.values
end

def group_anagrams_tally(strs)
  groups = Hash.new { |hash, key| hash[key] = [] }

  strs.each do |str|
    key = str.chars.tally.sort.to_s
    groups[key] << str
  end

  groups.values
end

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
