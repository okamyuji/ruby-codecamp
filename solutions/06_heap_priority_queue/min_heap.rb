#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin MinHeap
class MinHeap
  def initialize
    @heap = []
  end

  # 要素の追加
  def push(value)
    @heap << value
    heapify_up(@heap.length - 1)
  end

  # 最小要素の取り出し
  def pop
    return nil if @heap.empty?

    # ルートと最後の要素を交換
    @heap[0], @heap[-1] = @heap[-1], @heap[0]
    min = @heap.pop

    # ルートから下方向にヒープを再構築
    heapify_down(0) unless @heap.empty?

    min
  end

  # 最小要素の参照（削除しない）
  def peek
    @heap[0]
  end

  # ヒープが空かどうか
  def empty?
    @heap.empty?
  end

  # ヒープのサイズ
  def size
    @heap.length
  end

  private

  # 上方向へのヒープ化
  def heapify_up(index)
    return if index == 0

    parent_index = (index - 1) / 2

    if (@heap[index] <=> @heap[parent_index]).negative?
      @heap[index], @heap[parent_index] = @heap[parent_index], @heap[index]
      heapify_up(parent_index)
    end
  end

  # 下方向へのヒープ化
  def heapify_down(index)
    left_child = 2 * index + 1
    right_child = 2 * index + 2
    smallest = index

    if left_child < @heap.length && (@heap[left_child] <=> @heap[smallest]).negative?
      smallest = left_child
    end

    if right_child < @heap.length && (@heap[right_child] <=> @heap[smallest]).negative?
      smallest = right_child
    end

    if smallest != index
      @heap[index], @heap[smallest] = @heap[smallest], @heap[index]
      heapify_down(smallest)
    end
  end
end

# 使用例
heap = MinHeap.new
heap.push(5)
heap.push(3)
heap.push(7)
heap.push(1)

puts heap.pop  # => 1
puts heap.pop  # => 3
puts heap.peek # => 5
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== MinHeap テスト ==='
  puts

  heap = MinHeap.new
  heap.push(5)
  heap.push(3)
  heap.push(7)
  heap.push(1)

  puts 'Test 1: heap.pop (期待値: 1)'
  result1 = heap.pop
  puts "結果: #{result1}"
  puts "判定: #{result1 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts 'Test 2: heap.pop (期待値: 3)'
  result2 = heap.pop
  puts "結果: #{result2}"
  puts "判定: #{result2 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts 'Test 3: heap.peek (期待値: 5)'
  result3 = heap.peek
  puts "結果: #{result3}"
  puts "判定: #{result3 == 5 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
