# 二分木

## 概要

このセクションでは、二分木（Binary Tree）について学びます。二分木は各ノードが最大2つの子を持つ木構造で、多くのアルゴリズムとデータ構造の基礎となります。

## 二分木の導入

### 二分木とは

二分木は、各ノードが最大2つの子ノード（左の子、右の子）を持つ階層的なデータ構造です。

### ノードの定義

```ruby
class TreeNode
  attr_accessor :val, :left, :right
  
  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end
```

### 二分木の種類

- 完全二分木: すべてのレベルが完全に埋まっている（最後のレベルを除く）
- 満二分木: すべてのノードが0個または2個の子を持つ
- 平衡二分木: 左右の部分木の高さの差が1以下
- 二分探索木: 左の子 < 親 < 右の子の関係が成り立つ

## BFS（幅優先探索）

### レベル順走査

```ruby
def level_order(root)
  return [] if root.nil?
  
  result = []
  queue = [root]
  
  while !queue.empty?
    level_size = queue.length
    level = []
    
    level_size.times do
      node = queue.shift
      level << node.val
      
      queue << node.left if node.left
      queue << node.right if node.right
    end
    
    result << level
  end
  
  result
end

# 使用例
root = TreeNode.new(3)
root.left = TreeNode.new(9)
root.right = TreeNode.new(20)
root.right.left = TreeNode.new(15)
root.right.right = TreeNode.new(7)

p level_order(root)  # => [[3], [9, 20], [15, 7]]
```

### 問題1: 二分木の最大深さ

```ruby
def max_depth_bfs(root)
  return 0 if root.nil?
  
  depth = 0
  queue = [root]
  
  while !queue.empty?
    level_size = queue.length
    
    level_size.times do
      node = queue.shift
      queue << node.left if node.left
      queue << node.right if node.right
    end
    
    depth += 1
  end
  
  depth
end
```

## DFS（深さ優先探索）

### 前順走査（Pre-order）

```ruby
def preorder_traversal(root)
  result = []
  
  def dfs(node, result)
    return if node.nil?
    
    result << node.val       # ルート
    dfs(node.left, result)   # 左
    dfs(node.right, result)  # 右
  end
  
  dfs(root, result)
  result
end
```

### 中順走査（In-order）

```ruby
def inorder_traversal(root)
  result = []
  
  def dfs(node, result)
    return if node.nil?
    
    dfs(node.left, result)   # 左
    result << node.val       # ルート
    dfs(node.right, result)  # 右
  end
  
  dfs(root, result)
  result
end
```

### 後順走査（Post-order）

```ruby
def postorder_traversal(root)
  result = []
  
  def dfs(node, result)
    return if node.nil?
    
    dfs(node.left, result)   # 左
    dfs(node.right, result)  # 右
    result << node.val       # ルート
  end
  
  dfs(root, result)
  result
end
```

### 問題2: 二分木の最大深さ（DFS版）

```ruby
def max_depth(root)
  return 0 if root.nil?
  
  left_depth = max_depth(root.left)
  right_depth = max_depth(root.right)
  
  [left_depth, right_depth].max + 1
end
```

### 問題3: 二分木の最小深さ

```ruby
def min_depth(root)
  return 0 if root.nil?
  return 1 if root.left.nil? && root.right.nil?
  
  left_depth = root.left ? min_depth(root.left) : Float::INFINITY
  right_depth = root.right ? min_depth(root.right) : Float::INFINITY
  
  [left_depth, right_depth].min + 1
end
```

## 二分探索木（BST）

### BST の検索

```ruby
def search_bst(root, val)
  return nil if root.nil?
  return root if root.val == val
  
  if val < root.val
    search_bst(root.left, val)
  else
    search_bst(root.right, val)
  end
end
```

### BST への挿入

```ruby
def insert_into_bst(root, val)
  return TreeNode.new(val) if root.nil?
  
  if val < root.val
    root.left = insert_into_bst(root.left, val)
  else
    root.right = insert_into_bst(root.right, val)
  end
  
  root
end
```

### BST の検証

```ruby
def is_valid_bst(root, min_val = -Float::INFINITY, max_val = Float::INFINITY)
  return true if root.nil?
  
  # 現在のノードの値が範囲内かチェック
  return false if root.val <= min_val || root.val >= max_val
  
  # 左部分木と右部分木を再帰的にチェック
  is_valid_bst(root.left, min_val, root.val) &&
    is_valid_bst(root.right, root.val, max_val)
end
```

## 二分木の再構築

### 問題4: 前順と中順から二分木を構築

```ruby
def build_tree(preorder, inorder)
  return nil if preorder.empty?
  
  # 前順の最初の要素がルート
  root_val = preorder[0]
  root = TreeNode.new(root_val)
  
  # 中順でルートの位置を見つける
  root_idx = inorder.index(root_val)
  
  # 左部分木と右部分木を再帰的に構築
  root.left = build_tree(
    preorder[1..root_idx],
    inorder[0...root_idx]
  )
  root.right = build_tree(
    preorder[root_idx + 1..-1],
    inorder[root_idx + 1..-1]
  )
  
  root
end
```

## 二分木のシリアライズとデシリアライズ

```ruby
def serialize(root)
  result = []
  
  def dfs(node, result)
    if node.nil?
      result << "null"
      return
    end
    
    result << node.val.to_s
    dfs(node.left, result)
    dfs(node.right, result)
  end
  
  dfs(root, result)
  result.join(",")
end

def deserialize(data)
  values = data.split(",")
  index = [0]
  
  def dfs(values, index)
    return nil if values[index[0]] == "null"
    
    node = TreeNode.new(values[index[0]].to_i)
    index[0] += 1
    
    node.left = dfs(values, index)
    index[0] += 1
    
    node.right = dfs(values, index)
    
    node
  end
  
  dfs(values, index)
end
```

## まとめ

このセクションでは、二分木の基本操作を学びました。

重要なポイントは以下の通りです。

- BFS はレベル順走査に使用し、キューを使って実装します
- DFS は前順・中順・後順の3種類があり、再帰で実装します
- 二分探索木は、効率的な検索・挿入・削除が可能です
- 木の走査は、多くの問題の基礎となります
- 再帰的な思考が、木構造の問題解決に重要です

二分木は、ファイルシステム、データベースのインデックス、構文解析など、多くの実用的なアプリケーションで使用されます。
