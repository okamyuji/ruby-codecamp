#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin reverse_words
# 解法1: split, reverse, joinを使用（推奨）
def reverse_words(str)
  # splitは連続する空白も処理し、空文字列を除外
  str.split.reverse.join(' ')
end

# 解法2: 正規表現で分割
def reverse_words_regex(str)
  # 1つ以上の空白で分割
  words = str.strip.split(/\s+/)
  words.reverse.join(' ')
end

# 解法3: 手動で単語を抽出
def reverse_words_manual(str)
  words = []
  current_word = ''

  str.each_char do |char|
    if char == ' '
      # 空白に遭遇したら、現在の単語を保存
      words << current_word unless current_word.empty?
      current_word = ''
    else
      current_word += char
    end
  end

  # 最後の単語を追加
  words << current_word unless current_word.empty?

  words.reverse.join(' ')
end

# 解法4: scanを使用
def reverse_words_scan(str)
  # 非空白文字の連続にマッチ
  str.scan(/\S+/).reverse.join(' ')
end

# 解法5: in-placeで反転（参考実装）
def reverse_words_inplace(str)
  # まず文字列全体を反転
  reversed = str.strip.reverse

  # 次に各単語を個別に反転
  reversed.split.map(&:reverse).join(' ')
end

# テストケース
p reverse_words('  hello   world  ')    # => "world hello"
p reverse_words('the sky is blue')      # => "blue is sky the"
p reverse_words('hello')                # => "hello"
p reverse_words('   ')                  # => ""
p reverse_words('a b c')                # => "c b a"
# docs:end

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
