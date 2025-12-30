# 配列と文字列 - 導入

## 概要

このセクションでは、配列と文字列を扱う上で必要な基本的なデータ構造とアルゴリズムの概念を学びます。ハッシュテーブル、ソート、スタックなどの重要な技法について解説します。

## ハッシュテーブル（導入）

### ハッシュテーブルとは

ハッシュテーブルは、キーと値のペアを格納するデータ構造です。ハッシュ関数を使用してキーをインデックスに変換し、平均O(1)の時間で要素の挿入、削除、検索が可能です。

### 基本的な操作

```ruby
# ハッシュの作成
hash = {}
hash = Hash.new
hash = Hash.new(0)  # デフォルト値を0に設定

# 要素の追加
hash["apple"] = 100
hash["banana"] = 200

# 要素の取得
puts hash["apple"]  # => 100
puts hash["orange"]  # => nil（存在しない場合）

# デフォルト値を持つハッシュ
count = Hash.new(0)
count["a"] += 1  # => 1
count["b"] += 1  # => 1
count["a"] += 1  # => 2

# 要素の存在確認
hash.key?("apple")  # => true
hash.has_key?("orange")  # => false

# 要素の削除
hash.delete("apple")

# すべてのキーと値の取得
hash.keys    # => すべてのキーの配列
hash.values  # => すべての値の配列
```

### ハッシュテーブルの活用例

#### 文字の出現回数をカウント

```ruby
def count_characters(str)
  freq = Hash.new(0)
  
  str.each_char do |char|
    freq[char] += 1
  end
  
  freq
end

puts count_characters("hello")
# => {"h"=>1, "e"=>1, "l"=>2, "o"=>1}
```

#### アナグラムの判定

```ruby
def is_anagram(s, t)
  return false if s.length != t.length
  
  count_s = Hash.new(0)
  count_t = Hash.new(0)
  
  s.each_char { |c| count_s[c] += 1 }
  t.each_char { |c| count_t[c] += 1 }
  
  count_s == count_t
end

puts is_anagram("listen", "silent")  # => true
puts is_anagram("hello", "world")    # => false
```

#### Two Sum問題

```ruby
def two_sum(nums, target)
  hash = {}
  
  nums.each_with_index do |num, i|
    complement = target - num
    return [hash[complement], i] if hash.key?(complement)
    hash[num] = i
  end
  
  nil
end

puts two_sum([2, 7, 11, 15], 9)  # => [0, 1]
```

### ハッシュテーブルの計算量

- 平均時間計算量
  - 挿入: O(1)
  - 削除: O(1)
  - 検索: O(1)

- 最悪時間計算量
  - 挿入: O(n)（衝突が多い場合）
  - 削除: O(n)
  - 検索: O(n)

## ソート（導入）

### ソートとは

ソートは、データを特定の順序（昇順または降順）に並び替える処理です。多くのアルゴリズムでソート済みデータを前提とするため、非常に重要な操作です。

### Rubyの組み込みソート

```ruby
# 基本的なソート
arr = [3, 1, 4, 1, 5, 9, 2, 6]
sorted = arr.sort  # => [1, 1, 2, 3, 4, 5, 6, 9]

# 降順ソート
desc = arr.sort { |a, b| b <=> a }
desc = arr.sort.reverse

# sortメソッド（破壊的）
arr.sort!

# カスタムソート
words = ["apple", "pie", "zoo", "a"]
by_length = words.sort_by { |w| w.length }
# => ["a", "pie", "zoo", "apple"]

# 複数の条件でソート
people = [
  {name: "Alice", age: 30},
  {name: "Bob", age: 25},
  {name: "Charlie", age: 30}
]

sorted = people.sort_by { |p| [p[:age], p[:name]] }
```

### 主要なソートアルゴリズム

#### バブルソート - O(n²)

```ruby
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
```

#### 選択ソート - O(n²)

```ruby
def selection_sort(arr)
  n = arr.length
  
  (n-1).times do |i|
    min_idx = i
    
    (i+1...n).each do |j|
      min_idx = j if arr[j] < arr[min_idx]
    end
    
    arr[i], arr[min_idx] = arr[min_idx], arr[i]
  end
  
  arr
end
```

#### クイックソート - O(n log n)平均

```ruby
def quick_sort(arr)
  return arr if arr.length <= 1
  
  pivot = arr[arr.length / 2]
  left = arr.select { |x| x < pivot }
  middle = arr.select { |x| x == pivot }
  right = arr.select { |x| x > pivot }
  
  quick_sort(left) + middle + quick_sort(right)
end
```

#### マージソート - O(n log n)

```ruby
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
```

### カスタムソート

#### 絶対値でソート

```ruby
arr = [-5, -2, 3, -1, 4]
sorted = arr.sort_by { |x| x.abs }
# => [-1, -2, 3, -5, 4]
```

#### 文字列を長さでソート

```ruby
words = ["apple", "pie", "a", "zoo"]
sorted = words.sort_by { |w| w.length }
# => ["a", "pie", "zoo", "apple"]
```

### バケットソート（計数ソート）

特定の条件下で O(n) で動作するソート手法です。

```ruby
def bucket_sort(arr, max_val)
  buckets = Array.new(max_val + 1, 0)
  
  # 各値の出現回数をカウント
  arr.each { |num| buckets[num] += 1 }
  
  # バケットから値を取り出して配列を構築
  result = []
  buckets.each_with_index do |count, val|
    count.times { result << val }
  end
  
  result
end

puts bucket_sort([3, 1, 4, 1, 5, 9, 2, 6], 9)
# => [1, 1, 2, 3, 4, 5, 6, 9]
```

## スタック（導入）

### スタックとは

スタックは、LIFO（Last In First Out、後入れ先出し）の原則に従うデータ構造です。最後に追加された要素が最初に取り出されます。

### 基本的な操作

```ruby
# Rubyの配列をスタックとして使用
stack = []

# push - 要素を追加
stack.push(1)
stack.push(2)
stack.push(3)
# または
stack << 4

puts stack  # => [1, 2, 3, 4]

# pop - 要素を取り出す
top = stack.pop  # => 4
puts stack  # => [1, 2, 3]

# peek - 先頭要素を見る（取り出さない）
top = stack.last  # => 3
puts stack  # => [1, 2, 3]

# 空かどうかを確認
stack.empty?  # => false

# サイズ
stack.size  # => 3
```

### スタックの活用例

#### 括弧の対応チェック

```ruby
def valid_parentheses(s)
  stack = []
  pairs = { ')' => '(', '}' => '{', ']' => '[' }
  
  s.each_char do |char|
    if pairs.values.include?(char)
      # 開き括弧
      stack.push(char)
    elsif pairs.keys.include?(char)
      # 閉じ括弧
      return false if stack.empty? || stack.pop != pairs[char]
    end
  end
  
  stack.empty?
end

puts valid_parentheses("()")      # => true
puts valid_parentheses("()[]{}")  # => true
puts valid_parentheses("(]")      # => false
puts valid_parentheses("([)]")    # => false
```

#### 逆ポーランド記法の評価

```ruby
def eval_rpn(tokens)
  stack = []
  
  tokens.each do |token|
    if token =~ /^-?\d+$/  # 数値かどうか
      stack.push(token.to_i)
    else
      # 演算子
      b = stack.pop
      a = stack.pop
      
      case token
      when '+'
        stack.push(a + b)
      when '-'
        stack.push(a - b)
      when '*'
        stack.push(a * b)
      when '/'
        stack.push(a / b)
      end
    end
  end
  
  stack.pop
end

puts eval_rpn(["2", "1", "+", "3", "*"])  # => 9
puts eval_rpn(["4", "13", "5", "/", "+"])  # => 6
```

#### 文字列のデコード

```ruby
def decode_string(s)
  stack = []
  
  s.each_char do |char|
    if char != ']'
      stack.push(char)
    else
      # ']'の場合、対応する'['まで取り出す
      str = ""
      while stack.last != '['
        str = stack.pop + str
      end
      stack.pop  # '['を削除
      
      # 数字を取り出す
      num_str = ""
      while !stack.empty? && stack.last =~ /\d/
        num_str = stack.pop + num_str
      end
      
      # デコードした文字列をスタックに戻す
      stack.push(str * num_str.to_i)
    end
  end
  
  stack.join
end

puts decode_string("3[a]2[bc]")  # => "aaabcbc"
puts decode_string("3[a2[c]]")   # => "accaccacc"
```

### スタックの計算量

- push: O(1)
- pop: O(1)
- peek: O(1)
- 空間計算量: O(n)

## キュー（導入）

### キューとは

キューは、FIFO（First In First Out、先入れ先出し）の原則に従うデータ構造です。最初に追加された要素が最初に取り出されます。

### 基本的な操作

```ruby
# Rubyの配列をキューとして使用
queue = []

# enqueue - 要素を追加
queue.push(1)
queue.push(2)
queue.push(3)

puts queue  # => [1, 2, 3]

# dequeue - 要素を取り出す
first = queue.shift  # => 1
puts queue  # => [2, 3]

# peek - 先頭要素を見る
first = queue.first  # => 2

# 空かどうかを確認
queue.empty?  # => false
```

### 幅優先探索（BFS）でのキューの使用

```ruby
def bfs(graph, start)
  visited = Set.new
  queue = [start]
  visited.add(start)
  
  while !queue.empty?
    node = queue.shift
    puts node
    
    graph[node].each do |neighbor|
      unless visited.include?(neighbor)
        visited.add(neighbor)
        queue.push(neighbor)
      end
    end
  end
end

# グラフの例
graph = {
  0 => [1, 2],
  1 => [0, 3, 4],
  2 => [0],
  3 => [1],
  4 => [1]
}

bfs(graph, 0)
```

## まとめ

このセクションでは、配列と文字列を扱う上で重要なデータ構造について学びました。

- ハッシュテーブル: O(1)の検索・挿入・削除を実現し、頻度カウントやTwo Sum問題などで活用します
- ソート: データを整列させることで、多くのアルゴリズムを効率化できます。Rubyの組み込みソートはO(n log n)で動作します
- スタック: LIFO構造で、括弧の対応チェックや式の評価などに使用します
- キュー: FIFO構造で、幅優先探索などに使用します

これらの基本的なデータ構造を理解することで、より複雑なアルゴリズムや問題解決のための基盤が整います。次のセクションでは、これらの技法を活用した具体的な問題に取り組んでいきます。
