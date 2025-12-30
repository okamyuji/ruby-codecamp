# 動的計画法 - 詳細問題

## 概要

このセクションでは、動的計画法（Dynamic Programming, DP）の詳細な問題を扱います。貰うDP（pull DP）と配るDP（push DP）の違い、一次元DP、二次元DP、最適化テクニックなどを学びます。

---

## 問題1: ナップサック問題（0-1 Knapsack）

### 問題文

n個のアイテムがあり、各アイテムには重さと価値があります。容量がWのナップサックに入れられる最大の価値を求めてください。

**入力例:**

```text
weights = [1, 3, 4, 5]
values = [1, 4, 5, 7]
W = 7
```

**出力例:**

```text
9  # アイテム2と4を選択（価値4 + 5 = 9、重さ3 + 4 = 7）
```

### アルゴリズム概説

二次元DPを使用します。`dp[i][w]` = アイテムi個目まで見て、容量wの場合の最大価値

**時間計算量:** O(nW)  
**空間計算量:** O(nW) または O(W)（最適化版）

### 擬似コード

```text
関数 knapsack(重さ配列, 価値配列, W):
    n = アイテム数
    dp = (n+1) × (W+1) のゼロ配列
    
    各iについて（1からnまで）:
        各wについて（0からWまで）:
            # アイテムiを選ばない
            dp[i][w] = dp[i-1][w]
            
            # アイテムiを選ぶ（可能なら）
            もし w >= 重さ[i-1] なら:
                dp[i][w] = max(dp[i][w], dp[i-1][w - 重さ[i-1]] + 価値[i-1])
    
    dp[n][W] を返す
```

### 解答

```ruby
# 解法1: 二次元DP（貰うDP）
def knapsack(weights, values, w)
  n = weights.length
  dp = Array.new(n + 1) { Array.new(w + 1, 0) }
  
  (1..n).each do |i|
    (0..w).each do |cap|
      # アイテム i-1 を選ばない
      dp[i][cap] = dp[i - 1][cap]
      
      # アイテム i-1 を選ぶ（可能なら）
      if cap >= weights[i - 1]
        dp[i][cap] = [
          dp[i][cap],
          dp[i - 1][cap - weights[i - 1]] + values[i - 1]
        ].max
      end
    end
  end
  
  dp[n][w]
end

# 解法2: 一次元DP（空間最適化）
def knapsack_1d(weights, values, w)
  dp = Array.new(w + 1, 0)
  
  weights.each_with_index do |weight, i|
    value = values[i]
    
    # 後ろから更新（上書きを防ぐ）
    w.downto(weight) do |cap|
      dp[cap] = [dp[cap], dp[cap - weight] + value].max
    end
  end
  
  dp[w]
end

# 解法3: 配るDP
def knapsack_push(weights, values, w)
  dp = Array.new(w + 1, 0)
  
  weights.each_with_index do |weight, i|
    value = values[i]
    new_dp = dp.dup
    
    (0..w).each do |cap|
      if cap + weight <= w
        new_dp[cap + weight] = [new_dp[cap + weight], dp[cap] + value].max
      end
    end
    
    dp = new_dp
  end
  
  dp[w]
end

# 解法4: 選択したアイテムを追跡
def knapsack_with_items(weights, values, w)
  n = weights.length
  dp = Array.new(n + 1) { Array.new(w + 1, 0) }
  
  # DP計算
  (1..n).each do |i|
    (0..w).each do |cap|
      dp[i][cap] = dp[i - 1][cap]
      
      if cap >= weights[i - 1]
        dp[i][cap] = [
          dp[i][cap],
          dp[i - 1][cap - weights[i - 1]] + values[i - 1]
        ].max
      end
    end
  end
  
  # バックトラック
  selected = []
  i = n
  cap = w
  
  while i > 0 && cap > 0
    # アイテムiが選ばれたか
    if dp[i][cap] != dp[i - 1][cap]
      selected << i - 1
      cap -= weights[i - 1]
    end
    i -= 1
  end
  
  [dp[n][w], selected.reverse]
end

# テストケース
weights = [1, 3, 4, 5]
values = [1, 4, 5, 7]
p knapsack(weights, values, 7)  # => 9
p knapsack_1d(weights, values, 7)  # => 9
p knapsack_with_items(weights, values, 7)  # => [9, [1, 2]]
```

---

## 問題2: 最長共通部分列（LCS）

### 問題文

2つの文字列が与えられます。最長共通部分列の長さを返してください。

**入力例:**

```text
text1 = "abcde"
text2 = "ace"
```

**出力例:**

```text
3  # "ace"
```

### アルゴリズム概説

二次元DPを使用します。`dp[i][j]` = text1[0...i]とtext2[0...j]のLCSの長さ

**時間計算量:** O(m × n)  
**空間計算量:** O(m × n) または O(min(m, n))（最適化版）

### 擬似コード

```text
関数 longest_common_subsequence(text1, text2):
    m = text1の長さ
    n = text2の長さ
    dp = (m+1) × (n+1) のゼロ配列
    
    各iについて（1からmまで）:
        各jについて（1からnまで）:
            もし text1[i-1] == text2[j-1] なら:
                dp[i][j] = dp[i-1][j-1] + 1
            そうでなければ:
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])
    
    dp[m][n] を返す
```

### 解答

```ruby
# 解法1: 二次元DP
def longest_common_subsequence(text1, text2)
  m = text1.length
  n = text2.length
  dp = Array.new(m + 1) { Array.new(n + 1, 0) }
  
  (1..m).each do |i|
    (1..n).each do |j|
      if text1[i - 1] == text2[j - 1]
        dp[i][j] = dp[i - 1][j - 1] + 1
      else
        dp[i][j] = [dp[i - 1][j], dp[i][j - 1]].max
      end
    end
  end
  
  dp[m][n]
end

# 解法2: 一次元DP（空間最適化）
def longest_common_subsequence_1d(text1, text2)
  # 短い方を列にする
  text1, text2 = text2, text1 if text1.length > text2.length
  
  m = text1.length
  n = text2.length
  
  prev = Array.new(n + 1, 0)
  
  (1..m).each do |i|
    curr = Array.new(n + 1, 0)
    
    (1..n).each do |j|
      if text1[i - 1] == text2[j - 1]
        curr[j] = prev[j - 1] + 1
      else
        curr[j] = [prev[j], curr[j - 1]].max
      end
    end
    
    prev = curr
  end
  
  prev[n]
end

# 解法3: LCS文字列を復元
def longest_common_subsequence_with_string(text1, text2)
  m = text1.length
  n = text2.length
  dp = Array.new(m + 1) { Array.new(n + 1, 0) }
  
  # DP計算
  (1..m).each do |i|
    (1..n).each do |j|
      if text1[i - 1] == text2[j - 1]
        dp[i][j] = dp[i - 1][j - 1] + 1
      else
        dp[i][j] = [dp[i - 1][j], dp[i][j - 1]].max
      end
    end
  end
  
  # バックトラック
  lcs = []
  i = m
  j = n
  
  while i > 0 && j > 0
    if text1[i - 1] == text2[j - 1]
      lcs.unshift(text1[i - 1])
      i -= 1
      j -= 1
    elsif dp[i - 1][j] > dp[i][j - 1]
      i -= 1
    else
      j -= 1
    end
  end
  
  [dp[m][n], lcs.join]
end

# テストケース
p longest_common_subsequence("abcde", "ace")  # => 3
p longest_common_subsequence("abc", "abc")  # => 3
p longest_common_subsequence("abc", "def")  # => 0
p longest_common_subsequence_with_string("abcde", "ace")  # => [3, "ace"]
```

---

## 問題3: 最長増加部分列（LIS）

### 問題文

整数の配列が与えられます。最長増加部分列の長さを返してください。

**入力例:**

```text
nums = [10, 9, 2, 5, 3, 7, 101, 18]
```

**出力例:**

```text
4  # [2, 3, 7, 101] または [2, 3, 7, 18]
```

### アルゴリズム概説

DPまたは二分探索を使用します。dp[i] = i番目の要素で終わるLISの長さ

**時間計算量:** O(n²) - DP、O(n log n) - 二分探索  
**空間計算量:** O(n)

### 擬似コード

```text
関数 length_of_lis(配列):
    n = 配列の長さ
    dp = [1] × n
    
    各iについて（1からn-1まで）:
        各jについて（0からi-1まで）:
            もし 配列[j] < 配列[i] なら:
                dp[i] = max(dp[i], dp[j] + 1)
    
    dpの最大値 を返す
```

### 解答

```ruby
# 解法1: DP（O(n²)）
def length_of_lis(nums)
  return 0 if nums.empty?
  
  n = nums.length
  dp = Array.new(n, 1)
  
  (1...n).each do |i|
    (0...i).each do |j|
      if nums[j] < nums[i]
        dp[i] = [dp[i], dp[j] + 1].max
      end
    end
  end
  
  dp.max
end

# 解法2: 二分探索（O(n log n)）
def length_of_lis_binary(nums)
  return 0 if nums.empty?
  
  # tails[i] = 長さ i+1 のLISの末尾の最小値
  tails = []
  
  nums.each do |num|
    # num が入る位置を二分探索
    idx = tails.bsearch_index { |x| x >= num } || tails.length
    
    if idx == tails.length
      tails << num
    else
      tails[idx] = num
    end
  end
  
  tails.length
end

# 解法3: LIS配列を復元
def length_of_lis_with_sequence(nums)
  return [0, []] if nums.empty?
  
  n = nums.length
  dp = Array.new(n, 1)
  parent = Array.new(n, -1)
  
  (1...n).each do |i|
    (0...i).each do |j|
      if nums[j] < nums[i] && dp[j] + 1 > dp[i]
        dp[i] = dp[j] + 1
        parent[i] = j
      end
    end
  end
  
  # 最大長のインデックス
  max_length = dp.max
  max_idx = dp.index(max_length)
  
  # バックトラック
  lis = []
  idx = max_idx
  
  while idx != -1
    lis.unshift(nums[idx])
    idx = parent[idx]
  end
  
  [max_length, lis]
end

# テストケース
p length_of_lis([10, 9, 2, 5, 3, 7, 101, 18])  # => 4
p length_of_lis_binary([10, 9, 2, 5, 3, 7, 101, 18])  # => 4
p length_of_lis_with_sequence([10, 9, 2, 5, 3, 7, 101, 18])  # => [4, [2, 3, 7, 101]]
p length_of_lis([0, 1, 0, 3, 2, 3])  # => 4
p length_of_lis([7, 7, 7, 7, 7, 7, 7])  # => 1
```

---

## 問題4: 編集距離（Edit Distance）

### 問題文

2つの文字列word1とword2が与えられます。word1をword2に変換するための最小編集回数を返してください。可能な操作は、挿入、削除、置換です。

**入力例:**

```text
word1 = "horse"
word2 = "ros"
```

**出力例:**

```text
3  # horse -> rorse -> rose -> ros
```

### アルゴリズム概説

二次元DPを使用します。`dp[i][j]` = word1[0...i]をword2[0...j]に変換する最小編集回数

**時間計算量:** O(m × n)  
**空間計算量:** O(m × n) または O(min(m, n))（最適化版）

### 擬似コード

```text
関数 min_distance(word1, word2):
    m = word1の長さ
    n = word2の長さ
    dp = (m+1) × (n+1) の配列
    
    # 初期化
    各iについて: dp[i][0] = i
    各jについて: dp[0][j] = j
    
    各iについて（1からmまで）:
        各jについて（1からnまで）:
            もし word1[i-1] == word2[j-1] なら:
                dp[i][j] = dp[i-1][j-1]
            そうでなければ:
                dp[i][j] = 1 + min(
                    dp[i-1][j],      # 削除
                    dp[i][j-1],      # 挿入
                    dp[i-1][j-1]     # 置換
                )
    
    dp[m][n] を返す
```

### 解答

```ruby
# 解法1: 二次元DP
def min_distance(word1, word2)
  m = word1.length
  n = word2.length
  
  dp = Array.new(m + 1) { Array.new(n + 1, 0) }
  
  # 初期化
  (0..m).each { |i| dp[i][0] = i }
  (0..n).each { |j| dp[0][j] = j }
  
  (1..m).each do |i|
    (1..n).each do |j|
      if word1[i - 1] == word2[j - 1]
        dp[i][j] = dp[i - 1][j - 1]
      else
        dp[i][j] = 1 + [
          dp[i - 1][j],      # 削除
          dp[i][j - 1],      # 挿入
          dp[i - 1][j - 1]   # 置換
        ].min
      end
    end
  end
  
  dp[m][n]
end

# 解法2: 一次元DP（空間最適化）
def min_distance_1d(word1, word2)
  # 短い方を列にする
  word1, word2 = word2, word1 if word1.length > word2.length
  
  m = word1.length
  n = word2.length
  
  prev = (0..n).to_a
  
  (1..m).each do |i|
    curr = [i] + Array.new(n, 0)
    
    (1..n).each do |j|
      if word1[i - 1] == word2[j - 1]
        curr[j] = prev[j - 1]
      else
        curr[j] = 1 + [prev[j], curr[j - 1], prev[j - 1]].min
      end
    end
    
    prev = curr
  end
  
  prev[n]
end

# 解法3: 操作履歴を復元
def min_distance_with_operations(word1, word2)
  m = word1.length
  n = word2.length
  
  dp = Array.new(m + 1) { Array.new(n + 1, 0) }
  operations = Array.new(m + 1) { Array.new(n + 1, '') }
  
  # 初期化
  (0..m).each do |i|
    dp[i][0] = i
    operations[i][0] = 'delete' * i
  end
  
  (0..n).each do |j|
    dp[0][j] = j
    operations[0][j] = 'insert' * j
  end
  
  (1..m).each do |i|
    (1..n).each do |j|
      if word1[i - 1] == word2[j - 1]
        dp[i][j] = dp[i - 1][j - 1]
        operations[i][j] = operations[i - 1][j - 1]
      else
        delete_cost = dp[i - 1][j]
        insert_cost = dp[i][j - 1]
        replace_cost = dp[i - 1][j - 1]
        
        min_cost = [delete_cost, insert_cost, replace_cost].min
        dp[i][j] = 1 + min_cost
        
        if min_cost == delete_cost
          operations[i][j] = operations[i - 1][j] + 'D'
        elsif min_cost == insert_cost
          operations[i][j] = operations[i][j - 1] + 'I'
        else
          operations[i][j] = operations[i - 1][j - 1] + 'R'
        end
      end
    end
  end
  
  [dp[m][n], operations[m][n]]
end

# テストケース
p min_distance("horse", "ros")  # => 3
p min_distance("intention", "execution")  # => 5
p min_distance("", "a")  # => 1
p min_distance_with_operations("horse", "ros")  # => [3, "RDR"]
```

---

## 問題5: コイン両替（Coin Change）

### 問題文

異なる額面のコインの配列と金額が与えられます。その金額を作るための最小のコイン数を返してください。不可能な場合は-1を返します。

**入力例:**

```text
coins = [1, 2, 5], amount = 11
```

**出力例:**

```text
3  # 5 + 5 + 1
```

### アルゴリズム概説

一次元DPを使用します。dp[i] = 金額iを作るための最小コイン数

**時間計算量:** O(amount × n) - nはコインの種類数  
**空間計算量:** O(amount)

### 擬似コード

```text
関数 coin_change(コイン配列, 金額):
    dp = [無限大] × (金額 + 1)
    dp[0] = 0
    
    各iについて（1から金額まで）:
        各コインについて:
            もし i >= コイン なら:
                dp[i] = min(dp[i], dp[i - コイン] + 1)
    
    dp[金額] == 無限大 なら -1 を返す
    そうでなければ dp[金額] を返す
```

### 解答

```ruby
# 解法1: 貰うDP
def coin_change(coins, amount)
  dp = Array.new(amount + 1, Float::INFINITY)
  dp[0] = 0
  
  (1..amount).each do |i|
    coins.each do |coin|
      if i >= coin
        dp[i] = [dp[i], dp[i - coin] + 1].min
      end
    end
  end
  
  dp[amount] == Float::INFINITY ? -1 : dp[amount]
end

# 解法2: 配るDP
def coin_change_push(coins, amount)
  dp = Array.new(amount + 1, Float::INFINITY)
  dp[0] = 0
  
  (0...amount).each do |i|
    next if dp[i] == Float::INFINITY
    
    coins.each do |coin|
      if i + coin <= amount
        dp[i + coin] = [dp[i + coin], dp[i] + 1].min
      end
    end
  end
  
  dp[amount] == Float::INFINITY ? -1 : dp[amount]
end

# 解法3: コインの組み合わせを復元
def coin_change_with_coins(coins, amount)
  dp = Array.new(amount + 1, Float::INFINITY)
  parent = Array.new(amount + 1, -1)
  dp[0] = 0
  
  (1..amount).each do |i|
    coins.each do |coin|
      if i >= coin && dp[i - coin] + 1 < dp[i]
        dp[i] = dp[i - coin] + 1
        parent[i] = coin
      end
    end
  end
  
  return [-1, []] if dp[amount] == Float::INFINITY
  
  # バックトラック
  result = []
  curr = amount
  
  while curr > 0
    coin = parent[curr]
    result << coin
    curr -= coin
  end
  
  [dp[amount], result.sort]
end

# テストケース
p coin_change([1, 2, 5], 11)  # => 3
p coin_change([2], 3)  # => -1
p coin_change([1], 0)  # => 0
p coin_change_with_coins([1, 2, 5], 11)  # => [3, [1, 5, 5]]
```

---

## 問題6: 最大正方形（Maximal Square）

### 問題文

'0'と'1'で構成された2Dバイナリ行列が与えられます。'1'のみで構成される最大の正方形の面積を求めてください。

**入力例:**

```text
matrix = [
  ["1","0","1","0","0"],
  ["1","0","1","1","1"],
  ["1","1","1","1","1"],
  ["1","0","0","1","0"]
]
```

**出力例:**

```text
4  # 2×2の正方形
```

### アルゴリズム概説

二次元DPを使用します。`dp[i][j]` = (i, j)を右下とする最大正方形の一辺の長さ

**時間計算量:** O(m × n)  
**空間計算量:** O(m × n) または O(n)（最適化版）

### 擬似コード

```text
関数 maximal_square(行列):
    m = 行数
    n = 列数
    dp = (m+1) × (n+1) のゼロ配列
    最大辺長 = 0
    
    各iについて（1からmまで）:
        各jについて（1からnまで）:
            もし 行列[i-1][j-1] == '1' なら:
                dp[i][j] = 1 + min(
                    dp[i-1][j],
                    dp[i][j-1],
                    dp[i-1][j-1]
                )
                最大辺長 = max(最大辺長, dp[i][j])
    
    最大辺長 * 最大辺長 を返す
```

### 解答

```ruby
# 解法1: 二次元DP
def maximal_square(matrix)
  return 0 if matrix.empty?
  
  m = matrix.length
  n = matrix[0].length
  
  dp = Array.new(m + 1) { Array.new(n + 1, 0) }
  max_side = 0
  
  (1..m).each do |i|
    (1..n).each do |j|
      if matrix[i - 1][j - 1] == '1'
        dp[i][j] = 1 + [
          dp[i - 1][j],
          dp[i][j - 1],
          dp[i - 1][j - 1]
        ].min
        
        max_side = [max_side, dp[i][j]].max
      end
    end
  end
  
  max_side * max_side
end

# 解法2: 一次元DP（空間最適化）
def maximal_square_1d(matrix)
  return 0 if matrix.empty?
  
  m = matrix.length
  n = matrix[0].length
  
  prev = Array.new(n + 1, 0)
  max_side = 0
  
  (1..m).each do |i|
    curr = Array.new(n + 1, 0)
    
    (1..n).each do |j|
      if matrix[i - 1][j - 1] == '1'
        curr[j] = 1 + [prev[j], curr[j - 1], prev[j - 1]].min
        max_side = [max_side, curr[j]].max
      end
    end
    
    prev = curr
  end
  
  max_side * max_side
end

# 解法3: 位置を追跡
def maximal_square_with_position(matrix)
  return [0, nil] if matrix.empty?
  
  m = matrix.length
  n = matrix[0].length
  
  dp = Array.new(m + 1) { Array.new(n + 1, 0) }
  max_side = 0
  max_i = 0
  max_j = 0
  
  (1..m).each do |i|
    (1..n).each do |j|
      if matrix[i - 1][j - 1] == '1'
        dp[i][j] = 1 + [dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]].min
        
        if dp[i][j] > max_side
          max_side = dp[i][j]
          max_i = i
          max_j = j
        end
      end
    end
  end
  
  # 左上の座標
  top_left = [max_i - max_side, max_j - max_side]
  
  [max_side * max_side, top_left]
end

# テストケース
matrix1 = [
  ["1","0","1","0","0"],
  ["1","0","1","1","1"],
  ["1","1","1","1","1"],
  ["1","0","0","1","0"]
]
p maximal_square(matrix1)  # => 4

matrix2 = [
  ["0","1"],
  ["1","0"]
]
p maximal_square(matrix2)  # => 1

matrix3 = [["0"]]
p maximal_square(matrix3)  # => 0
```

---

## 問題7: ユニークなパスII（障害物あり）

### 問題文

m × n のグリッドがあり、障害物が含まれます。左上から右下まで移動する一意のパスの数を返してください。

**入力例:**

```text
obstacleGrid = [
  [0,0,0],
  [0,1,0],
  [0,0,0]
]
```

**出力例:**

```text
2  # 右右下、下右右
```

### アルゴリズム概説

二次元DPを使用します。`dp[i][j]` = (i, j)に到達するパスの数

**時間計算量:** O(m × n)  
**空間計算量:** O(m × n) または O(n)（最適化版）

### 擬似コード

```text
関数 unique_paths_with_obstacles(グリッド):
    m = 行数
    n = 列数
    
    もし グリッド[0][0] == 1 なら:
        0 を返す
    
    dp = m × n のゼロ配列
    dp[0][0] = 1
    
    各iについて（0からm-1まで）:
        各jについて（0からn-1まで）:
            もし グリッド[i][j] == 1 なら:
                dp[i][j] = 0
                次へ
            
            もし i > 0 なら:
                dp[i][j] += dp[i-1][j]
            もし j > 0 なら:
                dp[i][j] += dp[i][j-1]
    
    dp[m-1][n-1] を返す
```

### 解答

```ruby
# 解法1: 二次元DP
def unique_paths_with_obstacles(obstacle_grid)
  return 0 if obstacle_grid[0][0] == 1
  
  m = obstacle_grid.length
  n = obstacle_grid[0].length
  
  dp = Array.new(m) { Array.new(n, 0) }
  dp[0][0] = 1
  
  (0...m).each do |i|
    (0...n).each do |j|
      next if i == 0 && j == 0
      
      if obstacle_grid[i][j] == 1
        dp[i][j] = 0
      else
        dp[i][j] = 0
        dp[i][j] += dp[i - 1][j] if i > 0
        dp[i][j] += dp[i][j - 1] if j > 0
      end
    end
  end
  
  dp[m - 1][n - 1]
end

# 解法2: 一次元DP（空間最適化）
def unique_paths_with_obstacles_1d(obstacle_grid)
  return 0 if obstacle_grid[0][0] == 1
  
  m = obstacle_grid.length
  n = obstacle_grid[0].length
  
  dp = Array.new(n, 0)
  dp[0] = 1
  
  (0...m).each do |i|
    (0...n).each do |j|
      if obstacle_grid[i][j] == 1
        dp[j] = 0
      elsif j > 0
        dp[j] += dp[j - 1]
      end
    end
  end
  
  dp[n - 1]
end

# 解法3: in-placeで計算
def unique_paths_with_obstacles_inplace(obstacle_grid)
  return 0 if obstacle_grid[0][0] == 1
  
  m = obstacle_grid.length
  n = obstacle_grid[0].length
  
  obstacle_grid[0][0] = 1
  
  # 最初の行を初期化
  (1...n).each do |j|
    obstacle_grid[0][j] = (obstacle_grid[0][j] == 0 && obstacle_grid[0][j - 1] == 1) ? 1 : 0
  end
  
  # 最初の列を初期化
  (1...m).each do |i|
    obstacle_grid[i][0] = (obstacle_grid[i][0] == 0 && obstacle_grid[i - 1][0] == 1) ? 1 : 0
  end
  
  # DP計算
  (1...m).each do |i|
    (1...n).each do |j|
      if obstacle_grid[i][j] == 0
        obstacle_grid[i][j] = obstacle_grid[i - 1][j] + obstacle_grid[i][j - 1]
      else
        obstacle_grid[i][j] = 0
      end
    end
  end
  
  obstacle_grid[m - 1][n - 1]
end

# テストケース
grid1 = [
  [0,0,0],
  [0,1,0],
  [0,0,0]
]
p unique_paths_with_obstacles(grid1)  # => 2

grid2 = [[0,1], [0,0]]
p unique_paths_with_obstacles(grid2)  # => 1

grid3 = [[1]]
p unique_paths_with_obstacles(grid3)  # => 0
```

---

## 問題8: 最長回文部分文字列

### 問題文

文字列が与えられます。最長の回文部分文字列を返してください。

**入力例:**

```text
s = "babad"
```

**出力例:**

```text
"bab" または "aba"
```

### アルゴリズム概説

DPまたは中心拡張法を使用します。`dp[i][j]` = s[i...j]が回文かどうか

**時間計算量:** O(n²)  
**空間計算量:** O(n²) - DP、O(1) - 中心拡張法

### 擬似コード

```text
関数 longest_palindrome(文字列):
    n = 文字列の長さ
    dp = n × n のfalse配列
    開始 = 0
    最大長 = 1
    
    # 長さ1
    各iについて:
        dp[i][i] = true
    
    # 長さ2
    各iについて（0からn-2まで）:
        もし 文字列[i] == 文字列[i+1] なら:
            dp[i][i+1] = true
            開始 = i
            最大長 = 2
    
    # 長さ3以上
    各長さについて（3からnまで）:
        各iについて:
            j = i + 長さ - 1
            
            もし 文字列[i] == 文字列[j] かつ dp[i+1][j-1] なら:
                dp[i][j] = true
                開始 = i
                最大長 = 長さ
    
    文字列[開始...開始 + 最大長] を返す
```

### 解答

```ruby
# 解法1: DP
def longest_palindrome(s)
  return '' if s.empty?
  
  n = s.length
  dp = Array.new(n) { Array.new(n, false) }
  start = 0
  max_len = 1
  
  # 長さ1
  n.times { |i| dp[i][i] = true }
  
  # 長さ2
  (0...n - 1).each do |i|
    if s[i] == s[i + 1]
      dp[i][i + 1] = true
      start = i
      max_len = 2
    end
  end
  
  # 長さ3以上
  (3..n).each do |len|
    (0..n - len).each do |i|
      j = i + len - 1
      
      if s[i] == s[j] && dp[i + 1][j - 1]
        dp[i][j] = true
        start = i
        max_len = len
      end
    end
  end
  
  s[start, max_len]
end

# 解法2: 中心拡張法
def longest_palindrome_expand(s)
  return '' if s.empty?
  
  start = 0
  max_len = 0
  
  s.length.times do |i|
    # 奇数長
    len1 = expand_around_center(s, i, i)
    # 偶数長
    len2 = expand_around_center(s, i, i + 1)
    
    len = [len1, len2].max
    
    if len > max_len
      max_len = len
      start = i - (len - 1) / 2
    end
  end
  
  s[start, max_len]
end

def expand_around_center(s, left, right)
  while left >= 0 && right < s.length && s[left] == s[right]
    left -= 1
    right += 1
  end
  
  right - left - 1
end

# 解法3: Manacherのアルゴリズム（O(n)）
def longest_palindrome_manacher(s)
  return '' if s.empty?
  
  # 文字列を変換（'#'を挿入）
  t = '#' + s.chars.join('#') + '#'
  n = t.length
  
  # 各位置を中心とする回文の半径
  p_arr = Array.new(n, 0)
  center = 0
  right = 0
  
  max_len = 0
  center_index = 0
  
  (0...n).each do |i|
    # ミラー位置
    mirror = 2 * center - i
    
    # 境界内であれば、ミラーの値を利用
    p_arr[i] = (right > i) ? [right - i, p_arr[mirror]].min : 0
    
    # 中心拡張
    while i + 1 + p_arr[i] < n && i - 1 - p_arr[i] >= 0 &&
          t[i + 1 + p_arr[i]] == t[i - 1 - p_arr[i]]
      p_arr[i] += 1
    end
    
    # 境界を更新
    if i + p_arr[i] > right
      center = i
      right = i + p_arr[i]
    end
    
    # 最大長を更新
    if p_arr[i] > max_len
      max_len = p_arr[i]
      center_index = i
    end
  end
  
  # 元の文字列でのインデックスに変換
  start = (center_index - max_len) / 2
  s[start, max_len]
end

# テストケース
p longest_palindrome("babad")  # => "bab" または "aba"
p longest_palindrome("cbbd")  # => "bb"
p longest_palindrome("a")  # => "a"
p longest_palindrome_expand("babad")  # => "bab" または "aba"
p longest_palindrome_manacher("babad")  # => "bab" または "aba"
```

---

## まとめ

このセクションでは、動的計画法の詳細な問題を学びました。

重要なポイントは以下の通りです。

1. 貰うDPと配るDPは同じ問題の異なるアプローチです
2. 二次元DPは多くの文字列・配列問題で有効です
3. 空間最適化で O(n) に削減できることが多いです
4. バックトラックで実際の解を復元できます
5. 状態遷移方程式を正確に定義することが重要です

動的計画法は、最適部分構造と重複部分問題を持つ問題に適用できます。ナップサック、LCS、LIS、編集距離など、多くの古典的問題がDPで解けます。
