#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin ListNode
class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end
# docs:end

# docs:begin print_list
# リストの作成
node1 = ListNode.new(1)
node2 = ListNode.new(2)
node3 = ListNode.new(3)

node1.next = node2
node2.next = node3

# リストの走査
def print_list(head)
  current = head
  while current
    print "#{current.val} -> "
    current = current.next
  end
  puts 'nil'
end

print_list(node1) # 出力: 1 -> 2 -> 3 -> nil
# docs:end

# docs:begin list_length
def list_length(head)
  length = 0
  current = head

  while current
    length += 1
    current = current.next
  end

  length
end

# テストケース
head = ListNode.new(1, ListNode.new(2, ListNode.new(3)))
puts list_length(head) # => 3
# docs:end

# docs:begin get_nth_value
def get_nth_value(head, n)
  current = head
  index = 0

  while current
    return current.val if index == n

    current = current.next
    index += 1
  end

  nil # nが範囲外の場合
end

# テストケース
head = ListNode.new(1, ListNode.new(2, ListNode.new(3)))
puts get_nth_value(head, 1) # => 2
# docs:end

# docs:begin delete_value
def delete_value(head, val)
  # ダミーノードを使用して、先頭ノード削除を簡単に処理
  dummy = ListNode.new(0, head)
  current = dummy

  while current.next
    if current.next.val == val
      # ノードをスキップして削除
      current.next = current.next.next
    else
      current = current.next
    end
  end

  dummy.next
end
# docs:end

# docs:begin delete_nth_node
def delete_nth_node(head, n)
  dummy = ListNode.new(0, head)
  current = dummy
  index = 0

  while current.next
    if index == n
      current.next = current.next.next
      break
    end
    current = current.next
    index += 1
  end

  dummy.next
end
# docs:end

# docs:begin reverse_list
def reverse_list(head)
  prev = nil
  current = head

  while current
    # 次のノードを一時保存
    next_node = current.next
    # 現在のノードの next を前のノードに向ける
    current.next = prev
    # prev と current を進める
    prev = current
    current = next_node
  end

  prev # 新しい先頭
end

# 再帰版
def reverse_list_recursive(head, prev = nil)
  return prev if head.nil?

  next_node = head.next
  head.next = prev
  reverse_list_recursive(next_node, head)
end
# docs:end

# docs:begin merge_two_lists
def merge_two_lists(list1, list2)
  dummy = ListNode.new(0)
  current = dummy

  while list1 && list2
    if list1.val <= list2.val
      current.next = list1
      list1 = list1.next
    else
      current.next = list2
      list2 = list2.next
    end
    current = current.next
  end

  # 残りを追加
  current.next = list1 || list2

  dummy.next
end
# docs:end

# docs:begin has_cycle
def has_cycle(head)
  return false if head.nil?

  slow = head
  fast = head

  while fast && fast.next
    slow = slow.next
    fast = fast.next.next

    return true if slow == fast
  end

  false
end
# docs:end

# docs:begin middle_node
def middle_node(head)
  slow = head
  fast = head

  while fast && fast.next
    slow = slow.next
    fast = fast.next.next
  end

  slow
end
# docs:end

# docs:begin remove_nth_from_end
def remove_nth_from_end(head, n)
  dummy = ListNode.new(0, head)
  first = dummy
  second = dummy

  # first を n+1 歩進める
  (n + 1).times { first = first.next }

  # 両方のポインタを進める
  while first
    first = first.next
    second = second.next
  end

  # second の次のノードを削除
  second.next = second.next.next

  dummy.next
end
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 連結リスト テスト ==='
  puts

  head = ListNode.new(1, ListNode.new(2, ListNode.new(3)))

  puts 'Test 1: list_length'
  result1 = list_length(head)
  puts "結果: #{result1}"
  puts "判定: #{result1 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts 'Test 2: get_nth_value(head, 1)'
  result2 = get_nth_value(head, 1)
  puts "結果: #{result2}"
  puts "判定: #{result2 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts 'Test 3: reverse_list'
  reversed = reverse_list(ListNode.new(1, ListNode.new(2, ListNode.new(3))))
  result3 = []
  current = reversed
  while current
    result3 << current.val
    current = current.next
  end
  puts "結果: #{result3}"
  puts "判定: #{result3 == [3, 2, 1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
