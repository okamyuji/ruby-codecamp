# 配列と文字列 - 基礎（スタック）

## 概要

このセクションでは、スタックデータ構造とその応用を学びます。スタックはLIFO（Last In First Out）の原則に従うデータ構造で、括弧の対応確認、式の評価、単調スタックなど、多くの問題に使用されます。

---

## 問題1: 有効な括弧

### 問題文

'(', ')', '{', '}', '[', ']' のみを含む文字列が与えられます。入力文字列が有効かどうかを判定してください。

有効な文字列は以下の条件を満たします:

1. 開き括弧は同じ種類の閉じ括弧で閉じられる
2. 開き括弧は正しい順序で閉じられる

**入力例:**

```text
"()[]{}"
```

**出力例:**

```text
true
```

### アルゴリズム概説

スタックを使用して開き括弧を記録し、閉じ括弧が現れたら対応する開き括弧とマッチするか確認します。

**時間計算量:** O(n)  
**空間計算量:** O(n)

### 擬似コード

```text
関数 is_valid(文字列):
    スタック = 空スタック
    
    文字列の各文字について:
        もし 開き括弧なら:
            スタックに追加
        そうでなければ:  # 閉じ括弧
            もし スタックが空 なら:
                false を返す
            
            開き = スタックからpop
            もし 開きと閉じが対応しない なら:
                false を返す
    
    スタックが空かどうかを返す
```

### 解答

```ruby
# 解法1: スタックとハッシュを使用
def is_valid(s)
  stack = []
  pairs = { '(' => ')', '{' => '}', '[' => ']' }
  
  s.each_char do |char|
    if pairs.key?(char)
      stack << char
    else
      return false if stack.empty?
      
      opening = stack.pop
      return false if pairs[opening] != char
    end
  end
  
  stack.empty?
end

# 解法2: 逆マッピングを使用
def is_valid_reverse_map(s)
  stack = []
  closing = { ')' => '(', '}' => '{', ']' => '[' }
  
  s.each_char do |char|
    if closing.key?(char)
      return false if stack.empty? || stack.pop != closing[char]
    else
      stack << char
    end
  end
  
  stack.empty?
end

# 解法3: caseを使用
def is_valid_case(s)
  stack = []
  
  s.each_char do |char|
    case char
    when '(', '{', '['
      stack << char
    when ')'
      return false if stack.empty? || stack.pop != '('
    when '}'
      return false if stack.empty? || stack.pop != '{'
    when ']'
      return false if stack.empty? || stack.pop != '['
    end
  end
  
  stack.empty?
end

# テストケース
p is_valid("()")       # => true
p is_valid("()[]{}")   # => true
p is_valid("(]")       # => false
p is_valid("([)]")     # => false
p is_valid("{[]}")     # => true
```

---

## 問題2: 最小値を返すスタック

### 問題文

push、pop、topの各操作に加えて、最小要素を定数時間で取得できるスタックを実装してください。

**入力例:**

```ruby
min_stack = MinStack.new
min_stack.push(-2)
min_stack.push(0)
min_stack.push(-3)
min_stack.get_min  # => -3
min_stack.pop
min_stack.top      # => 0
min_stack.get_min  # => -2
```

### アルゴリズム概説

メインのスタックとは別に、最小値を記録するスタックを維持します。各操作で両方のスタックを更新します。

**時間計算量:** すべての操作でO(1)  
**空間計算量:** O(n)

### 擬似コード

```text
クラス MinStack:
    初期化:
        メインスタック = 空
        最小スタック = 空
    
    push(値):
        メインスタックに値を追加
        
        もし 最小スタックが空 または 値 <= 最小スタックの先頭 なら:
            最小スタックに値を追加
    
    pop():
        値 = メインスタックからpop
        
        もし 値 == 最小スタックの先頭 なら:
            最小スタックからpop
    
    top():
        メインスタックの先頭を返す
    
    get_min():
        最小スタックの先頭を返す
```

### 解答

```ruby
# 解法1: 2つのスタックを使用
class MinStack
  def initialize
    @stack = []
    @min_stack = []
  end
  
  def push(val)
    @stack << val
    
    if @min_stack.empty? || val <= @min_stack.last
      @min_stack << val
    end
  end
  
  def pop
    val = @stack.pop
    
    @min_stack.pop if val == @min_stack.last
    
    val
  end
  
  def top
    @stack.last
  end
  
  def get_min
    @min_stack.last
  end
end

# 解法2: ペアでスタックに格納
class MinStack2
  def initialize
    @stack = []  # [value, min_so_far]のペアを格納
  end
  
  def push(val)
    min_val = @stack.empty? ? val : [val, @stack.last[1]].min
    @stack << [val, min_val]
  end
  
  def pop
    @stack.pop[0]
  end
  
  def top
    @stack.last[0]
  end
  
  def get_min
    @stack.last[1]
  end
end

# 解法3: 差分を記録（スペース最適化版）
class MinStack3
  def initialize
    @stack = []
    @min = nil
  end
  
  def push(val)
    if @stack.empty?
      @stack << 0
      @min = val
    else
      @stack << val - @min
      @min = val if val < @min
    end
  end
  
  def pop
    diff = @stack.pop
    
    if diff < 0
      val = @min
      @min = @min - diff
      val
    else
      @min + diff
    end
  end
  
  def top
    diff = @stack.last
    diff < 0 ? @min : @min + diff
  end
  
  def get_min
    @min
  end
end

# テストケース
min_stack = MinStack.new
min_stack.push(-2)
min_stack.push(0)
min_stack.push(-3)
p min_stack.get_min  # => -3
min_stack.pop
p min_stack.top      # => 0
p min_stack.get_min  # => -2
```

---

## 問題3: 逆ポーランド記法の評価

### 問題文

逆ポーランド記法（後置記法）で表現された算術式を評価してください。

**入力例:**

```text
["2", "1", "+", "3", "*"]
```

**出力例:**

```text
9  # ((2 + 1) * 3) = 9
```

### アルゴリズム概説

スタックを使用します。数値はスタックにpush、演算子は2つの数値をpopして計算し、結果をpushします。

**時間計算量:** O(n)  
**空間計算量:** O(n)

### 擬似コード

```text
関数 eval_rpn(トークン配列):
    スタック = 空スタック
    
    各トークンについて:
        もし 数値なら:
            スタックに数値を追加
        そうでなければ:  # 演算子
            右 = スタックからpop
            左 = スタックからpop
            結果 = 左 演算子 右
            スタックに結果を追加
    
    スタックの唯一の要素を返す
```

### 解答

```ruby
# 解法1: 基本的な実装
def eval_rpn(tokens)
  stack = []
  operators = %w[+ - * /]
  
  tokens.each do |token|
    if operators.include?(token)
      right = stack.pop
      left = stack.pop
      
      result = case token
               when '+'
                 left + right
               when '-'
                 left - right
               when '*'
                 left * right
               when '/'
                 (left.to_f / right).to_i
               end
      
      stack << result
    else
      stack << token.to_i
    end
  end
  
  stack[0]
end

# 解法2: sendを使用
def eval_rpn_send(tokens)
  stack = []
  
  tokens.each do |token|
    if %w[+ - * /].include?(token)
      right = stack.pop
      left = stack.pop
      
      result = if token == '/'
                 (left.to_f / right).to_i
               else
                 left.send(token, right)
               end
      
      stack << result
    else
      stack << token.to_i
    end
  end
  
  stack[0]
end

# 解法3: ハッシュで演算子を管理
def eval_rpn_hash(tokens)
  stack = []
  
  operations = {
    '+' => ->(a, b) { a + b },
    '-' => ->(a, b) { a - b },
    '*' => ->(a, b) { a * b },
    '/' => ->(a, b) { (a.to_f / b).to_i }
  }
  
  tokens.each do |token|
    if operations.key?(token)
      right = stack.pop
      left = stack.pop
      stack << operations[token].call(left, right)
    else
      stack << token.to_i
    end
  end
  
  stack[0]
end

# テストケース
p eval_rpn(["2", "1", "+", "3", "*"])  # => 9
p eval_rpn(["4", "13", "5", "/", "+"])  # => 6
p eval_rpn(["10", "6", "9", "3", "+", "-11", "*", "/", "*", "17", "+", "5", "+"])  # => 22
```

---

## 問題4: 次に大きい要素

### 問題文

整数の配列が与えられます。各要素について、その右側で最初に現れる、その要素より大きい要素を見つけてください。存在しない場合は-1を返します。

**入力例:**

```text
[4, 5, 2, 10, 8]
```

**出力例:**

```text
[5, 10, 10, -1, -1]
```

### アルゴリズム概説

単調減少スタック（monotonic decreasing stack）を使用します。スタックには未解決の要素のインデックスを格納します。

**時間計算量:** O(n)  
**空間計算量:** O(n)

### 擬似コード

```text
関数 next_greater_element(配列):
    n = 配列の長さ
    結果 = サイズnの配列（-1で初期化）
    スタック = 空スタック  # インデックスを格納
    
    各インデックスiについて:
        スタックが空でない かつ 配列[i] > 配列[スタックの先頭] の間:
            インデックス = スタックからpop
            結果[インデックス] = 配列[i]
        
        スタックにiを追加
    
    結果を返す
```

### 解答

```ruby
# 解法1: 単調減少スタック
def next_greater_element(nums)
  n = nums.length
  result = Array.new(n, -1)
  stack = []  # インデックスを格納
  
  nums.each_with_index do |num, i|
    # 現在の要素より小さいスタック上の要素を解決
    while !stack.empty? && nums[stack.last] < num
      idx = stack.pop
      result[idx] = num
    end
    
    stack << i
  end
  
  result
end

# 解法2: 右から左へスキャン
def next_greater_element_reverse(nums)
  n = nums.length
  result = Array.new(n, -1)
  stack = []
  
  (n - 1).downto(0) do |i|
    # 現在の要素以下のスタック上の要素を削除
    stack.pop while !stack.empty? && stack.last <= nums[i]
    
    result[i] = stack.last if !stack.empty?
    stack << nums[i]
  end
  
  result
end

# 解法3: ブルートフォース（比較用）
def next_greater_element_brute(nums)
  nums.map.with_index do |num, i|
    found = -1
    
    (i + 1...nums.length).each do |j|
      if nums[j] > num
        found = nums[j]
        break
      end
    end
    
    found
  end
end

# テストケース
p next_greater_element([4, 5, 2, 10, 8])
# => [5, 10, 10, -1, -1]

p next_greater_element([1, 2, 3, 4, 5])
# => [2, 3, 4, 5, -1]

p next_greater_element([5, 4, 3, 2, 1])
# => [-1, -1, -1, -1, -1]
```

---

## 問題5: 毎日の気温

### 問題文

日ごとの気温を表す整数の配列が与えられます。各日について、より暖かい気温になるまでの日数を返してください。より暖かい日が来ない場合は0を返します。

**入力例:**

```text
[73, 74, 75, 71, 69, 72, 76, 73]
```

**出力例:**

```text
[1, 1, 4, 2, 1, 1, 0, 0]
```

### アルゴリズム概説

単調減少スタックを使用して、次に大きい要素までのインデックスの差を計算します。

**時間計算量:** O(n)  
**空間計算量:** O(n)

### 擬似コード

```text
関数 daily_temperatures(気温配列):
    n = 配列の長さ
    結果 = サイズnの配列（0で初期化）
    スタック = 空スタック  # インデックスを格納
    
    各インデックスiについて:
        スタックが空でない かつ 気温[i] > 気温[スタックの先頭] の間:
            前の日 = スタックからpop
            結果[前の日] = i - 前の日
        
        スタックにiを追加
    
    結果を返す
```

### 解答

```ruby
# 解法1: 単調減少スタック
def daily_temperatures(temperatures)
  n = temperatures.length
  result = Array.new(n, 0)
  stack = []
  
  temperatures.each_with_index do |temp, i|
    # より暖かい日が来た
    while !stack.empty? && temperatures[stack.last] < temp
      prev_day = stack.pop
      result[prev_day] = i - prev_day
    end
    
    stack << i
  end
  
  result
end

# 解法2: 右から左へスキャン
def daily_temperatures_reverse(temperatures)
  n = temperatures.length
  result = Array.new(n, 0)
  stack = []
  
  (n - 1).downto(0) do |i|
    # 現在以下の気温をスタックから削除
    stack.pop while !stack.empty? && temperatures[stack.last] <= temperatures[i]
    
    result[i] = stack.last - i if !stack.empty?
    stack << i
  end
  
  result
end

# 解法3: 最適化版（配列をスタックとして使用）
def daily_temperatures_optimized(temperatures)
  n = temperatures.length
  result = Array.new(n, 0)
  hottest = 0
  
  (n - 1).downto(0) do |i|
    current = temperatures[i]
    
    if current >= hottest
      hottest = current
      next
    end
    
    days = 1
    
    while temperatures[i + days] <= current
      days += result[i + days]
    end
    
    result[i] = days
  end
  
  result
end

# テストケース
p daily_temperatures([73, 74, 75, 71, 69, 72, 76, 73])
# => [1, 1, 4, 2, 1, 1, 0, 0]

p daily_temperatures([30, 40, 50, 60])
# => [1, 1, 1, 0]

p daily_temperatures([30, 60, 90])
# => [1, 1, 0]
```

---

## 問題6: 最大長方形の面積（ヒストグラム）

### 問題文

各バーの高さを表す整数の配列が与えられます。ヒストグラムにおける最大の長方形の面積を求めてください。

**入力例:**

```text
[2, 1, 5, 6, 2, 3]
```

**出力例:**

```text
10  # インデックス2-3の高さ5の長方形（5 * 2 = 10）
```

### アルゴリズム概説

単調増加スタックを使用します。高さが減少する位置で、スタック上の各バーを右端として長方形を計算します。

**時間計算量:** O(n)  
**空間計算量:** O(n)

### 擬似コード

```text
関数 largest_rectangle_area(高さ配列):
    スタック = 空スタック  # インデックスを格納
    最大面積 = 0
    
    各インデックスiについて:
        現在の高さ = 高さ配列[i]
        
        スタックが空でない かつ 現在の高さ < 高さ配列[スタックの先頭] の間:
            高さインデックス = スタックからpop
            高さ = 高さ配列[高さインデックス]
            
            幅 = スタックが空 ? i : i - スタックの先頭 - 1
            面積 = 高さ * 幅
            最大面積 = max(最大面積, 面積)
        
        スタックにiを追加
    
    # 残りのバーを処理
    スタックが空でない間:
        ...同様の処理...
    
    最大面積を返す
```

### 解答

```ruby
# 解法1: 単調増加スタック
def largest_rectangle_area(heights)
  stack = []
  max_area = 0
  heights << 0  # 番兵を追加
  
  heights.each_with_index do |h, i|
    while !stack.empty? && heights[stack.last] > h
      height_idx = stack.pop
      height = heights[height_idx]
      width = stack.empty? ? i : i - stack.last - 1
      area = height * width
      max_area = [max_area, area].max
    end
    
    stack << i
  end
  
  heights.pop  # 番兵を削除
  max_area
end

# 解法2: スタックなし（分割統治）
def largest_rectangle_area_divide_conquer(heights)
  return 0 if heights.empty?
  
  helper(heights, 0, heights.length - 1)
end

def helper(heights, left, right)
  return 0 if left > right
  
  # 最小の高さのインデックスを見つける
  min_idx = left
  (left..right).each do |i|
    min_idx = i if heights[i] < heights[min_idx]
  end
  
  # 3つの選択肢の最大値
  # 1. 最小高さを含む長方形
  # 2. 左部分の最大
  # 3. 右部分の最大
  [
    heights[min_idx] * (right - left + 1),
    helper(heights, left, min_idx - 1),
    helper(heights, min_idx + 1, right)
  ].max
end

# 解法3: 左右の境界を事前計算
def largest_rectangle_area_precompute(heights)
  n = heights.length
  return 0 if n.zero?
  
  # 各バーについて、左側の小さいバーと右側の小さいバーを見つける
  left = Array.new(n)
  right = Array.new(n)
  
  # 左側の境界
  left[0] = -1
  (1...n).each do |i|
    p = i - 1
    p = left[p] while p >= 0 && heights[p] >= heights[i]
    left[i] = p
  end
  
  # 右側の境界
  right[n - 1] = n
  (n - 2).downto(0) do |i|
    p = i + 1
    p = right[p] while p < n && heights[p] >= heights[i]
    right[i] = p
  end
  
  # 最大面積を計算
  max_area = 0
  n.times do |i|
    width = right[i] - left[i] - 1
    area = heights[i] * width
    max_area = [max_area, area].max
  end
  
  max_area
end

# テストケース
p largest_rectangle_area([2, 1, 5, 6, 2, 3])  # => 10
p largest_rectangle_area([2, 4])              # => 4
p largest_rectangle_area([1, 1])              # => 2
p largest_rectangle_area([2, 1, 2])           # => 3
```

---

## 問題7: 単調増加スタック - 次に小さい要素

### 問題文

整数の配列が与えられます。各要素について、その右側で最初に現れる、その要素より小さい要素を見つけてください。存在しない場合は-1を返します。

**入力例:**

```text
[4, 5, 2, 10, 8]
```

**出力例:**

```text
[2, 2, -1, 8, -1]
```

### アルゴリズム概説

単調増加スタック（monotonic increasing stack）を使用します。

**時間計算量:** O(n)  
**空間計算量:** O(n)

### 擬似コード

```text
関数 next_smaller_element(配列):
    n = 配列の長さ
    結果 = サイズnの配列（-1で初期化）
    スタック = 空スタック  # インデックスを格納
    
    各インデックスiについて:
        スタックが空でない かつ 配列[i] < 配列[スタックの先頭] の間:
            インデックス = スタックからpop
            結果[インデックス] = 配列[i]
        
        スタックにiを追加
    
    結果を返す
```

### 解答

```ruby
# 解法1: 単調増加スタック
def next_smaller_element(nums)
  n = nums.length
  result = Array.new(n, -1)
  stack = []
  
  nums.each_with_index do |num, i|
    while !stack.empty? && nums[stack.last] > num
      idx = stack.pop
      result[idx] = num
    end
    
    stack << i
  end
  
  result
end

# 解法2: 右から左へスキャン
def next_smaller_element_reverse(nums)
  n = nums.length
  result = Array.new(n, -1)
  stack = []
  
  (n - 1).downto(0) do |i|
    stack.pop while !stack.empty? && stack.last >= nums[i]
    
    result[i] = stack.last if !stack.empty?
    stack << nums[i]
  end
  
  result
end

# テストケース
p next_smaller_element([4, 5, 2, 10, 8])
# => [2, 2, -1, 8, -1]

p next_smaller_element([3, 2, 1, 4, 5])
# => [2, 1, -1, -1, -1]
```

---

## 問題8: 株の売買（スパン）

### 問題文

株価の配列が与えられます。各日について、その日の株価スパン（その日以前の連続した、その日の株価以下の日数）を計算してください。

**入力例:**

```text
[100, 80, 60, 70, 60, 75, 85]
```

**出力例:**

```text
[1, 1, 1, 2, 1, 4, 6]
```

### アルゴリズム概説

単調減少スタックを使用して、各日より大きい株価の日を見つけます。

**時間計算量:** O(n)  
**空間計算量:** O(n)

### 擬似コード

```text
関数 stock_span(株価配列):
    n = 配列の長さ
    スパン = サイズnの配列（1で初期化）
    スタック = 空スタック  # インデックスを格納
    
    各インデックスiについて:
        スタックが空でない かつ 株価[i] >= 株価[スタックの先頭] の間:
            スタックからpop
        
        スパン[i] = スタックが空 ? i + 1 : i - スタックの先頭
        
        スタックにiを追加
    
    スパンを返す
```

### 解答

```ruby
# 解法1: 単調減少スタック
def stock_span(prices)
  n = prices.length
  span = Array.new(n, 1)
  stack = []
  
  prices.each_with_index do |price, i|
    # 現在の株価以下の日をスタックから削除
    stack.pop while !stack.empty? && prices[stack.last] <= price
    
    span[i] = stack.empty? ? i + 1 : i - stack.last
    
    stack << i
  end
  
  span
end

# 解法2: クラスとして実装
class StockSpanner
  def initialize
    @prices = []
    @stack = []
  end
  
  def next(price)
    @prices << price
    i = @prices.length - 1
    
    @stack.pop while !@stack.empty? && @prices[@stack.last] <= price
    
    span = @stack.empty? ? i + 1 : i - @stack.last
    
    @stack << i
    
    span
  end
end

# テストケース
p stock_span([100, 80, 60, 70, 60, 75, 85])
# => [1, 1, 1, 2, 1, 4, 6]

spanner = StockSpanner.new
p spanner.next(100)  # => 1
p spanner.next(80)   # => 1
p spanner.next(60)   # => 1
p spanner.next(70)   # => 2
p spanner.next(60)   # => 1
p spanner.next(75)   # => 4
p spanner.next(85)   # => 6
```

---

## まとめ

このセクションでは、スタックデータ構造とその応用を学びました。

重要なポイントは以下の通りです。

1. 括弧の対応チェックはスタックの典型的な応用です
2. 最小値を記録するには補助スタックを使用します
3. 逆ポーランド記法の評価はスタックで自然に実装できます
4. 単調スタックは「次に大きい/小さい要素」問題に有効です
5. ヒストグラムの最大長方形問題は単調増加スタックの応用です
6. スタックを使うことで多くの問題をO(n)で解けます

スタックは多くのアルゴリズム問題で重要な役割を果たします。特に単調スタックのパターンを理解することは、多くの実践的な問題を効率的に解く鍵となります。
