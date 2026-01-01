#!/usr/bin/env ruby
# frozen_string_literal: true

def bfs(graph, start)
  visited = Set.new
  queue = [start]
  visited.add(start)
  result = []

  until queue.empty?
    node = queue.shift
    result << node

    graph[node].each do |neighbor|
      unless visited.include?(neighbor)
        visited.add(neighbor)
        queue << neighbor
      end
    end
  end

  result
end

def shortest_path_length(graph, start, end_node)
  return 0 if start == end_node

  visited = Set.new([start])
  queue = [[start, 0]]

  until queue.empty?
    node, dist = queue.shift

    graph[node].each do |neighbor|
      return dist + 1 if neighbor == end_node

      unless visited.include?(neighbor)
        visited.add(neighbor)
        queue << [neighbor, dist + 1]
      end
    end
  end

  -1
end

def dfs_recursive(graph, start, visited = Set.new, result = [])
  visited.add(start)
  result << start

  graph[start].each do |neighbor|
    dfs_recursive(graph, neighbor, visited, result) unless visited.include?(neighbor)
  end

  result
end

def dfs_iterative(graph, start)
  visited = Set.new
  stack = [start]
  result = []

  until stack.empty?
    node = stack.pop

    next if visited.include?(node)

    visited.add(node)
    result << node

    graph[node].each do |neighbor|
      stack << neighbor unless visited.include?(neighbor)
    end
  end

  result
end

def has_path(graph, start, end_node)
  return true if start == end_node

  visited = Set.new

  def dfs(graph, node, end_node, visited)
    return true if node == end_node
    return false if visited.include?(node)

    visited.add(node)

    graph[node].each do |neighbor|
      return true if dfs(graph, neighbor, end_node, visited)
    end

    false
  end

  dfs(graph, start, end_node, visited)
end

def num_islands(grid)
  return 0 if grid.empty?

  rows = grid.length
  cols = grid[0].length
  count = 0

  def dfs(grid, i, j)
    return if i < 0 || i >= grid.length ||
              j < 0 || j >= grid[0].length ||
              grid[i][j] == '0'

    grid[i][j] = '0'

    dfs(grid, i + 1, j)
    dfs(grid, i - 1, j)
    dfs(grid, i, j + 1)
    dfs(grid, i, j - 1)
  end

  (0...rows).each do |i|
    (0...cols).each do |j|
      if grid[i][j] == '1'
        count += 1
        dfs(grid, i, j)
      end
    end
  end

  count
end

class UnionFind
  def initialize(n)
    @parent = (0...n).to_a
    @rank = Array.new(n, 0)
  end

  def find(x)
    @parent[x] = find(@parent[x]) if @parent[x] != x
    @parent[x]
  end

  def union(x, y)
    root_x = find(x)
    root_y = find(y)

    return if root_x == root_y

    if @rank[root_x] < @rank[root_y]
      @parent[root_x] = root_y
    elsif @rank[root_x] > @rank[root_y]
      @parent[root_y] = root_x
    else
      @parent[root_y] = root_x
      @rank[root_x] += 1
    end
  end

  def connected?(x, y)
    find(x) == find(y)
  end
end

if __FILE__ == $PROGRAM_NAME
  puts '=== グラフ テスト ==='
  puts

  graph = {
    0 => [1, 2],
    1 => [0, 3, 4],
    2 => [0],
    3 => [1],
    4 => [1]
  }

  puts 'Test 1: bfs(graph, 0)'
  result1 = bfs(graph, 0)
  puts "結果: #{result1}"
  puts "判定: #{result1 == [0, 1, 2, 3, 4] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts 'Test 2: shortest_path_length(graph, 0, 4)'
  result2 = shortest_path_length(graph, 0, 4)
  puts "結果: #{result2}"
  puts "判定: #{result2 == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  grid = [
    ['1', '1', '0', '0', '0'],
    ['1', '1', '0', '0', '0'],
    ['0', '0', '1', '0', '0'],
    ['0', '0', '0', '1', '1']
  ]

  puts 'Test 3: num_islands(grid)'
  result3 = num_islands(grid)
  puts "結果: #{result3}"
  puts "判定: #{result3 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  uf = UnionFind.new(5)
  uf.union(0, 1)
  uf.union(1, 2)

  puts 'Test 4: UnionFind.connected?(0, 2)'
  result4 = uf.connected?(0, 2)
  puts "結果: #{result4}"
  puts "判定: #{result4 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts 'Test 5: UnionFind.connected?(0, 3)'
  result5 = uf.connected?(0, 3)
  puts "結果: #{result5}"
  puts "判定: #{result5 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
