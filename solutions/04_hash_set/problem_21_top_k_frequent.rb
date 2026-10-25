#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin top_k_frequent
# 解法1: tallyとsort_byを使用（推奨）
def top_k_frequent(words, k)
  # 各単語の出現回数をカウント
  count = words.tally

  # 頻度の降順、同頻度ならアルファベット順でソート
  sorted = count.sort_by { |word, freq| [-freq, word] }

  # 最初のk個の単語を返す
  sorted.first(k).map(&:first)
end

# 解法2: group_byを使用
def top_k_frequent_group_by(words, k)
  # 単語をグループ化してカウント
  count = words.group_by(&:itself).transform_values(&:count)

  # ソートして最初のk個を取得
  count.sort do |a, b|
    # 頻度が同じ場合はアルファベット順、そうでなければ頻度の降順
    if a[1] == b[1]
      a[0] <=> b[0]
    else
      b[1] <=> a[1]
    end
  end.first(k).map(&:first)
end

# 解法3: 手動でカウント
def top_k_frequent_manual(words, k)
  count = Hash.new(0)

  # 各単語をカウント
  words.each { |word| count[word] += 1 }

  # カスタムソート
  sorted = count.keys.sort do |a, b|
    if count[a] == count[b]
      a <=> b # 同頻度ならアルファベット順
    else
      count[b] <=> count[a] # 頻度の降順
    end
  end

  sorted.first(k)
end

# 解法4: max_byを使用
def top_k_frequent_max_by(words, k)
  count = words.tally

  result = []
  k.times do
    # 最大頻度の単語を見つける（同頻度ならアルファベット順で最小）
    max_word = count.keys.max_by { |word| [count[word], word.reverse] }
    result << max_word
    count.delete(max_word)
  end

  result
end

# テストケース
p top_k_frequent(['i', 'love', 'leetcode', 'i', 'love', 'coding'], 2)
# => ["i", "love"]

p top_k_frequent(['the', 'day', 'is', 'sunny', 'the', 'the', 'the', 'sunny', 'is', 'is'], 4)
# => ["the", "is", "sunny", "day"]

p top_k_frequent(['a', 'b', 'c'], 3)
# => ["a", "b", "c"]
# docs:end

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
