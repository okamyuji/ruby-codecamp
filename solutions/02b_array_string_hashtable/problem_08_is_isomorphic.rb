#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 同型文字列の判定
# ファイル: 02b_array_string_hashtable.md
# ============================================================================
#
# 2つの文字列が与えられます。それらが同型（各文字が別の文字に1対1で対応する）であるかを
# 判定してください。
#
# 入力例:
#   s = "egg"
#   t = "add"
# 出力例: true  # e->a, g->d
#
# 時間計算量: O(n)
# 空間計算量: O(k) - kは一意な文字の数
# ============================================================================

# 解法1: 2つのハッシュマップ（推奨）
def is_isomorphic(s, t)
  return false if s.length != t.length

  s_to_t = {}
  t_to_s = {}

  s.length.times do |i|
    char_s = s[i]
    char_t = t[i]

    # sからtへのマッピングをチェック
    if s_to_t.key?(char_s)
      return false if s_to_t[char_s] != char_t
    else
      s_to_t[char_s] = char_t
    end

    # tからsへのマッピングをチェック
    if t_to_s.key?(char_t)
      return false if t_to_s[char_t] != char_s
    else
      t_to_s[char_t] = char_s
    end
  end

  true
end

# 解法2: 変換パターンを比較
def is_isomorphic_pattern(s, t)
  return false if s.length != t.length

  # 各文字列を数値パターンに変換
  pattern_s = create_pattern(s)
  pattern_t = create_pattern(t)

  pattern_s == pattern_t
end

def create_pattern(str)
  char_to_index = {}
  next_index = 0
  pattern = []

  str.each_char do |char|
    unless char_to_index.key?(char)
      char_to_index[char] = next_index
      next_index += 1
    end
    pattern << char_to_index[char]
  end

  pattern
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 同型文字列の判定 テスト ==='
  puts

  # テストケース1: 同型
  result1 = is_isomorphic('egg', 'add')
  puts "Test 1: is_isomorphic('egg', 'add')"
  puts "結果: #{result1}"
  puts '期待値: true (e->a, g->d)'
  puts "判定: #{result1 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 同型でない
  result2 = is_isomorphic('foo', 'bar')
  puts "Test 2: is_isomorphic('foo', 'bar')"
  puts "結果: #{result2}"
  puts '期待値: false'
  puts "判定: #{result2 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 同型
  result3 = is_isomorphic('paper', 'title')
  puts "Test 3: is_isomorphic('paper', 'title')"
  puts "結果: #{result3}"
  puts '期待値: true (p->t, a->i, e->l, r->e)'
  puts "判定: #{result3 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 同型でない（1対多）
  result4 = is_isomorphic('ab', 'aa')
  puts "Test 4: is_isomorphic('ab', 'aa')"
  puts "結果: #{result4}"
  puts '期待値: false (aとbが両方aに対応できない)'
  puts "判定: #{result4 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース5: 同じ文字列
  result5 = is_isomorphic('abc', 'abc')
  puts "Test 5: is_isomorphic('abc', 'abc')"
  puts "結果: #{result5}"
  puts '期待値: true'
  puts "判定: #{result5 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（パターン比較）
  puts '--- 解法2（パターン比較）のテスト ---'
  result6 = is_isomorphic_pattern('egg', 'add')
  puts "is_isomorphic_pattern('egg', 'add') = #{result6}"
  puts "判定: #{result6 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result7 = is_isomorphic_pattern('foo', 'bar')
  puts "is_isomorphic_pattern('foo', 'bar') = #{result7}"
  puts "判定: #{result7 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
