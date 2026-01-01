#!/usr/bin/env ruby
# frozen_string_literal: true

def letter_combinations(digits)
  return [] if digits.empty?

  mapping = {
    '2' => 'abc', '3' => 'def', '4' => 'ghi',
    '5' => 'jkl', '6' => 'mno', '7' => 'pqrs',
    '8' => 'tuv', '9' => 'wxyz'
  }

  result = []
  backtrack_letters('', 0, digits, mapping, result)
  result
end

def backtrack_letters(current, index, digits, mapping, result)
  if index == digits.length
    result << current
    return
  end

  digit = digits[index]
  letters = mapping[digit]

  letters.each_char do |letter|
    backtrack_letters(current + letter, index + 1, digits, mapping, result)
  end
end

def letter_combinations_iterative(digits)
  return [] if digits.empty?

  mapping = {
    '2' => 'abc', '3' => 'def', '4' => 'ghi',
    '5' => 'jkl', '6' => 'mno', '7' => 'pqrs',
    '8' => 'tuv', '9' => 'wxyz'
  }

  result = ['']

  digits.each_char do |digit|
    letters = mapping[digit]
    new_result = []

    result.each do |combo|
      letters.each_char do |letter|
        new_result << combo + letter
      end
    end

    result = new_result
  end

  result
end

def letter_combinations_recursive(digits)
  return [] if digits.empty?

  mapping = {
    '2' => 'abc', '3' => 'def', '4' => 'ghi',
    '5' => 'jkl', '6' => 'mno', '7' => 'pqrs',
    '8' => 'tuv', '9' => 'wxyz'
  }

  return mapping[digits[0]].chars if digits.length == 1

  first_letters = mapping[digits[0]].chars
  rest_combinations = letter_combinations_recursive(digits[1..])

  result = []
  first_letters.each do |letter|
    rest_combinations.each do |combo|
      result << letter + combo
    end
  end

  result
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 電話番号の文字の組み合わせ テスト ==='
  puts

  result1 = letter_combinations('23')
  puts "Test 1: letter_combinations('23')"
  puts "結果: #{result1}"
  expected1 = ['ad', 'ae', 'af', 'bd', 'be', 'bf', 'cd', 'ce', 'cf']
  puts "期待値: #{expected1}"
  puts "判定: #{result1 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = letter_combinations('')
  puts "Test 2: letter_combinations('')"
  puts "結果: #{result2}"
  puts '期待値: []'
  puts "判定: #{result2 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = letter_combinations('2')
  puts "Test 3: letter_combinations('2')"
  puts "結果: #{result3}"
  puts "期待値: ['a', 'b', 'c']"
  puts "判定: #{result3 == ['a', 'b', 'c'] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
