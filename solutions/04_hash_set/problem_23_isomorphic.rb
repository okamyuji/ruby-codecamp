#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin isomorphic?
# 解法1: 双方向マッピングを使用（推奨）
def isomorphic?(s, t)
  return false if s.length != t.length

  # sからtへのマッピング
  s_to_t = {}
  # tからsへのマッピング
  t_to_s = {}

  s.chars.each_with_index do |char_s, i|
    char_t = t[i]

    if s_to_t.key?(char_s)
      # 既存のマッピングと矛盾がないかチェック
      return false if s_to_t[char_s] != char_t
    else
      # 新しいマッピングを作成する前に、tの文字が既に使われていないかチェック
      return false if t_to_s.key?(char_t)

      s_to_t[char_s] = char_t
      t_to_s[char_t] = char_s
    end
  end

  true
end

# 解法2: パターンを比較
def isomorphic_pattern?(s, t)
  return false if s.length != t.length

  # 各文字列のパターンを生成
  # 例: "egg" -> [0, 1, 1], "add" -> [0, 1, 1]
  pattern_s = generate_pattern(s)
  pattern_t = generate_pattern(t)

  pattern_s == pattern_t
end

def generate_pattern(str)
  char_to_index = {}
  pattern = []

  str.each_char do |char|
    unless char_to_index.key?(char)
      char_to_index[char] = char_to_index.size
    end
    pattern << char_to_index[char]
  end

  pattern
end

# 解法3: zipを使用
def isomorphic_zip?(s, t)
  return false if s.length != t.length

  s_to_t = {}
  t_to_s = {}

  s.chars.zip(t.chars).each do |char_s, char_t|
    s_to_t[char_s] ||= char_t
    t_to_s[char_t] ||= char_s

    return false if s_to_t[char_s] != char_t || t_to_s[char_t] != char_s
  end

  true
end

# テストケース
puts isomorphic?('egg', 'add')      # => true
puts isomorphic?('foo', 'bar')      # => false
puts isomorphic?('paper', 'title')  # => true
puts isomorphic?('ab', 'aa')        # => false
puts isomorphic?('', '')            # => true
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 同構造の文字列（Isomorphic Strings） テスト ==='
  puts

  result1 = isomorphic?('egg', 'add')
  puts "Test 1: isomorphic?('egg', 'add')"
  puts "結果: #{result1}"
  puts '期待値: true'
  puts "判定: #{result1 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = isomorphic?('foo', 'bar')
  puts "Test 2: isomorphic?('foo', 'bar')"
  puts "結果: #{result2}"
  puts '期待値: false'
  puts "判定: #{result2 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = isomorphic?('paper', 'title')
  puts "Test 3: isomorphic?('paper', 'title')"
  puts "結果: #{result3}"
  puts '期待値: true'
  puts "判定: #{result3 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = isomorphic?('ab', 'aa')
  puts "Test 4: isomorphic?('ab', 'aa')"
  puts "結果: #{result4}"
  puts '期待値: false'
  puts "判定: #{result4 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = isomorphic?('', '')
  puts "Test 5: isomorphic?('', '')"
  puts "結果: #{result5}"
  puts '期待値: true'
  puts "判定: #{result5 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
