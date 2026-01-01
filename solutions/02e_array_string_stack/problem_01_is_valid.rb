#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 有効な括弧
# ファイル: 02e_array_string_stack.md
# ============================================================================
#
# '(', ')', '{', '}', '[', ']' のみを含む文字列が与えられます。
# 入力文字列が有効かどうかを判定してください。
#
# 有効な文字列は以下の条件を満たします:
# 1. 開き括弧は同じ種類の閉じ括弧で閉じられる
# 2. 開き括弧は正しい順序で閉じられる
#
# 入力例: "()[]{}"
# 出力例: true
#
# 時間計算量: O(n)
# 空間計算量: O(n)
# ============================================================================

# 解法1: スタックとハッシュを使用
def is_valid(s)
  stack = []
  pairs = { '(' => ')', '{' => '}', '[' => ']' }

  s.each_char do |char|
    if pairs.key?(char)
      stack << char
    else
      return false if stack.empty?

      opening = stack.pop
      return false if pairs[opening] != char
    end
  end

  stack.empty?
end

# 解法2: 逆マッピングを使用
def is_valid_reverse_map(s)
  stack = []
  closing = { ')' => '(', '}' => '{', ']' => '[' }

  s.each_char do |char|
    if closing.key?(char)
      return false if stack.empty? || stack.pop != closing[char]
    else
      stack << char
    end
  end

  stack.empty?
end

# 解法3: caseを使用
def is_valid_case(s)
  stack = []

  s.each_char do |char|
    case char
    when '(', '{', '['
      stack << char
    when ')'
      return false if stack.empty? || stack.pop != '('
    when '}'
      return false if stack.empty? || stack.pop != '{'
    when ']'
      return false if stack.empty? || stack.pop != '['
    end
  end

  stack.empty?
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 有効な括弧 テスト ==='
  puts

  # テストケース1: 有効
  result1 = is_valid('()')
  puts "Test 1: is_valid('()')"
  puts "結果: #{result1}"
  puts '期待値: true'
  puts "判定: #{result1 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 有効（複数種類）
  result2 = is_valid('()[]{}')
  puts "Test 2: is_valid('()[]{}')"
  puts "結果: #{result2}"
  puts '期待値: true'
  puts "判定: #{result2 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 無効（対応しない）
  result3 = is_valid('(]')
  puts "Test 3: is_valid('(]')"
  puts "結果: #{result3}"
  puts '期待値: false'
  puts "判定: #{result3 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 無効（順序が間違い）
  result4 = is_valid('([)]')
  puts "Test 4: is_valid('([)]')"
  puts "結果: #{result4}"
  puts '期待値: false'
  puts "判定: #{result4 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース5: 有効（ネスト）
  result5 = is_valid('{[]}')
  puts "Test 5: is_valid('{[]}')"
  puts "結果: #{result5}"
  puts '期待値: true'
  puts "判定: #{result5 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（逆マッピング）
  puts '--- 解法2（逆マッピング）のテスト ---'
  result6 = is_valid_reverse_map('()[]{}')
  puts "is_valid_reverse_map('()[]{}') = #{result6}"
  puts "判定: #{result6 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（case）
  puts '--- 解法3（case）のテスト ---'
  result7 = is_valid_case('()[]{}')
  puts "is_valid_case('()[]{}') = #{result7}"
  puts "判定: #{result7 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
