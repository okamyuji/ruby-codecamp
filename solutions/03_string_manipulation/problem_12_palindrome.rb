#!/usr/bin/env ruby
# frozen_string_literal: true

def palindrome?(str)
  normalized = str.downcase
  normalized == normalized.reverse
end

def palindrome_two_pointer?(str)
  normalized = str.downcase
  left = 0
  right = normalized.length - 1

  while left < right
    return false if normalized[left] != normalized[right]

    left += 1
    right -= 1
  end

  true
end

def palindrome_alphanumeric?(str)
  cleaned = str.downcase.gsub(/[^a-z0-9]/, '')
  cleaned == cleaned.reverse
end

def palindrome_recursive?(str, left = 0, right = str.length - 1)
  normalized = str.downcase

  return true if left >= right

  return false if normalized[left] != normalized[right]

  palindrome_recursive?(str, left + 1, right - 1)
end

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
