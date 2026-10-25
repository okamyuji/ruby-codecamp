#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin permutations
# 解法1: 組み込みメソッドを使用（推奨）
def permutations(str)
  str.chars.permutation.map(&:join)
end

# 解法2: 再帰的な実装
def permutations_recursive(str)
  return [str] if str.length <= 1

  result = []

  str.chars.each_with_index do |char, i|
    # 現在の文字を除いた残りの文字列
    remaining = str[0...i] + str[(i + 1)..]

    # 残りの文字列の順列を再帰的に取得
    permutations_recursive(remaining).each do |perm|
      result << char + perm
    end
  end

  result
end

# 解法3: バックトラッキング
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
    # 現在位置とi番目を交換
    chars[start], chars[i] = chars[i], chars[start]

    # 次の位置で再帰
    backtrack(chars, start + 1, result)

    # 交換を元に戻す（バックトラック）
    chars[start], chars[i] = chars[i], chars[start]
  end
end

# 解法4: 重複を含む場合の対応
def permutations_unique(str)
  str.chars.permutation.map(&:join).uniq
end

# 解法5: イテレータとして実装
def each_permutation(str, &block)
  return to_enum(:each_permutation, str) unless block_given?

  str.chars.permutation { |perm| block.call(perm.join) }
end

# テストケース
p permutations('abc')
# => ["abc", "acb", "bac", "bca", "cab", "cba"]

p permutations_recursive('ab')
# => ["ab", "ba"]

p permutations('a')
# => ["a"]

p permutations_unique('aab')
# => ["aab", "aba", "baa"]

each_permutation('xy') { |p| puts p }
# 出力: xy
# 出力: yx
# docs:end

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
