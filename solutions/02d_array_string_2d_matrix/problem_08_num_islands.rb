#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 島の数
# ファイル: 02d_array_string_2d_matrix.md
# ============================================================================
#
# '1'（陸地）と'0'（水）からなる 2D グリッドが与えられます。島の数を数えてください。
# 島は水平または垂直に接続された陸地で構成されます。
#
# 入力例:
#   [['1','1','0','0','0'],
#    ['1','1','0','0','0'],
#    ['0','0','1','0','0'],
#    ['0','0','0','1','1']]
#
# 出力例: 3
#
# 時間計算量: O(m × n)
# 空間計算量: O(m × n) - 再帰スタックまたは訪問済み配列
# ============================================================================

# 解法1: DFS（再帰）
def num_islands(grid)
  return 0 if grid.empty?

  count = 0
  m = grid.length
  n = grid[0].length

  m.times do |i|
    n.times do |j|
      if grid[i][j] == '1'
        count += 1
        dfs(grid, i, j)
      end
    end
  end

  count
end

def dfs(grid, i, j)
  m = grid.length
  n = grid[0].length

  # 範囲外または水の場合は終了
  return if i < 0 || i >= m || j < 0 || j >= n || grid[i][j] == '0'

  # 訪問済みとしてマーク
  grid[i][j] = '0'

  # 4方向を探索
  dfs(grid, i - 1, j)  # 上
  dfs(grid, i + 1, j)  # 下
  dfs(grid, i, j - 1)  # 左
  dfs(grid, i, j + 1)  # 右
end

# 解法2: BFS
def num_islands_bfs(grid)
  return 0 if grid.empty?

  count = 0
  m = grid.length
  n = grid[0].length

  m.times do |i|
    n.times do |j|
      if grid[i][j] == '1'
        count += 1
        bfs(grid, i, j)
      end
    end
  end

  count
end

def bfs(grid, start_i, start_j)
  m = grid.length
  n = grid[0].length
  queue = [[start_i, start_j]]
  grid[start_i][start_j] = '0'

  directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]

  until queue.empty?
    i, j = queue.shift

    directions.each do |di, dj|
      ni = i + di
      nj = j + dj

      if ni >= 0 && ni < m && nj >= 0 && nj < n && grid[ni][nj] == '1'
        grid[ni][nj] = '0'
        queue << [ni, nj]
      end
    end
  end
end

# 解法3: Union-Find
class UnionFind
  def initialize(n)
    @parent = (0...n).to_a
    @rank = Array.new(n, 0)
    @count = n
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

    @count -= 1
  end

  attr_reader :count
end

def num_islands_union_find(grid)
  return 0 if grid.empty?

  m = grid.length
  n = grid[0].length

  # 水のセルの数を数える
  water_count = grid.flatten.count('0')

  uf = UnionFind.new(m * n)

  m.times do |i|
    n.times do |j|
      next if grid[i][j] == '0'

      # 右と下のセルと統合
      [[i, j + 1], [i + 1, j]].each do |ni, nj|
        if ni < m && nj < n && grid[ni][nj] == '1'
          uf.union(i * n + j, ni * n + nj)
        end
      end
    end
  end

  uf.count - water_count
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 島の数 テスト ==='
  puts

  # テストケース1: 3つの島
  grid1 = [
    ['1', '1', '0', '0', '0'],
    ['1', '1', '0', '0', '0'],
    ['0', '0', '1', '0', '0'],
    ['0', '0', '0', '1', '1']
  ]
  result1 = num_islands(grid1.map { |row| row.dup })
  puts 'Test 1: num_islands(grid1)'
  puts "結果: #{result1}"
  puts '期待値: 3'
  puts "判定: #{result1 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 1つの島
  grid2 = [
    ['1', '1', '1', '1', '0'],
    ['1', '1', '0', '1', '0'],
    ['1', '1', '0', '0', '0'],
    ['0', '0', '0', '0', '0']
  ]
  result2 = num_islands(grid2.map { |row| row.dup })
  puts 'Test 2: num_islands(grid2)'
  puts "結果: #{result2}"
  puts '期待値: 1'
  puts "判定: #{result2 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 島なし
  grid3 = [
    ['0', '0', '0'],
    ['0', '0', '0']
  ]
  result3 = num_islands(grid3.map { |row| row.dup })
  puts 'Test 3: num_islands(grid3)'
  puts "結果: #{result3}"
  puts '期待値: 0'
  puts "判定: #{result3 == 0 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（BFS）
  puts '--- 解法2（BFS）のテスト ---'
  result4 = num_islands_bfs(grid1.map { |row| row.dup })
  puts "num_islands_bfs(grid1) = #{result4}"
  puts "判定: #{result4 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（Union-Find）
  puts '--- 解法3（Union-Find）のテスト ---'
  result5 = num_islands_union_find(grid1.map { |row| row.dup })
  puts "num_islands_union_find(grid1) = #{result5}"
  puts "判定: #{result5 == 3 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
