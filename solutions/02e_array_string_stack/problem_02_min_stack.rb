#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 最小値を返すスタック
# ファイル: 02e_array_string_stack.md
# ============================================================================
#
# push、pop、topの各操作に加えて、最小要素を定数時間で取得できるスタックを実装してください。
#
# 時間計算量: すべての操作でO(1)
# 空間計算量: O(n)
# ============================================================================

# 解法1: 2つのスタックを使用
class MinStack
  def initialize
    @stack = []
    @min_stack = []
  end

  def push(val)
    @stack << val

    @min_stack << val if @min_stack.empty? || val <= @min_stack.last
  end

  def pop
    val = @stack.pop

    @min_stack.pop if val == @min_stack.last

    val
  end

  def top
    @stack.last
  end

  def get_min
    @min_stack.last
  end
end

# 解法2: ペアでスタックに格納
class MinStack2
  def initialize
    @stack = [] # [value, min_so_far]のペアを格納
  end

  def push(val)
    min_val = @stack.empty? ? val : [val, @stack.last[1]].min
    @stack << [val, min_val]
  end

  def pop
    @stack.pop[0]
  end

  def top
    @stack.last[0]
  end

  def get_min
    @stack.last[1]
  end
end

# 解法3: 差分を記録（スペース最適化版）
class MinStack3
  def initialize
    @stack = []
    @min = nil
  end

  def push(val)
    if @stack.empty?
      @stack << 0
      @min = val
    else
      @stack << val - @min
      @min = val if val < @min
    end
  end

  def pop
    diff = @stack.pop

    if diff < 0
      val = @min
      @min -= diff
      val
    else
      @min + diff
    end
  end

  def top
    diff = @stack.last
    diff < 0 ? @min : @min + diff
  end

  def get_min
    @min
  end
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 最小値を返すスタック テスト ==='
  puts

  # 解法1のテスト
  puts '--- 解法1（2つのスタック）のテスト ---'
  min_stack = MinStack.new
  min_stack.push(-2)
  min_stack.push(0)
  min_stack.push(-3)

  result1 = min_stack.get_min
  puts 'push(-2), push(0), push(-3), get_min()'
  puts "結果: #{result1}"
  puts '期待値: -3'
  puts "判定: #{result1 == -3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  min_stack.pop
  result2 = min_stack.top
  puts 'pop(), top()'
  puts "結果: #{result2}"
  puts '期待値: 0'
  puts "判定: #{result2 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = min_stack.get_min
  puts 'get_min()'
  puts "結果: #{result3}"
  puts '期待値: -2'
  puts "判定: #{result3 == -2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト
  puts '--- 解法2（ペア格納）のテスト ---'
  min_stack2 = MinStack2.new
  min_stack2.push(-2)
  min_stack2.push(0)
  min_stack2.push(-3)

  result4 = min_stack2.get_min
  puts 'MinStack2: push(-2), push(0), push(-3), get_min()'
  puts "結果: #{result4}"
  puts "判定: #{result4 == -3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  min_stack2.pop
  result5 = min_stack2.get_min
  puts 'pop(), get_min()'
  puts "結果: #{result5}"
  puts "判定: #{result5 == -2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト
  puts '--- 解法3（差分記録）のテスト ---'
  min_stack3 = MinStack3.new
  min_stack3.push(-2)
  min_stack3.push(0)
  min_stack3.push(-3)

  result6 = min_stack3.get_min
  puts 'MinStack3: push(-2), push(0), push(-3), get_min()'
  puts "結果: #{result6}"
  puts "判定: #{result6 == -3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  min_stack3.pop
  result7 = min_stack3.get_min
  puts 'pop(), get_min()'
  puts "結果: #{result7}"
  puts "判定: #{result7 == -2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
