# 配列と文字列 - 基礎（2D行列）

## 概要

このセクションでは、2次元配列（行列）の操作と走査パターンを学びます。行列の回転、転置、スパイラル走査など、実務でよく使われるパターンを理解します。

---

## 問題1: 行列の転置

### 問題文

m × n の行列が与えられます。転置行列を返してください。転置とは、行と列を入れ替えることです。

**入力例:**

```text
[[1, 2, 3],
 [4, 5, 6]]
```

**出力例:**

```text
[[1, 4],
 [2, 5],
 [3, 6]]
```

### アルゴリズム概説

元の行列のi行j列の要素は、転置行列ではj行i列になります。

**時間計算量:** O(m × n)  
**空間計算量:** O(m × n) - 新しい行列を作成

### 擬似コード

```text
関数 transpose(行列):
    m = 行数
    n = 列数
    
    結果 = n行m列の新しい行列
    
    各行iについて:
        各列jについて:
            結果[j][i] = 行列[i][j]
    
    結果を返す
```

### 解答

```ruby
# 解法1: 基本的な転置
def transpose(matrix)
  m = matrix.length
  n = matrix[0].length
  
  result = Array.new(n) { Array.new(m) }
  
  m.times do |i|
    n.times do |j|
      result[j][i] = matrix[i][j]
    end
  end
  
  result
end

# 解法2: Rubyのtransposeメソッドを使用
def transpose_builtin(matrix)
  matrix.transpose
end

# 解法3: mapを使用
def transpose_map(matrix)
  matrix[0].length.times.map do |col|
    matrix.map { |row| row[col] }
  end
end

# 解法4: zipを使用
def transpose_zip(matrix)
  matrix[0].zip(*matrix[1..-1])
end

# テストケース
p transpose([[1, 2, 3], [4, 5, 6]])
# => [[1, 4], [2, 5], [3, 6]]

p transpose([[1, 2], [3, 4], [5, 6]])
# => [[1, 3, 5], [2, 4, 6]]

p transpose([[1]])
# => [[1]]
```

---

## 問題2: 90度回転

### 問題文

n × n の正方行列が与えられます。時計回りに90度回転させてください。回転はin-placeで行ってください。

**入力例:**

```text
[[1, 2, 3],
 [4, 5, 6],
 [7, 8, 9]]
```

**出力例:**

```text
[[7, 4, 1],
 [8, 5, 2],
 [9, 6, 3]]
```

### アルゴリズム概説

時計回りに90度回転するには、まず転置し、次に各行を反転させます。または、4つの要素を一度に回転させる方法もあります。

**時間計算量:** O(n²)  
**空間計算量:** O(1) - in-place

### 擬似コード

```text
関数 rotate_90(行列):
    n = 行列のサイズ
    
    # 転置
    各行iについて（0からn-1まで）:
        各列jについて（i+1からn-1まで）:
            行列[i][j] と 行列[j][i] を交換
    
    # 各行を反転
    各行について:
        行を反転
    
    行列を返す
```

### 解答

```ruby
# 解法1: 転置してから各行を反転
def rotate_90(matrix)
  n = matrix.length
  
  # 転置
  (n - 1).times do |i|
    (i + 1...n).each do |j|
      matrix[i][j], matrix[j][i] = matrix[j][i], matrix[i][j]
    end
  end
  
  # 各行を反転
  matrix.each { |row| row.reverse! }
  
  matrix
end

# 解法2: 4つの要素を一度に回転
def rotate_90_four_way(matrix)
  n = matrix.length
  
  (n / 2).times do |i|
    (i...n - i - 1).each do |j|
      temp = matrix[i][j]
      
      # 左から上へ
      matrix[i][j] = matrix[n - j - 1][i]
      
      # 下から左へ
      matrix[n - j - 1][i] = matrix[n - i - 1][n - j - 1]
      
      # 右から下へ
      matrix[n - i - 1][n - j - 1] = matrix[j][n - i - 1]
      
      # 上から右へ
      matrix[j][n - i - 1] = temp
    end
  end
  
  matrix
end

# 解法3: 新しい配列を作成（in-placeではない）
def rotate_90_new_array(matrix)
  n = matrix.length
  
  Array.new(n) do |i|
    Array.new(n) { |j| matrix[n - j - 1][i] }
  end
end

# テストケース
p rotate_90([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
# => [[7, 4, 1], [8, 5, 2], [9, 6, 3]]

p rotate_90([[1, 2], [3, 4]])
# => [[3, 1], [4, 2]]
```

---

## 問題3: スパイラル順序で走査

### 問題文

m × n の行列が与えられます。スパイラル順序（渦巻き状）ですべての要素を返してください。

**入力例:**

```text
[[1, 2, 3],
 [4, 5, 6],
 [7, 8, 9]]
```

**出力例:**

```text
[1, 2, 3, 6, 9, 8, 7, 4, 5]
```

### アルゴリズム概説

4つの境界（上、下、左、右）を維持し、外側から内側へ順に走査します。各層で右→下→左→上の順に進みます。

**時間計算量:** O(m × n)  
**空間計算量:** O(1) - 結果配列を除く

### 擬似コード

```text
関数 spiral_order(行列):
    結果 = 空配列
    上 = 0, 下 = m - 1
    左 = 0, 右 = n - 1
    
    上 <= 下 かつ 左 <= 右 の間:
        # 右へ移動
        左から右まで上の行の要素を追加
        上 += 1
        
        # 下へ移動
        上から下まで右の列の要素を追加
        右 -= 1
        
        もし 上 <= 下 なら:
            # 左へ移動
            右から左まで下の行の要素を追加
            下 -= 1
        
        もし 左 <= 右 なら:
            # 上へ移動
            下から上まで左の列の要素を追加
            左 += 1
    
    結果を返す
```

### 解答

```ruby
# 解法1: 4つの境界を使用
def spiral_order(matrix)
  return [] if matrix.empty?
  
  result = []
  top = 0
  bottom = matrix.length - 1
  left = 0
  right = matrix[0].length - 1
  
  while top <= bottom && left <= right
    # 右へ移動
    (left..right).each { |j| result << matrix[top][j] }
    top += 1
    
    # 下へ移動
    (top..bottom).each { |i| result << matrix[i][right] }
    right -= 1
    
    if top <= bottom
      # 左へ移動
      right.downto(left).each { |j| result << matrix[bottom][j] }
      bottom -= 1
    end
    
    if left <= right
      # 上へ移動
      bottom.downto(top).each { |i| result << matrix[i][left] }
      left += 1
    end
  end
  
  result
end

# 解法2: 方向ベクトルを使用
def spiral_order_direction(matrix)
  return [] if matrix.empty?
  
  m, n = matrix.length, matrix[0].length
  result = []
  visited = Array.new(m) { Array.new(n, false) }
  
  # 右、下、左、上
  directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]
  dir_idx = 0
  
  row, col = 0, 0
  
  (m * n).times do
    result << matrix[row][col]
    visited[row][col] = true
    
    # 次の位置を計算
    next_row = row + directions[dir_idx][0]
    next_col = col + directions[dir_idx][1]
    
    # 方向転換が必要か確認
    if next_row < 0 || next_row >= m || next_col < 0 || next_col >= n || visited[next_row][next_col]
      dir_idx = (dir_idx + 1) % 4
      next_row = row + directions[dir_idx][0]
      next_col = col + directions[dir_idx][1]
    end
    
    row, col = next_row, next_col
  end
  
  result
end

# テストケース
p spiral_order([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
# => [1, 2, 3, 6, 9, 8, 7, 4, 5]

p spiral_order([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
# => [1, 2, 3, 4, 8, 12, 11, 10, 9, 5, 6, 7]
```

---

## 問題4: 行列のゼロ設定

### 問題文

m × n の行列が与えられます。要素が0の場合、その行と列のすべての要素を0に設定してください。in-placeで行う必要があります。

**入力例:**

```text
[[1, 1, 1],
 [1, 0, 1],
 [1, 1, 1]]
```

**出力例:**

```text
[[1, 0, 1],
 [0, 0, 0],
 [1, 0, 1]]
```

### アルゴリズム概説

最初に0の位置を記録し、その後で該当する行と列を0で埋めます。最初の行と列を記録用に使うことで、O(1)の空間で実現できます。

**時間計算量:** O(m × n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 set_zeroes(行列):
    # 最初の行と列に0があるか記録
    first_row_zero = 最初の行に0があるか
    first_col_zero = 最初の列に0があるか
    
    # 残りの要素で0を探し、最初の行・列に記録
    各セル(i, j)について（1から開始）:
        もし 行列[i][j] == 0 なら:
            行列[i][0] = 0
            行列[0][j] = 0
    
    # 記録を基に0を設定
    各セル(i, j)について（1から開始）:
        もし 行列[i][0] == 0 または 行列[0][j] == 0 なら:
            行列[i][j] = 0
    
    # 最初の行と列を処理
    もし first_row_zero なら最初の行を0で埋める
    もし first_col_zero なら最初の列を0で埋める
```

### 解答

```ruby
# 解法1: O(1)空間 - 最初の行と列を記録用に使用
def set_zeroes(matrix)
  m = matrix.length
  n = matrix[0].length
  
  # 最初の行と列に0があるか確認
  first_row_zero = matrix[0].any?(&:zero?)
  first_col_zero = matrix.any? { |row| row[0].zero? }
  
  # 残りの要素で0を探し、最初の行・列に記録
  (1...m).each do |i|
    (1...n).each do |j|
      if matrix[i][j].zero?
        matrix[i][0] = 0
        matrix[0][j] = 0
      end
    end
  end
  
  # 記録を基に0を設定
  (1...m).each do |i|
    (1...n).each do |j|
      matrix[i][j] = 0 if matrix[i][0].zero? || matrix[0][j].zero?
    end
  end
  
  # 最初の行と列を処理
  matrix[0].fill(0) if first_row_zero
  matrix.each { |row| row[0] = 0 } if first_col_zero
  
  matrix
end

# 解法2: O(m + n)空間 - セットを使用
def set_zeroes_set(matrix)
  m = matrix.length
  n = matrix[0].length
  
  zero_rows = Set.new
  zero_cols = Set.new
  
  # 0の位置を記録
  m.times do |i|
    n.times do |j|
      if matrix[i][j].zero?
        zero_rows << i
        zero_cols << j
      end
    end
  end
  
  # 0を設定
  m.times do |i|
    n.times do |j|
      matrix[i][j] = 0 if zero_rows.include?(i) || zero_cols.include?(j)
    end
  end
  
  matrix
end

# テストケース
p set_zeroes([[1, 1, 1], [1, 0, 1], [1, 1, 1]])
# => [[1, 0, 1], [0, 0, 0], [1, 0, 1]]

p set_zeroes([[0, 1, 2, 0], [3, 4, 5, 2], [1, 3, 1, 5]])
# => [[0, 0, 0, 0], [0, 4, 5, 0], [0, 3, 1, 0]]
```

---

## 問題5: 2D行列の検索

### 問題文

各行が左から右へソートされ、各列が上から下へソートされている m × n の行列が与えられます。ターゲット値が存在するか判定してください。

**入力例:**

```text
matrix = [[1,  4,  7,  11, 15],
          [2,  5,  8,  12, 19],
          [3,  6,  9,  16, 22],
          [10, 13, 14, 17, 24],
          [18, 21, 23, 26, 30]]
target = 5
```

**出力例:**

```text
true
```

### アルゴリズム概説

右上または左下から開始し、ターゲットとの比較に基づいて行または列を除外していきます。

**時間計算量:** O(m + n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 search_matrix(行列, ターゲット):
    行 = 0
    列 = n - 1  # 右上から開始
    
    行 < m かつ 列 >= 0 の間:
        もし 行列[行][列] == ターゲット なら:
            true を返す
        もし 行列[行][列] > ターゲット なら:
            列 -= 1  # 左へ移動
        そうでなければ:
            行 += 1  # 下へ移動
    
    false を返す
```

### 解答

```ruby
# 解法1: 右上から検索
def search_matrix(matrix, target)
  return false if matrix.empty? || matrix[0].empty?
  
  row = 0
  col = matrix[0].length - 1
  
  while row < matrix.length && col >= 0
    current = matrix[row][col]
    
    return true if current == target
    
    if current > target
      col -= 1  # 左へ移動
    else
      row += 1  # 下へ移動
    end
  end
  
  false
end

# 解法2: 左下から検索
def search_matrix_bottom_left(matrix, target)
  return false if matrix.empty? || matrix[0].empty?
  
  row = matrix.length - 1
  col = 0
  
  while row >= 0 && col < matrix[0].length
    current = matrix[row][col]
    
    return true if current == target
    
    if current > target
      row -= 1  # 上へ移動
    else
      col += 1  # 右へ移動
    end
  end
  
  false
end

# 解法3: 各行で二分探索（O(m log n)）
def search_matrix_binary(matrix, target)
  matrix.any? do |row|
    row.bsearch { |x| x >= target } == target
  end
end

# テストケース
matrix = [[1, 4, 7, 11, 15],
          [2, 5, 8, 12, 19],
          [3, 6, 9, 16, 22],
          [10, 13, 14, 17, 24],
          [18, 21, 23, 26, 30]]

p search_matrix(matrix, 5)   # => true
p search_matrix(matrix, 20)  # => false
p search_matrix(matrix, 30)  # => true
```

---

## 問題6: 対角線走査

### 問題文

m × n の行列が与えられます。対角線順序ですべての要素を返してください。

**入力例:**

```text
[[1, 2, 3],
 [4, 5, 6],
 [7, 8, 9]]
```

**出力例:**

```text
[1, 2, 4, 7, 5, 3, 6, 8, 9]
```

### アルゴリズム概説

対角線ごとに要素を収集します。対角線の方向は上向きと下向きを交互に変えます。

**時間計算量:** O(m × n)  
**空間計算量:** O(1) - 結果配列を除く

### 擬似コード

```text
関数 find_diagonal_order(行列):
    結果 = 空配列
    上向き = true
    
    各対角線について:
        対角線の要素を収集
        
        もし 上向き なら:
            要素を逆順で追加
        そうでなければ:
            要素をそのまま追加
        
        上向きを反転
    
    結果を返す
```

### 解答

```ruby
# 解法1: 対角線ごとに処理
def find_diagonal_order(matrix)
  return [] if matrix.empty?
  
  m = matrix.length
  n = matrix[0].length
  result = []
  
  # 対角線の数は m + n - 1
  (m + n - 1).times do |d|
    diagonal = []
    
    # 対角線上の要素を収集
    row = [d, m - 1].min
    col = d - row
    
    while row >= 0 && col < n
      diagonal << matrix[row][col]
      row -= 1
      col += 1
    end
    
    # 偶数番目の対角線は逆順
    diagonal.reverse! if d.even?
    
    result.concat(diagonal)
  end
  
  result
end

# 解法2: 方向ベクトルを使用
def find_diagonal_order_vector(matrix)
  return [] if matrix.empty?
  
  m, n = matrix.length, matrix[0].length
  result = []
  row, col = 0, 0
  going_up = true
  
  (m * n).times do
    result << matrix[row][col]
    
    if going_up
      if col == n - 1
        row += 1
        going_up = false
      elsif row == 0
        col += 1
        going_up = false
      else
        row -= 1
        col += 1
      end
    else
      if row == m - 1
        col += 1
        going_up = true
      elsif col == 0
        row += 1
        going_up = true
      else
        row += 1
        col -= 1
      end
    end
  end
  
  result
end

# テストケース
p find_diagonal_order([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
# => [1, 2, 4, 7, 5, 3, 6, 8, 9]

p find_diagonal_order([[1, 2], [3, 4]])
# => [1, 2, 3, 4]
```

---

## 問題7: 行列の積

### 問題文

2つの行列 A (m × k) と B (k × n) が与えられます。行列の積 C = A × B を計算してください。

**入力例:**

```text
A = [[1, 2, 3],
     [4, 5, 6]]

B = [[7, 8],
     [9, 10],
     [11, 12]]
```

**出力例:**

```text
[[58, 64],
 [139, 154]]
```

### アルゴリズム概説

結果の行列 `C[i][j]` は、A の i 行と B の j 列の内積です。

**時間計算量:** O(m × k × n)  
**空間計算量:** O(m × n)

### 擬似コード

```text
関数 matrix_multiply(A, B):
    m = Aの行数
    k = Aの列数（Bの行数）
    n = Bの列数
    
    C = m行n列の新しい行列（0で初期化）
    
    各行iについて:
        各列jについて:
            各kについて:
                C[i][j] += A[i][k] * B[k][j]
    
    Cを返す
```

### 解答

```ruby
# 解法1: 基本的な行列の積
def matrix_multiply(a, b)
  m = a.length
  k = a[0].length
  n = b[0].length
  
  c = Array.new(m) { Array.new(n, 0) }
  
  m.times do |i|
    n.times do |j|
      k.times do |p|
        c[i][j] += a[i][p] * b[p][j]
      end
    end
  end
  
  c
end

# 解法2: zipとreduceを使用
def matrix_multiply_functional(a, b)
  b_t = b.transpose
  
  a.map do |row_a|
    b_t.map do |col_b|
      row_a.zip(col_b).map { |x, y| x * y }.sum
    end
  end
end

# 解法3: 疎行列の積（0が多い場合に最適）
def matrix_multiply_sparse(a, b)
  m = a.length
  k = a[0].length
  n = b[0].length
  
  c = Array.new(m) { Array.new(n, 0) }
  
  m.times do |i|
    k.times do |p|
      next if a[i][p].zero?  # 0なら計算をスキップ
      
      n.times do |j|
        c[i][j] += a[i][p] * b[p][j]
      end
    end
  end
  
  c
end

# テストケース
a = [[1, 2, 3], [4, 5, 6]]
b = [[7, 8], [9, 10], [11, 12]]

p matrix_multiply(a, b)
# => [[58, 64], [139, 154]]

p matrix_multiply([[1, 2], [3, 4]], [[2, 0], [1, 2]])
# => [[4, 4], [10, 8]]
```

---

## 問題8: 島の数

### 問題文

'1'（陸地）と'0'（水）からなる 2D グリッドが与えられます。島の数を数えてください。島は水平または垂直に接続された陸地で構成されます。

**入力例:**

```text
[['1','1','0','0','0'],
 ['1','1','0','0','0'],
 ['0','0','1','0','0'],
 ['0','0','0','1','1']]
```

**出力例:**

```text
3
```

### アルゴリズム概説

DFS または BFS を使用して、訪問済みの陸地をマークしながら、新しい島を数えます。

**時間計算量:** O(m × n)  
**空間計算量:** O(m × n) - 再帰スタックまたは訪問済み配列

### 擬似コード

```text
関数 num_islands(グリッド):
    島の数 = 0
    
    各セル(i, j)について:
        もし グリッド[i][j] == '1' なら:
            島の数 += 1
            dfs(グリッド, i, j)  # この島全体をマーク
    
    島の数を返す

関数 dfs(グリッド, i, j):
    もし 範囲外 または グリッド[i][j] != '1' なら:
        return
    
    グリッド[i][j] = '0'  # 訪問済みとしてマーク
    
    # 4方向を探索
    dfs(グリッド, i-1, j)
    dfs(グリッド, i+1, j)
    dfs(グリッド, i, j-1)
    dfs(グリッド, i, j+1)
```

### 解答

```ruby
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
      ni, nj = i + di, j + dj
      
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

# テストケース
grid1 = [
  ['1','1','0','0','0'],
  ['1','1','0','0','0'],
  ['0','0','1','0','0'],
  ['0','0','0','1','1']
]

p num_islands(grid1.map(&:dup))  # => 3

grid2 = [
  ['1','1','1','1','0'],
  ['1','1','0','1','0'],
  ['1','1','0','0','0'],
  ['0','0','0','0','0']
]

p num_islands(grid2.map(&:dup))  # => 1
```

---

## まとめ

このセクションでは、2次元配列の様々な操作パターンを学びました。

重要なポイントは以下の通りです。

1. 転置は行と列を入れ替える基本操作です
2. 回転は転置と反転の組み合わせで実現できます
3. スパイラル走査は境界を管理することが重要です
4. 行列の0設定では最初の行・列を記録用に使うとO(1)空間で実現できます
5. ソート済み行列の検索は右上または左下から開始すると効率的です
6. 2D グリッド上のDFS/BFSは多くの問題に応用できます

これらのパターンは、画像処理、ゲーム開発、グラフ問題など、多くの実務で使用されます。
