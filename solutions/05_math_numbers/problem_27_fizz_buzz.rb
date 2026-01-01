#!/usr/bin/env ruby
# frozen_string_literal: true

def fizz_buzz(n)
  (1..n).map do |num|
    if num % 15 == 0
      'FizzBuzz'
    elsif num % 3 == 0
      'Fizz'
    elsif num % 5 == 0
      'Buzz'
    else
      num.to_s
    end
  end
end

def fizz_buzz_concat(n)
  (1..n).map do |num|
    result = ''
    result += 'Fizz' if num % 3 == 0
    result += 'Buzz' if num % 5 == 0
    result.empty? ? num.to_s : result
  end
end

def fizz_buzz_case(n)
  (1..n).map do |num|
    case
    when num % 15 == 0 then 'FizzBuzz'
    when num % 3 == 0 then 'Fizz'
    when num % 5 == 0 then 'Buzz'
    else num.to_s
    end
  end
end

def fizz_buzz_extensible(n, rules = { 3 => 'Fizz', 5 => 'Buzz' })
  (1..n).map do |num|
    result = rules.select { |divisor, _| num % divisor == 0 }
                  .values
                  .join
    result.empty? ? num.to_s : result
  end
end

if __FILE__ == $PROGRAM_NAME
  puts '=== フィズバズ（FizzBuzz） テスト ==='
  puts

  result1 = fizz_buzz(15)
  puts 'Test 1: fizz_buzz(15)'
  puts "結果: #{result1}"
  expected1 = ['1', '2', 'Fizz', '4', 'Buzz', 'Fizz', '7', '8', 'Fizz', 'Buzz', '11', 'Fizz', '13', '14', 'FizzBuzz']
  puts "判定: #{result1 == expected1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = fizz_buzz(3)
  puts 'Test 2: fizz_buzz(3)'
  puts "結果: #{result2}"
  puts "期待値: ['1', '2', 'Fizz']"
  puts "判定: #{result2 == ['1', '2', 'Fizz'] ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = fizz_buzz(1)
  puts 'Test 3: fizz_buzz(1)'
  puts "結果: #{result3}"
  puts "期待値: ['1']"
  puts "判定: #{result3 == ['1'] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
