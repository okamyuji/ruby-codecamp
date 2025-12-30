# Ruby基礎と計算量

## 概要

このセクションでは、コーディング面接で必要なRubyの基礎知識と、アルゴリズムの効率を評価するための計算量（Big O記法）について学びます。これらはプログラミングとアルゴリズム解析の基盤となる重要な概念です。

## コーディング面接で必要なRubyの学習

### Rubyの基本的な特徴

Rubyはオブジェクト指向のスクリプト言語で、シンプルで読みやすい文法が特徴です。コーディング面接では、基本的な構文や組み込みメソッドを効率的に使用する能力が求められます。

### 配列（Array）

配列は順序付きの要素の集合です。Rubyでは非常に豊富な配列操作メソッドが用意されています。

```ruby
# 配列の作成
arr = [1, 2, 3, 4, 5]

# 要素へのアクセス
puts arr[0]        # => 1
puts arr[-1]       # => 5（末尾の要素）

# 要素の追加
arr << 6           # => [1, 2, 3, 4, 5, 6]
arr.push(7)        # => [1, 2, 3, 4, 5, 6, 7]

# 要素の削除
arr.pop            # => 7（末尾から削除）
arr.shift          # => 1（先頭から削除）

# 配列のイテレーション
arr.each { |x| puts x }
arr.map { |x| x * 2 }
arr.select { |x| x.even? }
arr.reduce(0) { |sum, x| sum + x }
```

### ハッシュ（Hash）

ハッシュはキーと値のペアを格納するデータ構造です。O(1)の平均時間で要素にアクセスできます。

```ruby
# ハッシュの作成
hash = { "name" => "Alice", "age" => 25 }
hash2 = { name: "Bob", age: 30 }  # シンボルをキーとして使用

# 要素へのアクセス
puts hash["name"]   # => "Alice"
puts hash2[:age]    # => 30

# 要素の追加・更新
hash["city"] = "Tokyo"
hash2[:age] = 31

# 存在確認
hash.key?("name")   # => true
hash.has_key?("email")  # => false

# ハッシュのイテレーション
hash.each { |key, value| puts "#{key}: #{value}" }
hash.keys           # => すべてのキーの配列
hash.values         # => すべての値の配列
```

### 文字列（String）

文字列操作もコーディング面接で頻出します。

```ruby
str = "Hello, World!"

# 長さ
str.length          # => 13

# 部分文字列
str[0..4]          # => "Hello"
str[7..-1]         # => "World!"

# 検索
str.include?("World")  # => true
str.index("World")     # => 7

# 変換
str.upcase          # => "HELLO, WORLD!"
str.downcase        # => "hello, world!"
str.reverse         # => "!dlroW ,olleH"

# 分割・結合
str.split(", ")     # => ["Hello", "World!"]
["a", "b", "c"].join("-")  # => "a-b-c"

# 文字の配列への変換
str.chars           # => ["H", "e", "l", "l", "o", ...]
```

### 制御構造

```ruby
# 条件分岐
if x > 0
  puts "正の数"
elsif x < 0
  puts "負の数"
else
  puts "ゼロ"
end

# 三項演算子
result = x > 0 ? "正" : "非正"

# case文
case value
when 1
  puts "一"
when 2
  puts "二"
else
  puts "その他"
end

# ループ
(1..5).each { |i| puts i }
5.times { |i| puts i }
while condition
  # 処理
end
```

### 範囲（Range）

```ruby
# 範囲の作成
(1..5)              # => 1, 2, 3, 4, 5（5を含む）
(1...5)             # => 1, 2, 3, 4（5を含まない）

# 範囲を配列に変換
(1..5).to_a         # => [1, 2, 3, 4, 5]

# 範囲のイテレーション
(1..5).each { |i| puts i }
```

## 計算量とBig O

### Big O記法とは

Big O記法は、アルゴリズムの実行時間やメモリ使用量が、入力サイズに対してどのように増加するかを表す数学的な表記法です。アルゴリズムの効率を評価し、比較するために使用します。

### 主要な計算量

#### O(1) - 定数時間

入力サイズに関係なく、常に一定の時間で処理が完了します。

```ruby
# 配列の要素へのアクセス
def get_first_element(arr)
  arr[0]  # O(1)
end

# ハッシュからの値の取得
def get_value(hash, key)
  hash[key]  # O(1)
end
```

#### O(log n) - 対数時間

入力サイズが2倍になっても、実行時間はわずかに増加するだけです。二分探索が代表的な例です。

```ruby
# 二分探索
def binary_search(arr, target)
  left = 0
  right = arr.length - 1
  
  while left <= right
    mid = left + (right - left) / 2
    
    if arr[mid] == target
      return mid
    elsif arr[mid] < target
      left = mid + 1
    else
      right = mid - 1
    end
  end
  
  -1
end

# 時間計算量: O(log n)
# 例: 1024要素の配列でも最大10回の比較で完了
```

#### O(n) - 線形時間

入力サイズに比例して実行時間が増加します。

```ruby
# 配列の全要素を走査
def linear_search(arr, target)
  arr.each_with_index do |val, i|
    return i if val == target
  end
  -1
end

# 配列の合計
def sum_array(arr)
  arr.sum  # O(n)
end

# 時間計算量: O(n)
```

#### O(n log n) - 線形対数時間

効率的なソートアルゴリズム（マージソート、クイックソート、ヒープソート）の計算量です。

```ruby
# Rubyの組み込みソート
def sort_array(arr)
  arr.sort  # O(n log n)
end

# マージソート（実装例）
def merge_sort(arr)
  return arr if arr.length <= 1
  
  mid = arr.length / 2
  left = merge_sort(arr[0...mid])
  right = merge_sort(arr[mid..-1])
  
  merge(left, right)
end

def merge(left, right)
  result = []
  i = j = 0
  
  while i < left.length && j < right.length
    if left[i] <= right[j]
      result << left[i]
      i += 1
    else
      result << right[j]
      j += 1
    end
  end
  
  result + left[i..-1] + right[j..-1]
end

# 時間計算量: O(n log n)
```

#### O(n²) - 二次時間

二重ループを使用する場合に発生します。

```ruby
# バブルソート
def bubble_sort(arr)
  n = arr.length
  
  (n-1).times do |i|
    (n-i-1).times do |j|
      if arr[j] > arr[j+1]
        arr[j], arr[j+1] = arr[j+1], arr[j]
      end
    end
  end
  
  arr
end

# 配列の全ペアを比較
def count_pairs(arr)
  count = 0
  
  arr.each_with_index do |val1, i|
    arr.each_with_index do |val2, j|
      count += 1 if i < j && val1 + val2 == 10
    end
  end
  
  count
end

# 時間計算量: O(n²)
```

#### O(2ⁿ) - 指数時間

入力が1増えるごとに実行時間が2倍になります。非効率的です。

```ruby
# フィボナッチ数列（非効率な再帰）
def fibonacci(n)
  return n if n <= 1
  fibonacci(n-1) + fibonacci(n-2)
end

# 時間計算量: O(2ⁿ)
# これは非常に遅いため、メモ化やDPで改善します
```

### 空間計算量

メモリ使用量も重要な指標です。

```ruby
# O(1) - 定数空間
def sum_array(arr)
  total = 0
  arr.each { |x| total += x }
  total
end

# O(n) - 線形空間
def create_copy(arr)
  arr.dup  # 配列のコピーを作成
end

# O(n) - 再帰の深さ分のスタック空間
def factorial(n)
  return 1 if n <= 1
  n * factorial(n - 1)
end
```

### 計算量の比較

入力サイズが1,000の場合の実行ステップ数の目安です。

| 計算量 | 実行ステップ数 | 評価 |
| ------ | ----------- | ---- |
| O(1) | 1 | 非常に速い |
| O(log n) | 10 | 非常に速い |
| O(n) | 1,000 | 速い |
| O(n log n) | 10,000 | まあまあ速い |
| O(n²) | 1,000,000 | 遅い |
| O(2ⁿ) | 非常に大きい | 非常に遅い |

### 計算量の削減テクニック

#### ハッシュテーブルの活用

```ruby
# O(n²)の解法（遅い）
def two_sum_slow(nums, target)
  nums.each_with_index do |num1, i|
    nums.each_with_index do |num2, j|
      return [i, j] if i < j && num1 + num2 == target
    end
  end
  nil
end

# O(n)の解法（速い）
def two_sum_fast(nums, target)
  hash = {}
  
  nums.each_with_index do |num, i|
    complement = target - num
    return [hash[complement], i] if hash.key?(complement)
    hash[num] = i
  end
  
  nil
end
```

#### メモ化（Memoization）

```ruby
# O(2ⁿ)の解法（遅い）
def fibonacci_slow(n)
  return n if n <= 1
  fibonacci_slow(n-1) + fibonacci_slow(n-2)
end

# O(n)の解法（速い）
def fibonacci_fast(n, memo = {})
  return n if n <= 1
  return memo[n] if memo.key?(n)
  
  memo[n] = fibonacci_fast(n-1, memo) + fibonacci_fast(n-2, memo)
end
```

## 実践的なヒント

1. まず単純な解法を考えて、その計算量を分析します
2. ボトルネックを特定し、改善方法を検討します
3. ハッシュテーブル、ソート、二分探索などの技法を活用します
4. 空間計算量とのトレードオフを考慮します
5. コードの可読性と効率のバランスを取ります

## まとめ

このセクションでは、Rubyの基本的な構文とデータ構造、そしてアルゴリズムの効率を評価するためのBig O記法について学びました。これらの知識は、以降のセクションでより高度なアルゴリズムとデータ構造を学ぶ際の基盤となります。効率的なコードを書くためには、常に計算量を意識することが重要です。

## 練習問題

### 問題1: 計算量の分析

以下のコードの時間計算量と空間計算量を答えてください。

```ruby
def process_data(arr)
  result = []
  
  arr.each do |x|
    result << x * 2 if x.even?
  end
  
  result.sort
end
```

回答: 時間計算量 O(n log n)（sortが支配的）、空間計算量 O(n)

### 問題2: 重複要素の検出

配列内に重複する要素があるかどうかを判定する関数を、O(n)の時間計算量で実装してください。

```ruby
def contains_duplicate(nums)
  seen = {}
  
  nums.each do |num|
    return true if seen.key?(num)
    seen[num] = true
  end
  
  false
end

# テストケース
puts contains_duplicate([1, 2, 3, 1])  # => true
puts contains_duplicate([1, 2, 3, 4])  # => false
```

### 問題3: 最頻出要素

配列内で最も頻繁に出現する要素を返す関数を実装してください。

```ruby
def most_frequent(nums)
  freq = Hash.new(0)
  
  nums.each { |num| freq[num] += 1 }
  
  freq.max_by { |k, v| v }[0]
end

# テストケース
puts most_frequent([1, 2, 2, 3, 3, 3])  # => 3
puts most_frequent([1, 1, 2, 2])        # => 1 or 2
```

これらの基礎知識を理解した上で、次のセクションでは配列と文字列の具体的な問題に取り組んでいきます。
