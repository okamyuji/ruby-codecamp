#!/usr/bin/env ruby
# frozen_string_literal: true

def reverse_words(str)
  str.split.reverse.join(' ')
end

def reverse_words_regex(str)
  words = str.strip.split(/\s+/)
  words.reverse.join(' ')
end

def reverse_words_manual(str)
  words = []
  current_word = ''

  str.each_char do |char|
    if char == ' '
      words << current_word unless current_word.empty?
      current_word = ''
    else
      current_word += char
    end
  end

  words << current_word unless current_word.empty?

  words.reverse.join(' ')
end

def reverse_words_scan(str)
  str.scan(/\S+/).reverse.join(' ')
end

def reverse_words_inplace(str)
  reversed = str.strip.reverse

  reversed.split.map(&:reverse).join(' ')
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 単語の反転 テスト ==='
  puts

  result1 = reverse_words('  hello   world  ')
  puts "Test 1: reverse_words('  hello   world  ')"
  puts "結果: '#{result1}'"
  puts "期待値: 'world hello'"
  puts "判定: #{result1 == 'world hello' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = reverse_words('the sky is blue')
  puts "Test 2: reverse_words('the sky is blue')"
  puts "結果: '#{result2}'"
  puts "期待値: 'blue is sky the'"
  puts "判定: #{result2 == 'blue is sky the' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = reverse_words('hello')
  puts "Test 3: reverse_words('hello')"
  puts "結果: '#{result3}'"
  puts "期待値: 'hello'"
  puts "判定: #{result3 == 'hello' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = reverse_words('   ')
  puts "Test 4: reverse_words('   ')"
  puts "結果: '#{result4}'"
  puts "期待値: ''"
  puts "判定: #{result4 == '' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = reverse_words('a b c')
  puts "Test 5: reverse_words('a b c')"
  puts "結果: '#{result5}'"
  puts "期待値: 'c b a'"
  puts "判定: #{result5 == 'c b a' ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
