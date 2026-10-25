#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin palindrome?
# 解法1: reverseで比較（推奨）
def palindrome?(str)
  # 大文字小文字を統一して比較
  normalized = str.downcase
  normalized == normalized.reverse
end

# 解法2: 2ポインタ法（空間効率が良い）
def palindrome_two_pointer?(str)
  normalized = str.downcase
  left = 0
  right = normalized.length - 1

  while left < right
    # 両端の文字が一致しない場合は回文ではない
    return false if normalized[left] != normalized[right]

    left += 1
    right -= 1
  end

  true
end

# 解法3: 英数字のみを対象（より厳密な実装）
def palindrome_alphanumeric?(str)
  # 英数字以外を除去し、小文字に変換
  cleaned = str.downcase.gsub(/[^a-z0-9]/, '')
  cleaned == cleaned.reverse
end

# 解法4: 再帰的な実装
def palindrome_recursive?(str, left = 0, right = str.length - 1)
  normalized = str.downcase

  # ベースケース: ポインタが交差したら回文
  return true if left >= right

  # 両端が一致しなければ回文ではない
  return false if normalized[left] != normalized[right]

  # 内側に移動して再帰
  palindrome_recursive?(str, left + 1, right - 1)
end

# テストケース
puts palindrome?('RaceCar')      # => true
puts palindrome?('hello')        # => false
puts palindrome?('A')            # => true
puts palindrome?('')             # => true
puts palindrome?('Was it a car or a cat I saw'.gsub(' ', '')) # => true
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 回文判定 テスト ==='
  puts

  result1 = palindrome?('RaceCar')
  puts "Test 1: palindrome?('RaceCar')"
  puts "結果: #{result1}"
  puts '期待値: true'
  puts "判定: #{result1 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = palindrome?('hello')
  puts "Test 2: palindrome?('hello')"
  puts "結果: #{result2}"
  puts '期待値: false'
  puts "判定: #{result2 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = palindrome?('A')
  puts "Test 3: palindrome?('A')"
  puts "結果: #{result3}"
  puts '期待値: true'
  puts "判定: #{result3 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result4 = palindrome?('')
  puts "Test 4: palindrome?('')"
  puts "結果: #{result4}"
  puts '期待値: true'
  puts "判定: #{result4 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result5 = palindrome?('Was it a car or a cat I saw'.gsub(' ', ''))
  puts "Test 5: palindrome?('Was it a car or a cat I saw'.gsub(' ', ''))"
  puts "結果: #{result5}"
  puts '期待値: true'
  puts "判定: #{result5 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
