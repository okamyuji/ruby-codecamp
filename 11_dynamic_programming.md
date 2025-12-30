# Ruby 3.4 初級者向け問題集 - Part 6: 再帰・動的計画法

## 概要

このセクションでは、再帰と動的計画法（DP）を学びます。再帰は問題を小さなサブ問題に分解する技法であり、動的計画法はサブ問題の結果をメモ化して効率を改善する手法です。

---

## 問題43: 階段の上り方

### 問題文

n段の階段があります。1回に1段または2段上ることができます。頂上に到達する方法は何通りありますか？

**入力例:**

```text
n = 4
```

**出力例:**

```text
5  # (1+1+1+1), (1+1+2), (1+2+1), (2+1+1), (2+2)
```

### アルゴリズム概説

n段目に到達するには、(n-1)段目から1段上るか、(n-2)段目から2段上るかのどちらかです。したがって、f(n) = f(n-1) + f(n-2)となり、フィボナッチ数列と同じ漸化式になります。

**時間計算量:** O(n) - 動的計画法  
**空間計算量:** O(1) - 最適化された場合

### 擬似コード

```text
関数 climb_stairs(n):
    もし n <= 2 なら:
        nを返す
    
    前々 = 1  # 1段の場合
    前 = 2    # 2段の場合
    
    3からnまで:
        現在 = 前 + 前々
        前々 = 前
        前 = 現在
    
    前を返す
```

### 解答

```ruby
# 解法1: 動的計画法（空間最適化、推奨）
def climb_stairs(n)
  return n if n <= 2
  
  # 直前の2つの値のみを保持
  prev_prev = 1  # f(1)
  prev = 2       # f(2)
  
  (3..n).each do
    current = prev + prev_prev
    prev_prev = prev
    prev = current
  end
  
  prev
end

# 解法2: 動的計画法（配列使用）
def climb_stairs_dp(n)
  return n if n <= 2
  
  # dp[i]はi段目に到達する方法の数
  dp = Array.new(n + 1)
  dp[1] = 1
  dp[2] = 2
  
  (3..n).each do |i|
    dp[i] = dp[i - 1] + dp[i - 2]
  end
  
  dp[n]
end

# 解法3: 再帰（メモ化あり）
def climb_stairs_memo(n, memo = {})
  return n if n <= 2
  return memo[n] if memo.key?(n)
  
  memo[n] = climb_stairs_memo(n - 1, memo) + climb_stairs_memo(n - 2, memo)
end

# 解法4: 再帰（メモ化なし、遅い）
def climb_stairs_naive(n)
  return n if n <= 2
  climb_stairs_naive(n - 1) + climb_stairs_naive(n - 2)
end

# 解法5: 行列累乗（高速）
def climb_stairs_matrix(n)
  return n if n <= 2
  
  # [[f(n+1), f(n)], [f(n), f(n-1)]] = [[1,1],[1,0]]^n
  matrix_power([[1, 1], [1, 0]], n)[0][0]
end

def matrix_multiply(a, b)
  [
    [a[0][0] * b[0][0] + a[0][1] * b[1][0], a[0][0] * b[0][1] + a[0][1] * b[1][1]],
    [a[1][0] * b[0][0] + a[1][1] * b[1][0], a[1][0] * b[0][1] + a[1][1] * b[1][1]]
  ]
end

def matrix_power(matrix, n)
  result = [[1, 0], [0, 1]]
  while n > 0
    result = matrix_multiply(result, matrix) if n.odd?
    matrix = matrix_multiply(matrix, matrix)
    n /= 2
  end
  result
end

# テストケース
puts climb_stairs(2)   # => 2
puts climb_stairs(3)   # => 3
puts climb_stairs(4)   # => 5
puts climb_stairs(5)   # => 8
puts climb_stairs(10)  # => 89
```

---

## 問題44: 最大部分配列和（Maximum Subarray）

### 問題文

整数の配列が与えられます。連続する部分配列の中で、合計が最大となるものを見つけ、その合計値を返してください。

**入力例:**

```text
[-2, 1, -3, 4, -1, 2, 1, -5, 4]
```

**出力例:**

```text
6  # [4, -1, 2, 1]の合計
```

### アルゴリズム概説

カダネのアルゴリズムを使用します。各位置で「その位置で終わる最大部分配列和」を計算し、全体の最大値を追跡します。

**時間計算量:** O(n) - 配列を一度走査  
**空間計算量:** O(1) - 定数量のメモリ

### 擬似コード

```text
関数 max_subarray(配列):
    現在の最大 = 配列[0]
    全体の最大 = 配列[0]
    
    配列の2番目以降の各要素について:
        # その位置で終わる最大部分配列和
        現在の最大 = max(要素, 現在の最大 + 要素)
        # 全体の最大を更新
        全体の最大 = max(全体の最大, 現在の最大)
    
    全体の最大を返す
```

### 解答

```ruby
# 解法1: カダネのアルゴリズム（推奨）
def max_subarray(nums)
  return nums[0] if nums.length == 1
  
  # 現在位置で終わる最大部分配列和
  current_max = nums[0]
  # 全体の最大部分配列和
  global_max = nums[0]
  
  nums[1..].each do |num|
    # 新しい部分配列を始めるか、既存の部分配列を延長するか
    current_max = [num, current_max + num].max
    # 全体の最大を更新
    global_max = [global_max, current_max].max
  end
  
  global_max
end

# 解法2: 動的計画法（配列使用）
def max_subarray_dp(nums)
  n = nums.length
  # dp[i]はインデックスiで終わる最大部分配列和
  dp = Array.new(n)
  dp[0] = nums[0]
  
  (1...n).each do |i|
    dp[i] = [nums[i], dp[i - 1] + nums[i]].max
  end
  
  dp.max
end

# 解法3: 分割統治法
def max_subarray_divide(nums)
  divide_and_conquer(nums, 0, nums.length - 1)
end

def divide_and_conquer(nums, left, right)
  return nums[left] if left == right
  
  mid = (left + right) / 2
  
  # 左半分の最大
  left_max = divide_and_conquer(nums, left, mid)
  # 右半分の最大
  right_max = divide_and_conquer(nums, mid + 1, right)
  # 中央をまたぐ最大
  cross_max = max_crossing_sum(nums, left, mid, right)
  
  [left_max, right_max, cross_max].max
end

def max_crossing_sum(nums, left, mid, right)
  # 中央から左に向かう最大和
  left_sum = -Float::INFINITY
  sum = 0
  mid.downto(left) do |i|
    sum += nums[i]
    left_sum = sum if sum > left_sum
  end
  
  # 中央から右に向かう最大和
  right_sum = -Float::INFINITY
  sum = 0
  (mid + 1..right).each do |i|
    sum += nums[i]
    right_sum = sum if sum > right_sum
  end
  
  left_sum + right_sum
end

# 解法4: 部分配列も返す
def max_subarray_with_indices(nums)
  current_max = nums[0]
  global_max = nums[0]
  start_idx = end_idx = temp_start = 0
  
  nums.each_with_index do |num, i|
    next if i == 0
    
    if num > current_max + num
      current_max = num
      temp_start = i
    else
      current_max += num
    end
    
    if current_max > global_max
      global_max = current_max
      start_idx = temp_start
      end_idx = i
    end
  end
  
  {
    sum: global_max,
    subarray: nums[start_idx..end_idx]
  }
end

# テストケース
puts max_subarray([-2, 1, -3, 4, -1, 2, 1, -5, 4])  # => 6
puts max_subarray([1])                               # => 1
puts max_subarray([5, 4, -1, 7, 8])                  # => 23
puts max_subarray([-1])                              # => -1
puts max_subarray([-2, -1])                          # => -1

p max_subarray_with_indices([-2, 1, -3, 4, -1, 2, 1, -5, 4])
# => {:sum=>6, :subarray=>[4, -1, 2, 1]}
```

---

## 問題45: コイン問題（最小枚数）

### 問題文

異なる金額のコインの配列と目標金額が与えられます。目標金額を作るのに必要な最小のコイン枚数を返してください。作れない場合は-1を返してください。

**入力例:**

```text
coins = [1, 2, 5]
amount = 11
```

**出力例:**

```text
3  # 5 + 5 + 1 = 11
```

### アルゴリズム概説

動的計画法を使用します。dp[i]を金額iを作るのに必要な最小枚数とし、各金額について全てのコインを試します。

**時間計算量:** O(amount × coins.length)  
**空間計算量:** O(amount)

### 擬似コード

```text
関数 coin_change(coins, amount):
    dp = 要素がamount+1（不可能を表す）の配列
    dp[0] = 0
    
    1からamountまでの各金額について:
        各コインについて:
            もし コイン <= 金額 なら:
                dp[金額] = min(dp[金額], dp[金額 - コイン] + 1)
    
    dp[amount] > amount なら -1 を返す
    そうでなければ dp[amount] を返す
```

### 解答

```ruby
# 解法1: 動的計画法（ボトムアップ、推奨）
def coin_change(coins, amount)
  return 0 if amount == 0
  
  # dp[i]は金額iを作るのに必要な最小コイン枚数
  # amount + 1 は不可能を表す（最大でもamount枚あれば作れる）
  dp = Array.new(amount + 1, amount + 1)
  dp[0] = 0
  
  (1..amount).each do |i|
    coins.each do |coin|
      if coin <= i
        # このコインを使う場合と使わない場合の最小を選択
        dp[i] = [dp[i], dp[i - coin] + 1].min
      end
    end
  end
  
  dp[amount] > amount ? -1 : dp[amount]
end

# 解法2: 動的計画法（メモ化再帰）
def coin_change_memo(coins, amount, memo = {})
  return 0 if amount == 0
  return -1 if amount < 0
  return memo[amount] if memo.key?(amount)
  
  min_coins = Float::INFINITY
  
  coins.each do |coin|
    result = coin_change_memo(coins, amount - coin, memo)
    if result >= 0 && result < min_coins
      min_coins = result + 1
    end
  end
  
  memo[amount] = min_coins == Float::INFINITY ? -1 : min_coins
end

# 解法3: BFS（最短経路として捉える）
def coin_change_bfs(coins, amount)
  return 0 if amount == 0
  
  visited = Array.new(amount + 1, false)
  queue = [[0, 0]]  # [現在の金額, コイン枚数]
  visited[0] = true
  
  while !queue.empty?
    current_amount, num_coins = queue.shift
    
    coins.each do |coin|
      new_amount = current_amount + coin
      
      return num_coins + 1 if new_amount == amount
      
      if new_amount < amount && !visited[new_amount]
        visited[new_amount] = true
        queue << [new_amount, num_coins + 1]
      end
    end
  end
  
  -1
end

# 解法4: 使用したコインも返す
def coin_change_with_coins(coins, amount)
  return { count: 0, coins_used: [] } if amount == 0
  
  dp = Array.new(amount + 1, amount + 1)
  dp[0] = 0
  parent = Array.new(amount + 1, -1)
  
  (1..amount).each do |i|
    coins.each do |coin|
      if coin <= i && dp[i - coin] + 1 < dp[i]
        dp[i] = dp[i - coin] + 1
        parent[i] = coin
      end
    end
  end
  
  return { count: -1, coins_used: [] } if dp[amount] > amount
  
  # 使用したコインを復元
  coins_used = []
  current = amount
  while current > 0
    coins_used << parent[current]
    current -= parent[current]
  end
  
  { count: dp[amount], coins_used: coins_used }
end

# テストケース
puts coin_change([1, 2, 5], 11)   # => 3
puts coin_change([2], 3)          # => -1
puts coin_change([1], 0)          # => 0
puts coin_change([1, 2, 5], 100)  # => 20

p coin_change_with_coins([1, 2, 5], 11)
# => {:count=>3, :coins_used=>[1, 5, 5]}
```

---

## 問題46: 家の盗み（House Robber）

### 問題文

各家に保管されている金額を表す配列が与えられます。隣接する2つの家を同時に盗むことはできません。盗むことができる最大金額を返してください。

**入力例:**

```text
[2, 7, 9, 3, 1]
```

**出力例:**

```text
12  # 2 + 9 + 1 = 12
```

### アルゴリズム概説

各家について、「この家を盗む（前の前までの最大 + この家）」と「この家を盗まない（前までの最大）」の大きい方を選択します。

**時間計算量:** O(n)  
**空間計算量:** O(1) - 最適化された場合

### 擬似コード

```text
関数 rob(nums):
    もし numsが空なら:
        0を返す
    もし numsが1要素なら:
        nums[0]を返す
    
    前々 = nums[0]
    前 = max(nums[0], nums[1])
    
    3番目以降の各要素について:
        現在 = max(前, 前々 + 要素)
        前々 = 前
        前 = 現在
    
    前を返す
```

### 解答

```ruby
# 解法1: 動的計画法（空間最適化、推奨）
def rob(nums)
  return 0 if nums.empty?
  return nums[0] if nums.length == 1
  
  # prev_prev: 2つ前までの最大金額
  # prev: 1つ前までの最大金額
  prev_prev = nums[0]
  prev = [nums[0], nums[1]].max
  
  nums[2..].each do |num|
    # この家を盗む場合と盗まない場合の最大
    current = [prev, prev_prev + num].max
    prev_prev = prev
    prev = current
  end
  
  prev
end

# 解法2: 動的計画法（配列使用）
def rob_dp(nums)
  return 0 if nums.empty?
  return nums[0] if nums.length == 1
  
  n = nums.length
  # dp[i]はi番目までの家での最大金額
  dp = Array.new(n)
  dp[0] = nums[0]
  dp[1] = [nums[0], nums[1]].max
  
  (2...n).each do |i|
    dp[i] = [dp[i - 1], dp[i - 2] + nums[i]].max
  end
  
  dp[n - 1]
end

# 解法3: メモ化再帰
def rob_memo(nums, i = nil, memo = {})
  i ||= nums.length - 1
  
  return 0 if i < 0
  return nums[0] if i == 0
  return memo[i] if memo.key?(i)
  
  # この家を盗むか盗まないか
  memo[i] = [
    rob_memo(nums, i - 1, memo),           # 盗まない
    rob_memo(nums, i - 2, memo) + nums[i]  # 盗む
  ].max
end

# 解法4: どの家を盗んだかも返す
def rob_with_houses(nums)
  return { amount: 0, houses: [] } if nums.empty?
  return { amount: nums[0], houses: [0] } if nums.length == 1
  
  n = nums.length
  dp = Array.new(n)
  houses = Array.new(n) { [] }
  
  dp[0] = nums[0]
  houses[0] = [0]
  
  if nums[1] > nums[0]
    dp[1] = nums[1]
    houses[1] = [1]
  else
    dp[1] = nums[0]
    houses[1] = [0]
  end
  
  (2...n).each do |i|
    if dp[i - 2] + nums[i] > dp[i - 1]
      dp[i] = dp[i - 2] + nums[i]
      houses[i] = houses[i - 2] + [i]
    else
      dp[i] = dp[i - 1]
      houses[i] = houses[i - 1]
    end
  end
  
  { amount: dp[n - 1], houses: houses[n - 1] }
end

# テストケース
puts rob([2, 7, 9, 3, 1])   # => 12
puts rob([1, 2, 3, 1])      # => 4
puts rob([1])               # => 1
puts rob([])                # => 0
puts rob([2, 1, 1, 2])      # => 4

p rob_with_houses([2, 7, 9, 3, 1])
# => {:amount=>12, :houses=>[0, 2, 4]}
```

---

## 問題47: 再帰的な累乗和

### 問題文

正の整数nが与えられます。1からnまでの整数の2乗の合計を再帰を使って計算してください。

**入力例:**

```text
n = 5
```

**出力例:**

```text
55  # 1² + 2² + 3² + 4² + 5² = 1 + 4 + 9 + 16 + 25 = 55
```

### アルゴリズム概説

f(n) = n² + f(n-1)という漸化式を使用します。ベースケースはf(0) = 0またはf(1) = 1です。

**時間計算量:** O(n)  
**空間計算量:** O(n) - 再帰スタック

### 擬似コード

```text
関数 sum_of_squares(n):
    もし n == 0 なら:
        0を返す
    n² + sum_of_squares(n - 1) を返す
```

### 解答

```ruby
# 解法1: 再帰
def sum_of_squares_recursive(n)
  return 0 if n == 0
  n * n + sum_of_squares_recursive(n - 1)
end

# 解法2: 末尾再帰
def sum_of_squares_tail(n, acc = 0)
  return acc if n == 0
  sum_of_squares_tail(n - 1, acc + n * n)
end

# 解法3: 反復
def sum_of_squares_iterative(n)
  sum = 0
  (1..n).each { |i| sum += i * i }
  sum
end

# 解法4: reduceを使用
def sum_of_squares_reduce(n)
  (1..n).reduce(0) { |sum, i| sum + i * i }
end

# 解法5: sumを使用
def sum_of_squares_sum(n)
  (1..n).sum { |i| i * i }
end

# 解法6: 数学公式を使用（最速）
# n(n+1)(2n+1) / 6
def sum_of_squares_formula(n)
  n * (n + 1) * (2 * n + 1) / 6
end

# 発展: k乗の和
def sum_of_powers(n, k)
  (1..n).sum { |i| i ** k }
end

# テストケース
puts sum_of_squares_recursive(5)  # => 55
puts sum_of_squares_tail(5)       # => 55
puts sum_of_squares_formula(5)    # => 55
puts sum_of_squares_recursive(10) # => 385
puts sum_of_squares_formula(100)  # => 338350

puts sum_of_powers(5, 3)  # => 225 (1³ + 2³ + 3³ + 4³ + 5³)
```

---

## 問題48: パスカルの三角形

### 問題文

非負整数numRowsが与えられます。パスカルの三角形の最初のnumRows行を生成してください。

**入力例:**

```text
numRows = 5
```

**出力例:**

```text
[
  [1],
  [1, 1],
  [1, 2, 1],
  [1, 3, 3, 1],
  [1, 4, 6, 4, 1]
]
```

### アルゴリズム概説

各行の両端は1であり、内部の要素は上の行の隣接する2つの要素の和です。各行を順番に生成します。

**時間計算量:** O(numRows²)  
**空間計算量:** O(numRows²) - 結果を格納

### 擬似コード

```text
関数 generate_pascal(numRows):
    結果 = [[1]]
    
    2行目からnumRows行目まで:
        前の行 = 結果の最後の行
        新しい行 = [1]
        
        前の行の隣接ペアについて:
            新しい行に合計を追加
        
        新しい行に1を追加
        結果に新しい行を追加
    
    結果を返す
```

### 解答

```ruby
# 解法1: 反復法（推奨）
def generate_pascal(num_rows)
  return [] if num_rows == 0
  
  result = [[1]]
  
  (1...num_rows).each do |i|
    prev_row = result.last
    new_row = [1]
    
    # 前の行の隣接要素を加算
    (0...(prev_row.length - 1)).each do |j|
      new_row << prev_row[j] + prev_row[j + 1]
    end
    
    new_row << 1
    result << new_row
  end
  
  result
end

# 解法2: each_consを使用
def generate_pascal_cons(num_rows)
  return [] if num_rows == 0
  
  result = [[1]]
  
  (1...num_rows).each do
    prev = result.last
    # each_cons(2)で隣接ペアを取得
    middle = prev.each_cons(2).map { |a, b| a + b }
    result << [1] + middle + [1]
  end
  
  result
end

# 解法3: 再帰
def generate_pascal_recursive(num_rows)
  return [] if num_rows == 0
  return [[1]] if num_rows == 1
  
  prev = generate_pascal_recursive(num_rows - 1)
  last_row = prev.last
  
  new_row = [1]
  (0...(last_row.length - 1)).each do |i|
    new_row << last_row[i] + last_row[i + 1]
  end
  new_row << 1
  
  prev + [new_row]
end

# 解法4: 二項係数を使用
def generate_pascal_binomial(num_rows)
  (0...num_rows).map do |n|
    (0..n).map { |k| binomial(n, k) }
  end
end

def binomial(n, k)
  return 1 if k == 0 || k == n
  
  # C(n, k) = n! / (k! * (n-k)!)
  # オーバーフローを避けるため、逐次計算
  result = 1
  (1..k).each do |i|
    result = result * (n - i + 1) / i
  end
  result
end

# 発展: 特定の行のみを取得
def get_pascal_row(row_index)
  row = [1]
  
  (1..row_index).each do |i|
    # C(n, k) = C(n, k-1) * (n - k + 1) / k
    row << row.last * (row_index - i + 1) / i
  end
  
  row
end

# テストケース
p generate_pascal(5)
# => [[1], [1, 1], [1, 2, 1], [1, 3, 3, 1], [1, 4, 6, 4, 1]]

p generate_pascal(1)
# => [[1]]

p generate_pascal(0)
# => []

p get_pascal_row(4)
# => [1, 4, 6, 4, 1]
```

---

## 問題49: 文字列の順列

### 問題文

文字列が与えられます。その文字列のすべての順列（並べ替え）を生成してください。

**入力例:**

```text
"abc"
```

**出力例:**

```text
["abc", "acb", "bac", "bca", "cab", "cba"]
```

### アルゴリズム概説

バックトラッキングを使用します。各位置で残りの文字を1つずつ選び、再帰的に残りの部分の順列を生成します。

**時間計算量:** O(n × n!) - n!個の順列、各順列はO(n)  
**空間計算量:** O(n) - 再帰スタックの深さ

### 擬似コード

```text
関数 permutations(文字列):
    もし 文字列が空または1文字なら:
        [文字列]を返す
    
    結果 = 空配列
    
    文字列の各文字について:
        残り = その文字を除いた文字列
        残りの順列それぞれについて:
            結果に (文字 + 順列) を追加
    
    結果を返す
```

### 解答

```ruby
# 解法1: 組み込みメソッドを使用（推奨）
def permutations(str)
  str.chars.permutation.map(&:join)
end

# 解法2: 再帰的な実装
def permutations_recursive(str)
  return [str] if str.length <= 1
  
  result = []
  
  str.chars.each_with_index do |char, i|
    # 現在の文字を除いた残りの文字列
    remaining = str[0...i] + str[(i + 1)..]
    
    # 残りの文字列の順列を再帰的に取得
    permutations_recursive(remaining).each do |perm|
      result << char + perm
    end
  end
  
  result
end

# 解法3: バックトラッキング
def permutations_backtrack(str)
  result = []
  chars = str.chars
  
  backtrack(chars, 0, result)
  result.map(&:join)
end

def backtrack(chars, start, result)
  if start == chars.length
    result << chars.dup
    return
  end
  
  (start...chars.length).each do |i|
    # 現在位置とi番目を交換
    chars[start], chars[i] = chars[i], chars[start]
    
    # 次の位置で再帰
    backtrack(chars, start + 1, result)
    
    # 交換を元に戻す（バックトラック）
    chars[start], chars[i] = chars[i], chars[start]
  end
end

# 解法4: 重複を含む場合の対応
def permutations_unique(str)
  str.chars.permutation.map(&:join).uniq
end

# 解法5: イテレータとして実装
def each_permutation(str, &block)
  return to_enum(:each_permutation, str) unless block_given?
  
  str.chars.permutation { |perm| block.call(perm.join) }
end

# テストケース
p permutations("abc")
# => ["abc", "acb", "bac", "bca", "cab", "cba"]

p permutations_recursive("ab")
# => ["ab", "ba"]

p permutations("a")
# => ["a"]

p permutations_unique("aab")
# => ["aab", "aba", "baa"]

each_permutation("xy") { |p| puts p }
# => "xy"
# => "yx"
```

---

## 問題50: 部分集合（Subsets）

### 問題文

重複のない整数の配列が与えられます。すべての部分集合（べき集合）を返してください。

**入力例:**

```text
[1, 2, 3]
```

**出力例:**

```text
[[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
```

### アルゴリズム概説

各要素について「含む」か「含まない」の2択があります。ビット演算またはバックトラッキングで生成できます。

**時間計算量:** O(n × 2^n) - 2^n個の部分集合  
**空間計算量:** O(n × 2^n) - 結果を格納

### 擬似コード

```text
関数 subsets(配列):
    結果 = [[]]  # 空集合を含む
    
    配列の各要素について:
        結果の各部分集合について:
            結果に (部分集合 + [要素]) を追加
    
    結果を返す
```

### 解答

```ruby
# 解法1: 組み込みメソッドを使用
def subsets(nums)
  (0..nums.length).flat_map { |k| nums.combination(k).to_a }
end

# 解法2: 反復的に構築（推奨）
def subsets_iterative(nums)
  result = [[]]
  
  nums.each do |num|
    # 既存の各部分集合にnumを追加した新しい部分集合を作成
    new_subsets = result.map { |subset| subset + [num] }
    result.concat(new_subsets)
  end
  
  result
end

# 解法3: バックトラッキング
def subsets_backtrack(nums)
  result = []
  backtrack_subsets(nums, 0, [], result)
  result
end

def backtrack_subsets(nums, start, current, result)
  # 現在の部分集合を結果に追加
  result << current.dup
  
  (start...nums.length).each do |i|
    # 要素を追加
    current << nums[i]
    # 次の要素から再帰
    backtrack_subsets(nums, i + 1, current, result)
    # バックトラック
    current.pop
  end
end

# 解法4: ビット演算を使用
def subsets_bit(nums)
  n = nums.length
  result = []
  
  # 0から2^n - 1までの各数をビットマスクとして使用
  (0...(1 << n)).each do |mask|
    subset = []
    
    (0...n).each do |i|
      # i番目のビットが1なら、nums[i]を含める
      subset << nums[i] if (mask & (1 << i)) != 0
    end
    
    result << subset
  end
  
  result
end

# 解法5: 再帰的な実装
def subsets_recursive(nums)
  return [[]] if nums.empty?
  
  first = nums[0]
  rest = nums[1..]
  
  # 残りの要素の部分集合
  rest_subsets = subsets_recursive(rest)
  
  # firstを含む部分集合と含まない部分集合
  rest_subsets + rest_subsets.map { |s| [first] + s }
end

# 発展: 重複を含む配列の部分集合
def subsets_with_dup(nums)
  nums.sort!
  result = [[]]
  start = 0
  
  nums.each_with_index do |num, i|
    # 重複の場合は前回追加した部分集合のみを拡張
    start = result.length - (i > 0 && nums[i] == nums[i - 1] ? start : 0)
    
    new_subsets = result[start..].map { |subset| subset + [num] }
    start = result.length
    result.concat(new_subsets)
  end
  
  result
end

# テストケース
p subsets([1, 2, 3])
# => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

p subsets_iterative([1, 2])
# => [[], [1], [2], [1, 2]]

p subsets_bit([1, 2, 3])
# => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

p subsets([])
# => [[]]

p subsets_with_dup([1, 2, 2])
# => [[], [1], [2], [1, 2], [2, 2], [1, 2, 2]]
```

---

## まとめ

このセクションでは、再帰と動的計画法を8問を通じて学びました。

**学んだ主なアルゴリズム:**

| 問題 | アルゴリズム | 時間計算量 | ポイント |
| ---- | ------------ | ---------- | -------- |
| 階段の上り方 | DP | O(n) | フィボナッチと同じ構造 |
| 最大部分配列和 | カダネ | O(n) | 現在の最大を追跡 |
| コイン問題 | DP | O(n×m) | ボトムアップ構築 |
| 家の盗み | DP | O(n) | 隣接制約の処理 |
| 累乗和 | 再帰 | O(n) | 数学公式も利用可 |
| パスカルの三角形 | 反復/再帰 | O(n²) | 漸化式の利用 |
| 順列 | バックトラック | O(n×n!) | 全探索 |
| 部分集合 | ビット/再帰 | O(n×2^n) | べき集合の生成 |

**重要なポイント:**

1. **再帰の基本構造:** ベースケース + 再帰ステップ
2. **メモ化:** 重複するサブ問題の結果を保存
3. **ボトムアップDP:** 小さな問題から大きな問題へ
4. **空間最適化:** 必要な状態のみを保持
5. **バックトラッキング:** 探索と元に戻す操作の組み合わせ

**動的計画法のパターン:**

- **1次元DP:** 階段、家の盗み
- **2次元DP:** より複雑な状態遷移
- **メモ化再帰:** トップダウンアプローチ

この問題集を通じて、Rubyでの基本的なアルゴリズム実装を習得できます。
