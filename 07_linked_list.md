# 連結リスト

## 概要

このセクションでは、連結リスト（Linked List）について学びます。連結リストはノードの集合で、各ノードがデータと次のノードへの参照を持つデータ構造です。

## 連結リストの導入

### 連結リストとは

連結リストは、各要素（ノード）が次の要素への参照を持つ線形データ構造です。配列と異なり、要素が連続したメモリ領域に格納されません。

### ノードの定義

```ruby
class ListNode
  attr_accessor :val, :next
  
  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end
```

### 基本的な操作

```ruby
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
  puts "nil"
end

print_list(node1)  # => 1 -> 2 -> 3 -> nil
```

## リスト走査

### 問題1: リストの長さを求める

```ruby
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
puts list_length(head)  # => 3
```

### 問題2: N番目のノードの値を取得

```ruby
def get_nth_value(head, n)
  current = head
  index = 0
  
  while current
    return current.val if index == n
    current = current.next
    index += 1
  end
  
  nil  # nが範囲外の場合
end

# テストケース
head = ListNode.new(1, ListNode.new(2, ListNode.new(3)))
puts get_nth_value(head, 1)  # => 2
```

## ノード削除

### 問題3: 値を指定してノードを削除

```ruby
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
```

### 問題4: N番目のノードを削除

```ruby
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
```

## リスト反転

### 問題5: リストを反転する

```ruby
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
  
  prev  # 新しい先頭
end

# 再帰版
def reverse_list_recursive(head, prev = nil)
  return prev if head.nil?
  
  next_node = head.next
  head.next = prev
  reverse_list_recursive(next_node, head)
end
```

## 複数のリスト走査

### 問題6: 2つのソート済みリストをマージ

```ruby
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
```

## Two Pointers (Slow/Fast Pointers)

### 問題7: サイクル検出

```ruby
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
```

### 問題8: 中間ノードを見つける

```ruby
def middle_node(head)
  slow = head
  fast = head
  
  while fast && fast.next
    slow = slow.next
    fast = fast.next.next
  end
  
  slow
end
```

### 問題9: 末尾からN番目のノードを削除

```ruby
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
```

## 双方向リスト

### 双方向リストのノード定義

```ruby
class DoublyListNode
  attr_accessor :val, :prev, :next
  
  def initialize(val = 0, _prev = nil, _next = nil)
    @val = val
    @prev = _prev
    @next = _next
  end
end
```

### 問題10: 双方向リストへの挿入

```ruby
def insert_node(prev_node, val)
  return nil if prev_node.nil?
  
  new_node = DoublyListNode.new(val)
  new_node.next = prev_node.next
  new_node.prev = prev_node
  
  prev_node.next.prev = new_node if prev_node.next
  prev_node.next = new_node
  
  new_node
end
```

## まとめ

このセクションでは、連結リストの基本操作を学びました。

重要なポイントは以下の通りです。

- 連結リストは動的なデータ構造で、挿入・削除がO(1)で可能です
- Two Pointersテクニックは、サイクル検出や中間ノード検索に有用です
- ダミーノードを使用すると、エッジケースの処理が簡単になります
- リストの反転は、ポインタの付け替えで実現します
- 双方向リストは、前後へのアクセスが可能です

連結リストは、配列と異なり連続したメモリを必要としないため、動的なデータ管理に適しています。
