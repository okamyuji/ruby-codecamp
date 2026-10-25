#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin anagram?
# 解法1: ソートして比較（シンプル）
def anagram?(str1, str2)
  # 大文字小文字を統一し、文字をソートして比較
  str1.downcase.chars.sort == str2.downcase.chars.sort
end

# 解法2: 文字カウントを比較（効率的）
def anagram_count?(str1, str2)
  # 長さが異なれば即座にfalse
  return false if str1.length != str2.length

  # 各文字の出現回数を比較
  str1.downcase.chars.tally == str2.downcase.chars.tally
end

# 解法3: 手動で文字カウント
def anagram_manual?(str1, str2)
  return false if str1.length != str2.length

  count = Hash.new(0)

  # str1の文字をカウントアップ
  str1.downcase.each_char { |char| count[char] += 1 }

  # str2の文字をカウントダウン
  str2.downcase.each_char { |char| count[char] -= 1 }

  # すべてのカウントが0なら、アナグラム
  count.values.all?(&:zero?)
end

# 解法4: スペースと記号を無視
def anagram_clean?(str1, str2)
  # 英字のみを抽出して比較
  clean1 = str1.downcase.gsub(/[^a-z]/, '').chars.sort
  clean2 = str2.downcase.gsub(/[^a-z]/, '').chars.sort

  clean1 == clean2
end

# テストケース
puts anagram?('listen', 'silent')      # => true
puts anagram?('hello', 'world')        # => false
puts anagram?('Dormitory', 'dirty room'.delete(' ')) # => true
puts anagram?('a', 'a')                # => true
puts anagram?('ab', 'ba')              # => true
puts anagram?('abc', 'ab')             # => false
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== アナグラム判定 テスト ==='
  puts

  result1 = anagram?('listen', 'silent')
  puts "Test 1: anagram?('listen', 'silent')"
  puts "結果: #{result1}"
  puts '期待値: true'
  puts "判定: #{result1 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = anagram?('hello', 'world')
  puts "Test 2: anagram?('hello', 'world')"
  puts "結果: #{result2}"
  puts '期待値: false'
  puts "判定: #{result2 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = anagram?('Dormitory', 'dirtyroom')
  puts "Test 3: anagram?('Dormitory', 'dirtyroom')"
  puts "結果: #{result3}"
  puts '期待値: true'
  puts "判定: #{result3 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = anagram?('a', 'a')
  puts "Test 4: anagram?('a', 'a')"
  puts "結果: #{result4}"
  puts '期待値: true'
  puts "判定: #{result4 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = anagram?('ab', 'ba')
  puts "Test 5: anagram?('ab', 'ba')"
  puts "結果: #{result5}"
  puts '期待値: true'
  puts "判定: #{result5 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result6 = anagram?('abc', 'ab')
  puts "Test 6: anagram?('abc', 'ab')"
  puts "結果: #{result6}"
  puts '期待値: false'
  puts "判定: #{result6 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
