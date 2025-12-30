# 再帰呼び出しとバックトラック法 - 詳細問題

## 概要

このセクションでは、再帰とバックトラック法の詳細な問題を扱います。バックトラックは、すべての可能な解を体系的に探索し、条件を満たさない解を早期に枝刈りする手法です。

---

## 問題1: 順列の生成

### 問題文

重複のない整数の配列が与えられます。すべての可能な順列を返してください。

**入力例:**

```text
nums = [1, 2, 3]
```

**出力例:**

```text
[[1,2,3], [1,3,2], [2,1,3], [2,3,1], [3,1,2], [3,2,1]]
```

### アルゴリズム概説

バックトラックを使用して、各位置に使用可能な要素を試し、使用済み要素を追跡します。

**時間計算量:** O(n! × n)  
**空間計算量:** O(n)

### 擬似コード

```text
関数 permute(配列):
    結果 = []
    現在の順列 = []
    使用済み = [false] × n
    
    backtrack(配列, 現在の順列, 使用済み, 結果)
    
    結果 を返す

関数 backtrack(配列, 現在, 使用済み, 結果):
    もし 現在の長さ == 配列の長さ なら:
        結果に現在のコピーを追加
        返る
    
    各iについて（0からn-1まで）:
        もし 使用済み[i] なら:
            次へ
        
        現在に配列[i]を追加
        使用済み[i] = true
        
        backtrack(配列, 現在, 使用済み, 結果)
        
        現在から最後を削除
        使用済み[i] = false
```

### 解答

```ruby
# 解法1: バックトラック（使用済み配列）
def permute(nums)
  result = []
  used = Array.new(nums.length, false)
  backtrack_permute(nums, [], used, result)
  result
end

def backtrack_permute(nums, current, used, result)
  # ベースケース
  if current.length == nums.length
    result << current.dup
    return
  end
  
  # 各要素を試す
  nums.each_with_index do |num, i|
    next if used[i]
    
    # 選択
    current << num
    used[i] = true
    
    # 再帰
    backtrack_permute(nums, current, used, result)
    
    # バックトラック
    current.pop
    used[i] = false
  end
end

# 解法2: スワップを使用
def permute_swap(nums)
  result = []
  backtrack_swap(nums.dup, 0, result)
  result
end

def backtrack_swap(nums, start, result)
  if start == nums.length
    result << nums.dup
    return
  end
  
  (start...nums.length).each do |i|
    # スワップ
    nums[start], nums[i] = nums[i], nums[start]
    
    # 再帰
    backtrack_swap(nums, start + 1, result)
    
    # バックトラック
    nums[start], nums[i] = nums[i], nums[start]
  end
end

# 解法3: 再帰的に構築
def permute_recursive(nums)
  return [[]] if nums.empty?
  return [nums] if nums.length == 1
  
  result = []
  
  nums.each_with_index do |num, i|
    # 現在の要素を除いた残りで順列を生成
    rest = nums[0...i] + nums[i+1..-1]
    
    permute_recursive(rest).each do |perm|
      result << [num] + perm
    end
  end
  
  result
end

# テストケース
p permute([1, 2, 3])  # => [[1,2,3], [1,3,2], [2,1,3], [2,3,1], [3,1,2], [3,2,1]]
p permute([0, 1])  # => [[0,1], [1,0]]
p permute([1])  # => [[1]]
```

---

## 問題2: 組み合わせの生成

### 問題文

2つの整数nとkが与えられます。1からnまでの数字からk個選ぶすべての組み合わせを返してください。

**入力例:**

```text
n = 4, k = 2
```

**出力例:**

```text
[[1,2], [1,3], [1,4], [2,3], [2,4], [3,4]]
```

### アルゴリズム概説

バックトラックを使用し、開始位置を追跡して重複を避けます。

**時間計算量:** O(C(n,k) × k) - C(n,k)は組み合わせの数  
**空間計算量:** O(k)

### 擬似コード

```text
関数 combine(n, k):
    結果 = []
    現在の組み合わせ = []
    
    backtrack(1, n, k, 現在の組み合わせ, 結果)
    
    結果 を返す

関数 backtrack(開始, n, k, 現在, 結果):
    もし 現在の長さ == k なら:
        結果に現在のコピーを追加
        返る
    
    各iについて（開始からnまで）:
        現在にiを追加
        backtrack(i + 1, n, k, 現在, 結果)
        現在から最後を削除
```

### 解答

```ruby
# 解法1: バックトラック
def combine(n, k)
  result = []
  backtrack_combine(1, n, k, [], result)
  result
end

def backtrack_combine(start, n, k, current, result)
  # ベースケース
  if current.length == k
    result << current.dup
    return
  end
  
  # 枝刈り: 残りの要素が足りない場合はスキップ
  needed = k - current.length
  
  (start..n).each do |i|
    # 枝刈り: 残りの要素が足りない
    break if n - i + 1 < needed
    
    # 選択
    current << i
    
    # 再帰
    backtrack_combine(i + 1, n, k, current, result)
    
    # バックトラック
    current.pop
  end
end

# 解法2: 再帰的に構築
def combine_recursive(n, k)
  return [[]] if k == 0
  return (1..n).map { |i| [i] } if k == 1
  
  result = []
  
  (1..n).each do |i|
    # i を含む組み合わせ
    combine_recursive(n - 1, k - 1).each do |comb|
      result << [i] + comb.map { |x| x + i }
    end
  end
  
  result
end

# 解法3: イテレーティブ（レベルごと）
def combine_iterative(n, k)
  return [[]] if k == 0
  
  result = (1..n).map { |i| [i] }
  
  (k - 1).times do
    new_result = []
    
    result.each do |comb|
      last = comb.last
      ((last + 1)..n).each do |i|
        new_result << comb + [i]
      end
    end
    
    result = new_result
  end
  
  result
end

# テストケース
p combine(4, 2)  # => [[1,2], [1,3], [1,4], [2,3], [2,4], [3,4]]
p combine(1, 1)  # => [[1]]
p combine(5, 3)  # => [[1,2,3], [1,2,4], [1,2,5], [1,3,4], [1,3,5], [1,4,5], [2,3,4], [2,3,5], [2,4,5], [3,4,5]]
```

---

## 問題3: 部分集合の生成

### 問題文

重複のない整数の配列が与えられます。すべての可能な部分集合（べき集合）を返してください。

**入力例:**

```text
nums = [1, 2, 3]
```

**出力例:**

```text
[[], [1], [2], [1,2], [3], [1,3], [2,3], [1,2,3]]
```

### アルゴリズム概説

バックトラックまたはビット演算を使用します。各要素について「含む」「含まない」の2択があります。

**時間計算量:** O(2^n × n)  
**空間計算量:** O(n)

### 擬似コード

```text
関数 subsets(配列):
    結果 = []
    現在の部分集合 = []
    
    backtrack(配列, 0, 現在の部分集合, 結果)
    
    結果 を返す

関数 backtrack(配列, 開始, 現在, 結果):
    結果に現在のコピーを追加
    
    各iについて（開始から配列の長さ-1まで）:
        現在に配列[i]を追加
        backtrack(配列, i + 1, 現在, 結果)
        現在から最後を削除
```

### 解答

```ruby
# 解法1: バックトラック
def subsets(nums)
  result = []
  backtrack_subsets(nums, 0, [], result)
  result
end

def backtrack_subsets(nums, start, current, result)
  # 現在の部分集合を追加
  result << current.dup
  
  # 次の要素を追加
  (start...nums.length).each do |i|
    current << nums[i]
    backtrack_subsets(nums, i + 1, current, result)
    current.pop
  end
end

# 解法2: ビット演算
def subsets_bit(nums)
  n = nums.length
  result = []
  
  # 2^n 個の部分集合
  (0...(2 ** n)).each do |mask|
    subset = []
    
    n.times do |i|
      # i番目のビットが立っているか
      subset << nums[i] if (mask >> i) & 1 == 1
    end
    
    result << subset
  end
  
  result
end

# 解法3: イテレーティブ（カスケード）
def subsets_iterative(nums)
  result = [[]]
  
  nums.each do |num|
    # 既存の各部分集合に num を追加した新しい部分集合を作成
    new_subsets = result.map { |subset| subset + [num] }
    result.concat(new_subsets)
  end
  
  result
end

# 解法4: 再帰的
def subsets_recursive(nums)
  return [[]] if nums.empty?
  
  # 最初の要素を取り出す
  first = nums[0]
  rest_subsets = subsets_recursive(nums[1..-1])
  
  # 最初の要素を含まない部分集合と含む部分集合
  rest_subsets + rest_subsets.map { |subset| [first] + subset }
end

# テストケース
p subsets([1, 2, 3])  # => [[], [1], [2], [1,2], [3], [1,3], [2,3], [1,2,3]]
p subsets([0])  # => [[], [0]]
p subsets([])  # => [[]]
```

---

## 問題4: N-Queens問題

### 問題文

n × n のチェスボード上にn個のクイーンを配置します。どのクイーンも互いに攻撃できないようにするすべての解を返してください。

**入力例:**

```text
n = 4
```

**出力例:**

```text
[
  [".Q..",
   "...Q",
   "Q...",
   "..Q."],
  ["..Q.",
   "Q...",
   "...Q",
   ".Q.."]
]
```

### アルゴリズム概説

各行に1つずつクイーンを配置し、列と対角線の制約をチェックします。バックトラックで探索します。

**時間計算量:** O(n!)  
**空間計算量:** O(n)

### 擬似コード

```text
関数 solve_n_queens(n):
    結果 = []
    盤面 = ['.'] × n のn個の配列
    列 = set()
    正対角線 = set()  # row - col
    負対角線 = set()  # row + col
    
    backtrack(0, 盤面, 列, 正対角線, 負対角線, 結果)
    
    結果 を返す

関数 backtrack(行, 盤面, 列, 正対角線, 負対角線, 結果):
    もし 行 == n なら:
        結果に盤面のコピーを追加
        返る
    
    各colについて（0からn-1まで）:
        もし col が 列 にある または
           行 - col が 正対角線 にある または
           行 + col が 負対角線 にある なら:
            次へ
        
        # クイーンを配置
        盤面[行][col] = 'Q'
        列, 正対角線, 負対角線 に追加
        
        backtrack(行 + 1, 盤面, 列, 正対角線, 負対角線, 結果)
        
        # バックトラック
        盤面[行][col] = '.'
        列, 正対角線, 負対角線 から削除
```

### 解答

```ruby
require 'set'

# 解法1: バックトラック（Set使用）
def solve_n_queens(n)
  result = []
  board = Array.new(n) { '.' * n }
  cols = Set.new
  pos_diag = Set.new  # row - col
  neg_diag = Set.new  # row + col
  
  backtrack_queens(0, n, board, cols, pos_diag, neg_diag, result)
  result
end

def backtrack_queens(row, n, board, cols, pos_diag, neg_diag, result)
  # ベースケース
  if row == n
    result << board.dup
    return
  end
  
  # 各列を試す
  n.times do |col|
    # 制約チェック
    next if cols.include?(col)
    next if pos_diag.include?(row - col)
    next if neg_diag.include?(row + col)
    
    # クイーンを配置
    board[row] = board[row][0...col] + 'Q' + board[row][col+1..-1]
    cols.add(col)
    pos_diag.add(row - col)
    neg_diag.add(row + col)
    
    # 再帰
    backtrack_queens(row + 1, n, board, cols, pos_diag, neg_diag, result)
    
    # バックトラック
    board[row] = '.' * n
    cols.delete(col)
    pos_diag.delete(row - col)
    neg_diag.delete(row + col)
  end
end

# 解法2: ビット演算
def solve_n_queens_bit(n)
  result = []
  board = Array.new(n) { '.' * n }
  
  backtrack_queens_bit(0, n, 0, 0, 0, board, result)
  result
end

def backtrack_queens_bit(row, n, cols, pos_diag, neg_diag, board, result)
  if row == n
    result << board.dup
    return
  end
  
  # 利用可能な位置（ビットが1の位置）
  available = ((1 << n) - 1) & ~(cols | pos_diag | neg_diag)
  
  while available > 0
    # 最下位ビットを取得
    position = available & -available
    col = Math.log2(position).to_i
    
    # クイーンを配置
    board[row] = '.' * col + 'Q' + '.' * (n - col - 1)
    
    # 再帰
    backtrack_queens_bit(
      row + 1, n,
      cols | position,
      (pos_diag | position) >> 1,
      (neg_diag | position) << 1,
      board, result
    )
    
    # バックトラック
    board[row] = '.' * n
    
    # 最下位ビットをクリア
    available &= available - 1
  end
end

# テストケース
p solve_n_queens(4)
# => [[".Q..", "...Q", "Q...", "..Q."], ["..Q.", "Q...", "...Q", ".Q.."]]
p solve_n_queens(1)
# => [["Q"]]
```

---

## 問題5: 数独ソルバー

### 問題文

部分的に埋められた9x9の数独ボードが与えられます。ボードを解いてください。

**入力例:**

```text
[
  ["5","3",".",".","7",".",".",".","."],
  ["6",".",".","1","9","5",".",".","."],
  ...
]
```

**出力例:**

```text
[
  ["5","3","4","6","7","8","9","1","2"],
  ["6","7","2","1","9","5","3","4","8"],
  ...
]
```

### アルゴリズム概説

バックトラックを使用し、各空きセルに1-9を試します。行、列、3x3ブロックの制約をチェックします。

**時間計算量:** O(9^m) - mは空きセルの数  
**空間計算量:** O(1)

### 擬似コード

```text
関数 solve_sudoku(盤面):
    backtrack(盤面)

関数 backtrack(盤面):
    各行について:
        各列について:
            もし 盤面[行][列] == '.' なら:
                各数字について（'1'から'9'まで）:
                    もし is_valid(盤面, 行, 列, 数字) なら:
                        盤面[行][列] = 数字
                        
                        もし backtrack(盤面) なら:
                            true を返す
                        
                        盤面[行][列] = '.'
                
                false を返す
    
    true を返す

関数 is_valid(盤面, 行, 列, 数字):
    # 行チェック
    # 列チェック
    # 3x3ブロックチェック
```

### 解答

```ruby
# 解法1: バックトラック
def solve_sudoku(board)
  backtrack_sudoku(board)
end

def backtrack_sudoku(board)
  9.times do |row|
    9.times do |col|
      if board[row][col] == '.'
        ('1'..'9').each do |num|
          if is_valid_sudoku(board, row, col, num)
            board[row][col] = num
            
            return true if backtrack_sudoku(board)
            
            # バックトラック
            board[row][col] = '.'
          end
        end
        
        return false
      end
    end
  end
  
  true
end

def is_valid_sudoku(board, row, col, num)
  # 行チェック
  return false if board[row].include?(num)
  
  # 列チェック
  return false if board.any? { |r| r[col] == num }
  
  # 3x3ブロックチェック
  box_row = (row / 3) * 3
  box_col = (col / 3) * 3
  
  (box_row...box_row + 3).each do |r|
    (box_col...box_col + 3).each do |c|
      return false if board[r][c] == num
    end
  end
  
  true
end

# 解法2: より効率的な検証（Set使用）
def solve_sudoku_optimized(board)
  # 各行、列、ブロックの使用済み数字を追跡
  rows = Array.new(9) { Set.new }
  cols = Array.new(9) { Set.new }
  boxes = Array.new(9) { Set.new }
  
  # 初期状態を記録
  9.times do |r|
    9.times do |c|
      if board[r][c] != '.'
        num = board[r][c]
        rows[r].add(num)
        cols[c].add(num)
        box_idx = (r / 3) * 3 + c / 3
        boxes[box_idx].add(num)
      end
    end
  end
  
  backtrack_sudoku_optimized(board, rows, cols, boxes)
end

def backtrack_sudoku_optimized(board, rows, cols, boxes)
  9.times do |row|
    9.times do |col|
      if board[row][col] == '.'
        box_idx = (row / 3) * 3 + col / 3
        
        ('1'..'9').each do |num|
          if !rows[row].include?(num) &&
             !cols[col].include?(num) &&
             !boxes[box_idx].include?(num)
            
            # 数字を配置
            board[row][col] = num
            rows[row].add(num)
            cols[col].add(num)
            boxes[box_idx].add(num)
            
            return true if backtrack_sudoku_optimized(board, rows, cols, boxes)
            
            # バックトラック
            board[row][col] = '.'
            rows[row].delete(num)
            cols[col].delete(num)
            boxes[box_idx].delete(num)
          end
        end
        
        return false
      end
    end
  end
  
  true
end

# テストケース
board = [
  ["5","3",".",".","7",".",".",".","."],
  ["6",".",".","1","9","5",".",".","."],
  [".","9","8",".",".",".",".","6","."],
  ["8",".",".",".","6",".",".",".","3"],
  ["4",".",".","8",".","3",".",".","1"],
  ["7",".",".",".","2",".",".",".","6"],
  [".","6",".",".",".",".","2","8","."],
  [".",".",".","4","1","9",".",".","5"],
  [".",".",".",".","8",".",".","7","9"]
]

solve_sudoku(board)
p board
```

---

## 問題6: 単語検索

### 問題文

m x n の文字グリッドと単語が与えられます。グリッド内に単語が存在するかを判定してください。単語は上下左右の隣接セルから構成され、同じセルは2回使用できません。

**入力例:**

```text
board = [
  ['A','B','C','E'],
  ['S','F','C','S'],
  ['A','D','E','E']
]
word = "ABCCED"
```

**出力例:**

```text
true
```

### アルゴリズム概説

DFS + バックトラックを使用します。各セルから開始し、4方向に探索します。

**時間計算量:** O(m × n × 4^L) - Lは単語の長さ  
**空間計算量:** O(L)

### 擬似コード

```text
関数 exist(盤面, 単語):
    各行について:
        各列について:
            もし dfs(盤面, 行, 列, 単語, 0) なら:
                true を返す
    
    false を返す

関数 dfs(盤面, 行, 列, 単語, インデックス):
    もし インデックス == 単語の長さ なら:
        true を返す
    
    もし 範囲外 または 盤面[行][列] != 単語[インデックス] なら:
        false を返す
    
    # 訪問済みマーク
    一時 = 盤面[行][列]
    盤面[行][列] = '#'
    
    # 4方向探索
    結果 = dfs(上) または dfs(下) または dfs(左) または dfs(右)
    
    # バックトラック
    盤面[行][列] = 一時
    
    結果 を返す
```

### 解答

```ruby
# 解法1: DFS + バックトラック
def exist(board, word)
  m = board.length
  n = board[0].length
  
  m.times do |r|
    n.times do |c|
      return true if dfs_exist(board, word, r, c, 0)
    end
  end
  
  false
end

def dfs_exist(board, word, row, col, index)
  # ベースケース: すべての文字が一致
  return true if index == word.length
  
  # 範囲外チェック
  return false if row < 0 || row >= board.length ||
                  col < 0 || col >= board[0].length
  
  # 文字が一致しないか、訪問済み
  return false if board[row][col] != word[index]
  
  # 訪問済みマーク
  temp = board[row][col]
  board[row][col] = '#'
  
  # 4方向探索
  result = dfs_exist(board, word, row + 1, col, index + 1) ||
           dfs_exist(board, word, row - 1, col, index + 1) ||
           dfs_exist(board, word, row, col + 1, index + 1) ||
           dfs_exist(board, word, row, col - 1, index + 1)
  
  # バックトラック
  board[row][col] = temp
  
  result
end

# 解法2: 訪問済みセットを使用
def exist_with_set(board, word)
  m = board.length
  n = board[0].length
  
  m.times do |r|
    n.times do |c|
      visited = Set.new
      return true if dfs_exist_set(board, word, r, c, 0, visited)
    end
  end
  
  false
end

def dfs_exist_set(board, word, row, col, index, visited)
  return true if index == word.length
  
  return false if row < 0 || row >= board.length ||
                  col < 0 || col >= board[0].length ||
                  visited.include?([row, col]) ||
                  board[row][col] != word[index]
  
  visited.add([row, col])
  
  result = dfs_exist_set(board, word, row + 1, col, index + 1, visited) ||
           dfs_exist_set(board, word, row - 1, col, index + 1, visited) ||
           dfs_exist_set(board, word, row, col + 1, index + 1, visited) ||
           dfs_exist_set(board, word, row, col - 1, index + 1, visited)
  
  visited.delete([row, col])
  
  result
end

# テストケース
board = [
  ['A','B','C','E'],
  ['S','F','C','S'],
  ['A','D','E','E']
]

p exist(board, "ABCCED")  # => true
p exist(board, "SEE")     # => true
p exist(board, "ABCB")    # => false
```

---

## 問題7: 括弧の生成

### 問題文

n組の括弧のすべての有効な組み合わせを生成してください。

**入力例:**

```text
n = 3
```

**出力例:**

```text
["((()))", "(()())", "(())()", "()(())", "()()()"]
```

### アルゴリズム概説

バックトラックを使用し、開き括弧と閉じ括弧の数を追跡します。開き括弧が残っていれば追加でき、閉じ括弧は開き括弧より少ない場合のみ追加できます。

**時間計算量:** O(4^n / √n) - カタラン数  
**空間計算量:** O(n)

### 擬似コード

```text
関数 generate_parenthesis(n):
    結果 = []
    backtrack("", 0, 0, n, 結果)
    結果 を返す

関数 backtrack(現在, 開き, 閉じ, n, 結果):
    もし 現在の長さ == 2 * n なら:
        結果に現在を追加
        返る
    
    もし 開き < n なら:
        backtrack(現在 + "(", 開き + 1, 閉じ, n, 結果)
    
    もし 閉じ < 開き なら:
        backtrack(現在 + ")", 開き, 閉じ + 1, n, 結果)
```

### 解答

```ruby
# 解法1: バックトラック
def generate_parenthesis(n)
  result = []
  backtrack_paren('', 0, 0, n, result)
  result
end

def backtrack_paren(current, open_count, close_count, n, result)
  # ベースケース
  if current.length == 2 * n
    result << current
    return
  end
  
  # 開き括弧を追加
  if open_count < n
    backtrack_paren(current + '(', open_count + 1, close_count, n, result)
  end
  
  # 閉じ括弧を追加（開き括弧より少ない場合のみ）
  if close_count < open_count
    backtrack_paren(current + ')', open_count, close_count + 1, n, result)
  end
end

# 解法2: クロージャーナンバー
def generate_parenthesis_closure(n)
  return [''] if n == 0
  
  result = []
  
  (0...n).each do |c|
    (0...n).each do |i|
      left = generate_parenthesis_closure(c)
      right = generate_parenthesis_closure(i)
      
      if c + i + 1 == n
        left.each do |l|
          right.each do |r|
            result << "(#{l})#{r}"
          end
        end
      end
    end
  end
  
  result
end

# 解法3: 動的計画法
def generate_parenthesis_dp(n)
  dp = Array.new(n + 1) { [] }
  dp[0] = ['']
  
  (1..n).each do |i|
    (0...i).each do |c|
      dp[c].each do |left|
        dp[i - 1 - c].each do |right|
          dp[i] << "(#{left})#{right}"
        end
      end
    end
  end
  
  dp[n]
end

# テストケース
p generate_parenthesis(3)
# => ["((()))", "(()())", "(())()", "()(())", "()()()"]
p generate_parenthesis(1)
# => ["()"]
p generate_parenthesis(2)
# => ["(())", "()()"]
```

---

## 問題8: 電話番号の文字の組み合わせ

### 問題文

2-9の数字を含む文字列が与えられます。その数字が表すすべての可能な文字の組み合わせを返してください（電話のキーパッドと同じマッピング）。

**入力例:**

```text
digits = "23"
```

**出力例:**

```text
["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]
```

### アルゴリズム概説

バックトラックを使用し、各数字に対応する文字を順番に試します。

**時間計算量:** O(4^n) - nは数字の個数  
**空間計算量:** O(n)

### 擬似コード

```text
関数 letter_combinations(数字列):
    もし 数字列が空 なら:
        [] を返す
    
    マッピング = {
        '2': 'abc', '3': 'def', '4': 'ghi',
        '5': 'jkl', '6': 'mno', '7': 'pqrs',
        '8': 'tuv', '9': 'wxyz'
    }
    
    結果 = []
    backtrack("", 0, 数字列, マッピング, 結果)
    
    結果 を返す

関数 backtrack(現在, インデックス, 数字列, マッピング, 結果):
    もし インデックス == 数字列の長さ なら:
        結果に現在を追加
        返る
    
    現在の数字 = 数字列[インデックス]
    文字列 = マッピング[現在の数字]
    
    各文字について:
        backtrack(現在 + 文字, インデックス + 1, 数字列, マッピング, 結果)
```

### 解答

```ruby
# 解法1: バックトラック
def letter_combinations(digits)
  return [] if digits.empty?
  
  mapping = {
    '2' => 'abc', '3' => 'def', '4' => 'ghi',
    '5' => 'jkl', '6' => 'mno', '7' => 'pqrs',
    '8' => 'tuv', '9' => 'wxyz'
  }
  
  result = []
  backtrack_letters('', 0, digits, mapping, result)
  result
end

def backtrack_letters(current, index, digits, mapping, result)
  # ベースケース
  if index == digits.length
    result << current
    return
  end
  
  # 現在の数字に対応する文字
  digit = digits[index]
  letters = mapping[digit]
  
  letters.each_char do |letter|
    backtrack_letters(current + letter, index + 1, digits, mapping, result)
  end
end

# 解法2: イテレーティブ
def letter_combinations_iterative(digits)
  return [] if digits.empty?
  
  mapping = {
    '2' => 'abc', '3' => 'def', '4' => 'ghi',
    '5' => 'jkl', '6' => 'mno', '7' => 'pqrs',
    '8' => 'tuv', '9' => 'wxyz'
  }
  
  result = ['']
  
  digits.each_char do |digit|
    letters = mapping[digit]
    new_result = []
    
    result.each do |combo|
      letters.each_char do |letter|
        new_result << combo + letter
      end
    end
    
    result = new_result
  end
  
  result
end

# 解法3: 再帰的
def letter_combinations_recursive(digits)
  return [] if digits.empty?
  
  mapping = {
    '2' => 'abc', '3' => 'def', '4' => 'ghi',
    '5' => 'jkl', '6' => 'mno', '7' => 'pqrs',
    '8' => 'tuv', '9' => 'wxyz'
  }
  
  return mapping[digits[0]].chars if digits.length == 1
  
  first_letters = mapping[digits[0]].chars
  rest_combinations = letter_combinations_recursive(digits[1..-1])
  
  result = []
  first_letters.each do |letter|
    rest_combinations.each do |combo|
      result << letter + combo
    end
  end
  
  result
end

# テストケース
p letter_combinations("23")
# => ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]
p letter_combinations("")
# => []
p letter_combinations("2")
# => ["a", "b", "c"]
```

---

## まとめ

このセクションでは、再帰とバックトラック法の詳細な問題を学びました。

重要なポイントは以下の通りです。

1. バックトラックは探索空間を体系的に調べる手法です
2. 選択、探索、取り消しの3ステップが基本です
3. 枝刈りで不要な探索を早期に打ち切ることが重要です
4. 順列、組み合わせ、部分集合は基本パターンです
5. 制約条件を効率的にチェックすることがパフォーマンスの鍵です

バックトラックは、すべての可能な解を見つける必要がある問題や、最適解を探す問題で広く使用されます。パズルソルバー、経路探索、組み合わせ最適化など、多くの応用があります。
