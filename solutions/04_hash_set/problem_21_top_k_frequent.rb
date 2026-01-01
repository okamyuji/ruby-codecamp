#!/usr/bin/env ruby
# frozen_string_literal: true

def top_k_frequent(words, k)
  count = words.tally

  sorted = count.sort_by { |word, freq| [-freq, word] }

  sorted.first(k).map(&:first)
end

def top_k_frequent_group_by(words, k)
  count = words.group_by(&:itself).transform_values(&:count)

  count.sort do |a, b|
    if a[1] == b[1]
      a[0] <=> b[0]
    else
      b[1] <=> a[1]
    end
  end.first(k).map(&:first)
end

def top_k_frequent_manual(words, k)
  count = Hash.new(0)

  words.each { |word| count[word] += 1 }

  sorted = count.keys.sort do |a, b|
    if count[a] == count[b]
      a <=> b
    else
      count[b] <=> count[a]
    end
  end

  sorted.first(k)
end

def top_k_frequent_max_by(words, k)
  count = words.tally

  result = []
  k.times do
    max_word = count.keys.max_by { |word| [count[word], word.reverse] }
    result << max_word
    count.delete(max_word)
  end

  result
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 単語の出現頻度 テスト ==='
  puts

  result1 = top_k_frequent(['i', 'love', 'leetcode', 'i', 'love', 'coding'], 2)
  puts "Test 1: top_k_frequent(['i', 'love', 'leetcode', 'i', 'love', 'coding'], 2)"
  puts "結果: #{result1}"
  puts "期待値: ['i', 'love']"
  puts "判定: #{result1 == ['i', 'love'] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = top_k_frequent(['the', 'day', 'is', 'sunny', 'the', 'the', 'the', 'sunny', 'is', 'is'], 4)
  puts "Test 2: top_k_frequent(['the', 'day', 'is', 'sunny', 'the', 'the', 'the', 'sunny', 'is', 'is'], 4)"
  puts "結果: #{result2}"
  puts "期待値: ['the', 'is', 'sunny', 'day']"
  puts "判定: #{result2 == ['the', 'is', 'sunny', 'day'] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = top_k_frequent(['a', 'b', 'c'], 3)
  puts "Test 3: top_k_frequent(['a', 'b', 'c'], 3)"
  puts "結果: #{result3}"
  puts "期待値: ['a', 'b', 'c']"
  puts "判定: #{result3 == ['a', 'b', 'c'] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
