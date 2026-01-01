#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 回文の判定
# ファイル: 02g_array_string_two_pointers.md
# ============================================================================
#
# 文字列が与えられます。英数字のみを考慮し、大文字小文字を区別せずに、回文かどうかを
# 判定してください。
#
# 入力例: "A man, a plan, a canal: Panama"
# 出力例: true
#
# 時間計算量: O(n)
# 空間計算量: O(1)
# ============================================================================

# 解法1: Two Pointers
def is_palindrome(s)
  left = 0
  right = s.length - 1

  while left < right
    # 英数字でない文字をスキップ
    left += 1 while left < right && !alphanumeric?(s[left])
    right -= 1 while left < right && !alphanumeric?(s[right])

    # 大文字小文字を無視して比較
    return false if s[left].downcase != s[right].downcase

    left += 1
    right -= 1
  end

  true
end

def alphanumeric?(char)
  char =~ /[a-zA-Z0-9]/
end

# 解法2: 文字列を整形してから比較
def is_palindrome_clean(s)
  cleaned = s.downcase.gsub(/[^a-z0-9]/, '')
  cleaned == cleaned.reverse
end

# 解法3: each_charとreduceを使用
def is_palindrome_functional(s)
  chars = s.downcase.chars.grep(/[a-z0-9]/)
  chars == chars.reverse
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 回文の判定 テスト ==='
  puts

  # テストケース1: 回文
  result1 = is_palindrome('A man, a plan, a canal: Panama')
  puts "Test 1: is_palindrome('A man, a plan, a canal: Panama')"
  puts "結果: #{result1}"
  puts '期待値: true'
  puts "判定: #{result1 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 回文でない
  result2 = is_palindrome('race a car')
  puts "Test 2: is_palindrome('race a car')"
  puts "結果: #{result2}"
  puts '期待値: false'
  puts "判定: #{result2 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 空白のみ
  result3 = is_palindrome(' ')
  puts "Test 3: is_palindrome(' ')"
  puts "結果: #{result3}"
  puts '期待値: true'
  puts "判定: #{result3 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 英数字混在
  result4 = is_palindrome('0P')
  puts "Test 4: is_palindrome('0P')"
  puts "結果: #{result4}"
  puts '期待値: false'
  puts "判定: #{result4 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（整形）
  puts '--- 解法2（整形）のテスト ---'
  result5 = is_palindrome_clean('A man, a plan, a canal: Panama')
  puts "is_palindrome_clean('A man, a plan, a canal: Panama') = #{result5}"
  puts "判定: #{result5 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（関数型）
  puts '--- 解法3（関数型）のテスト ---'
  result6 = is_palindrome_functional('A man, a plan, a canal: Panama')
  puts "is_palindrome_functional('A man, a plan, a canal: Panama') = #{result6}"
  puts "判定: #{result6 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
