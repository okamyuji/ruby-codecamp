#!/usr/bin/env ruby
# frozen_string_literal: true

def reverse_string(str)
  str.reverse
end

def reverse_string_manual(str)
  result = ''

  (str.length - 1).downto(0) do |i|
    result += str[i]
  end

  result
end

def reverse_string_array(str)
  str.chars.reverse.join
end

def reverse_string_reduce(str)
  str.chars.reduce('') { |acc, char| char + acc }
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 文字列の反転 テスト ==='
  puts

  result1 = reverse_string('hello')
  puts "Test 1: reverse_string('hello')"
  puts "結果: '#{result1}'"
  puts "期待値: 'olleh'"
  puts "判定: #{result1 == 'olleh' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = reverse_string('Ruby')
  puts "Test 2: reverse_string('Ruby')"
  puts "結果: '#{result2}'"
  puts "期待値: 'ybuR'"
  puts "判定: #{result2 == 'ybuR' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = reverse_string('a')
  puts "Test 3: reverse_string('a')"
  puts "結果: '#{result3}'"
  puts "期待値: 'a'"
  puts "判定: #{result3 == 'a' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = reverse_string('')
  puts "Test 4: reverse_string('')"
  puts "結果: '#{result4}'"
  puts "期待値: ''"
  puts "判定: #{result4 == '' ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = reverse_string('12345')
  puts "Test 5: reverse_string('12345')"
  puts "結果: '#{result5}'"
  puts "期待値: '54321'"
  puts "判定: #{result5 == '54321' ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
