#!/usr/bin/env ruby
# frozen_string_literal: true

class MaxHeap
  def initialize
    @heap = []
  end

  def push(value)
    @heap << value
    heapify_up(@heap.length - 1)
  end

  def pop
    return nil if @heap.empty?

    @heap[0], @heap[-1] = @heap[-1], @heap[0]
    max = @heap.pop

    heapify_down(0) unless @heap.empty?

    max
  end

  def peek
    @heap[0]
  end

  def empty?
    @heap.empty?
  end

  def size
    @heap.length
  end

  private

  def heapify_up(index)
    return if index == 0

    parent_index = (index - 1) / 2

    return unless @heap[index] > @heap[parent_index]

    @heap[index], @heap[parent_index] = @heap[parent_index], @heap[index]
    heapify_up(parent_index)
  end

  def heapify_down(index)
    left_child = 2 * index + 1
    right_child = 2 * index + 2
    largest = index

    largest = left_child if left_child < @heap.length && @heap[left_child] > @heap[largest]

    largest = right_child if right_child < @heap.length && @heap[right_child] > @heap[largest]

    return unless largest != index

    @heap[index], @heap[largest] = @heap[largest], @heap[index]
    heapify_down(largest)
  end
end

if __FILE__ == $PROGRAM_NAME
  puts '=== MaxHeap テスト ==='
  puts

  heap = MaxHeap.new
  heap.push(5)
  heap.push(3)
  heap.push(7)
  heap.push(1)

  puts 'Test 1: heap.pop (期待値: 7)'
  result1 = heap.pop
  puts "結果: #{result1}"
  puts "判定: #{result1 == 7 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts 'Test 2: heap.pop (期待値: 5)'
  result2 = heap.pop
  puts "結果: #{result2}"
  puts "判定: #{result2 == 5 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts 'Test 3: heap.peek (期待値: 3)'
  result3 = heap.peek
  puts "結果: #{result3}"
  puts "判定: #{result3 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
