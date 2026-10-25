#!/usr/bin/env ruby
# frozen_string_literal: true

# docs:begin TreeNode
class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end
# docs:end

# docs:begin level_order
def level_order(root)
  return [] if root.nil?

  result = []
  queue = [root]

  until queue.empty?
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

p level_order(root) # => [[3], [9, 20], [15, 7]]
# docs:end

# docs:begin max_depth_bfs
def max_depth_bfs(root)
  return 0 if root.nil?

  depth = 0
  queue = [root]

  until queue.empty?
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
# docs:end

# docs:begin preorder_traversal
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
# docs:end

# docs:begin inorder_traversal
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
# docs:end

# docs:begin postorder_traversal
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
# docs:end

# docs:begin max_depth
def max_depth(root)
  return 0 if root.nil?

  left_depth = max_depth(root.left)
  right_depth = max_depth(root.right)

  [left_depth, right_depth].max + 1
end
# docs:end

# docs:begin min_depth
def min_depth(root)
  return 0 if root.nil?
  return 1 if root.left.nil? && root.right.nil?

  left_depth = root.left ? min_depth(root.left) : Float::INFINITY
  right_depth = root.right ? min_depth(root.right) : Float::INFINITY

  [left_depth, right_depth].min + 1
end
# docs:end

# docs:begin search_bst
def search_bst(root, val)
  return nil if root.nil?
  return root if root.val == val

  if val < root.val
    search_bst(root.left, val)
  else
    search_bst(root.right, val)
  end
end
# docs:end

# docs:begin insert_into_bst
def insert_into_bst(root, val)
  return TreeNode.new(val) if root.nil?

  if val < root.val
    root.left = insert_into_bst(root.left, val)
  else
    root.right = insert_into_bst(root.right, val)
  end

  root
end
# docs:end

# docs:begin is_valid_bst
def is_valid_bst(root, min_val = -Float::INFINITY, max_val = Float::INFINITY)
  return true if root.nil?

  # 現在のノードの値が範囲内かチェック
  return false if root.val <= min_val || root.val >= max_val

  # 左部分木と右部分木を再帰的にチェック
  is_valid_bst(root.left, min_val, root.val) &&
    is_valid_bst(root.right, root.val, max_val)
end
# docs:end

# docs:begin build_tree
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
    preorder[(root_idx + 1)..],
    inorder[(root_idx + 1)..]
  )

  root
end
# docs:end

if __FILE__ == $PROGRAM_NAME
  puts '=== 二分木 テスト ==='
  puts

  root = TreeNode.new(3)
  root.left = TreeNode.new(9)
  root.right = TreeNode.new(20)
  root.right.left = TreeNode.new(15)
  root.right.right = TreeNode.new(7)

  puts 'Test 1: level_order'
  result1 = level_order(root)
  puts "結果: #{result1}"
  puts "判定: #{result1 == [[3], [9, 20], [15, 7]] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts 'Test 2: max_depth'
  result2 = max_depth(root)
  puts "結果: #{result2}"
  puts "判定: #{result2 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts 'Test 3: preorder_traversal'
  result3 = preorder_traversal(root)
  puts "結果: #{result3}"
  puts "判定: #{result3 == [3, 9, 20, 15, 7] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
