#!/usr/bin/env ruby
# frozen_string_literal: true

def permutations(str)
  str.chars.permutation.map(&:join)
end

def permutations_recursive(str)
  return [str] if str.length <= 1

  result = []

  str.chars.each_with_index do |char, i|
    remaining = str[0...i] + str[(i + 1)..]

    permutations_recursive(remaining).each do |perm|
      result << char + perm
    end
  end

  result
end

def permutations_backtrack(str)
  result = []
  chars = str.chars

  backtrack(chars, 0, result)
  result.map(&:join)
end

def backtrack(chars, start, result)
  if start == chars.length
    result << chars.dup
    return
  end

  (start...chars.length).each do |i|
    chars[start], chars[i] = chars[i], chars[start]

    backtrack(chars, start + 1, result)

    chars[start], chars[i] = chars[i], chars[start]
  end
end

def permutations_unique(str)
  str.chars.permutation.map(&:join).uniq
end

def each_permutation(str, &block)
  return to_enum(:each_permutation, str) unless block_given?

  str.chars.permutation { |perm| block.call(perm.join) }
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 文字列の順列 テスト ==='
  puts

  result1 = permutations('abc')
  puts "Test 1: permutations('abc')"
  puts "結果: #{result1.sort}"
  expected1 = ['abc', 'acb', 'bac', 'bca', 'cab', 'cba']
  puts "期待値: #{expected1.sort}"
  puts "判定: #{result1.sort == expected1.sort ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = permutations_recursive('ab')
  puts "Test 2: permutations_recursive('ab')"
  puts "結果: #{result2.sort}"
  puts "期待値: ['ab', 'ba']"
  puts "判定: #{result2.sort == ['ab', 'ba'] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = permutations('a')
  puts "Test 3: permutations('a')"
  puts "結果: #{result3}"
  puts "期待値: ['a']"
  puts "判定: #{result3 == ['a'] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = permutations_unique('aab')
  puts "Test 4: permutations_unique('aab')"
  puts "結果: #{result4.sort}"
  puts "期待値: ['aab', 'aba', 'baa']"
  puts "判定: #{result4.sort == ['aab', 'aba', 'baa'] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
