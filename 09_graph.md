# グラフ

## 概要

このセクションでは、グラフ（Graph）について学びます。グラフはノード（頂点）とエッジ（辺）で構成されるデータ構造で、ネットワーク、経路探索、ソーシャルグラフなど多くの実世界の問題をモデル化できます。

## グラフの導入

### グラフとは

グラフは頂点（Vertex）の集合と、それらを接続する辺（Edge）の集合から構成されるデータ構造です。

### グラフの表現方法

#### 隣接リスト

```ruby
# ハッシュで表現
graph = {
  0 => [1, 2],
  1 => [0, 3, 4],
  2 => [0],
  3 => [1],
  4 => [1]
}

# または配列で表現
graph = [
  [1, 2],       # 頂点0の隣接リスト
  [0, 3, 4],    # 頂点1の隣接リスト
  [0],          # 頂点2の隣接リスト
  [1],          # 頂点3の隣接リスト
  [1]           # 頂点4の隣接リスト
]
```

#### 隣接行列

```ruby
# n x n の行列
graph = [
  [0, 1, 1, 0, 0],
  [1, 0, 0, 1, 1],
  [1, 0, 0, 0, 0],
  [0, 1, 0, 0, 0],
  [0, 1, 0, 0, 0]
]
```

## BFS（幅優先探索）

### 基本的なBFS

```ruby
def bfs(graph, start)
  visited = Set.new
  queue = [start]
  visited.add(start)
  result = []
  
  while !queue.empty?
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

# テストケース
graph = {
  0 => [1, 2],
  1 => [0, 3, 4],
  2 => [0],
  3 => [1],
  4 => [1]
}

p bfs(graph, 0)  # => [0, 1, 2, 3, 4]
```

### 問題1: 最短経路の長さ

```ruby
def shortest_path_length(graph, start, end_node)
  return 0 if start == end_node
  
  visited = Set.new([start])
  queue = [[start, 0]]  # [ノード, 距離]
  
  while !queue.empty?
    node, dist = queue.shift
    
    graph[node].each do |neighbor|
      return dist + 1 if neighbor == end_node
      
      unless visited.include?(neighbor)
        visited.add(neighbor)
        queue << [neighbor, dist + 1]
      end
    end
  end
  
  -1  # 到達不可能
end
```

## DFS（深さ優先探索）

### 基本的なDFS（再帰版）

```ruby
def dfs_recursive(graph, start, visited = Set.new, result = [])
  visited.add(start)
  result << start
  
  graph[start].each do |neighbor|
    unless visited.include?(neighbor)
      dfs_recursive(graph, neighbor, visited, result)
    end
  end
  
  result
end
```

### 基本的なDFS（反復版）

```ruby
def dfs_iterative(graph, start)
  visited = Set.new
  stack = [start]
  result = []
  
  while !stack.empty?
    node = stack.pop
    
    unless visited.include?(node)
      visited.add(node)
      result << node
      
      graph[node].each do |neighbor|
        stack << neighbor unless visited.include?(neighbor)
      end
    end
  end
  
  result
end
```

### 問題2: パスの存在確認

```ruby
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
```

## 二次元配列でのグラフ探索

### 問題3: 島の数（Number of Islands）

```ruby
def num_islands(grid)
  return 0 if grid.empty?
  
  rows = grid.length
  cols = grid[0].length
  count = 0
  
  def dfs(grid, i, j)
    return if i < 0 || i >= grid.length ||
              j < 0 || j >= grid[0].length ||
              grid[i][j] == '0'
    
    # 訪問済みとしてマーク
    grid[i][j] = '0'
    
    # 上下左右を探索
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

# テストケース
grid = [
  ['1','1','0','0','0'],
  ['1','1','0','0','0'],
  ['0','0','1','0','0'],
  ['0','0','0','1','1']
]

puts num_islands(grid)  # => 3
```

## ダイクストラ法（最短経路アルゴリズム）

```ruby
def dijkstra(graph, start)
  distances = Hash.new(Float::INFINITY)
  distances[start] = 0
  
  # 優先度付きキュー（最小ヒープ）
  pq = [[0, start]]  # [距離, ノード]
  
  while !pq.empty?
    pq.sort_by! { |dist, _| dist }
    current_dist, node = pq.shift
    
    next if current_dist > distances[node]
    
    graph[node].each do |neighbor, weight|
      distance = current_dist + weight
      
      if distance < distances[neighbor]
        distances[neighbor] = distance
        pq << [distance, neighbor]
      end
    end
  end
  
  distances
end

# 使用例（重み付きグラフ）
graph = {
  'A' => [['B', 4], ['C', 2]],
  'B' => [['A', 4], ['C', 1], ['D', 5]],
  'C' => [['A', 2], ['B', 1], ['D', 8]],
  'D' => [['B', 5], ['C', 8]]
}

p dijkstra(graph, 'A')
# => {"A"=>0, "C"=>2, "B"=>3, "D"=>8}
```

## トポロジカルソート

### DFSを使用したトポロジカルソート

```ruby
def topological_sort(graph)
  visited = Set.new
  stack = []
  
  def dfs(node, graph, visited, stack)
    return if visited.include?(node)
    
    visited.add(node)
    
    graph[node].each do |neighbor|
      dfs(neighbor, graph, visited, stack)
    end
    
    stack.unshift(node)
  end
  
  graph.keys.each do |node|
    dfs(node, graph, visited, stack)
  end
  
  stack
end

# 使用例（有向非巡回グラフ）
graph = {
  0 => [1, 2],
  1 => [3],
  2 => [3],
  3 => []
}

p topological_sort(graph)  # => [0, 2, 1, 3] など
```

### カーンのアルゴリズム（BFS版）

```ruby
def topological_sort_kahn(graph)
  # 入次数を計算
  in_degree = Hash.new(0)
  graph.each do |node, neighbors|
    in_degree[node] ||= 0
    neighbors.each { |neighbor| in_degree[neighbor] += 1 }
  end
  
  # 入次数0のノードをキューに追加
  queue = in_degree.select { |_, degree| degree == 0 }.keys
  result = []
  
  while !queue.empty?
    node = queue.shift
    result << node
    
    graph[node].each do |neighbor|
      in_degree[neighbor] -= 1
      queue << neighbor if in_degree[neighbor] == 0
    end
  end
  
  result
end
```

## Union-Find（素集合データ構造）

```ruby
class UnionFind
  def initialize(n)
    @parent = (0...n).to_a
    @rank = Array.new(n, 0)
  end
  
  def find(x)
    if @parent[x] != x
      @parent[x] = find(@parent[x])  # 経路圧縮
    end
    @parent[x]
  end
  
  def union(x, y)
    root_x = find(x)
    root_y = find(y)
    
    return if root_x == root_y
    
    # ランクによる結合
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

# 使用例
uf = UnionFind.new(5)
uf.union(0, 1)
uf.union(1, 2)
puts uf.connected?(0, 2)  # => true
puts uf.connected?(0, 3)  # => false
```

## まとめ

このセクションでは、グラフアルゴリズムの基礎を学びました。

重要なポイントは以下の通りです。

- BFS は最短経路の探索に適しています
- DFS は経路の存在確認や連結成分の検出に使用します
- 二次元配列もグラフとして扱えます
- ダイクストラ法は重み付きグラフの最短経路を求めます
- トポロジカルソートは依存関係のある問題に使用します
- Union-Find は集合の管理と結合判定に効率的です

グラフは、ソーシャルネットワーク、経路探索、スケジューリング、ネットワークフローなど、多くの実世界の問題をモデル化できる強力なデータ構造です。
