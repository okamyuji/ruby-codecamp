# ヒープと優先度付きキュー

## 概要

このセクションでは、ヒープ（Heap）と優先度付きキュー（Priority Queue）について学びます。ヒープは特殊な木構造のデータ構造で、効率的に最大値や最小値を取り出すことができます。

## ヒープと優先度付きキューの導入

### ヒープとは

ヒープは完全二分木の一種で、以下の性質を持ちます。

- 最大ヒープ: 親ノードの値が子ノードの値以上
- 最小ヒープ: 親ノードの値が子ノードの値以下

この性質により、ルート要素が常に最大値（最大ヒープ）または最小値（最小ヒープ）になります。

### 優先度付きキューとは

優先度付きキューは、各要素が優先度を持ち、優先度の高い（または低い）要素から取り出されるデータ構造です。ヒープを使って効率的に実装できます。

### 主な操作と計算量

- heapify: 配列をヒープに変換 - O(n)
- push（insert）: 要素の追加 - O(log n)
- pop（extract）: 最小/最大要素の取り出し - O(log n)
- peek: 最小/最大要素の参照 - O(1)

## Rubyでのヒープの実装

Rubyには標準でヒープのデータ構造が用意されていないため、独自に実装するか、配列とソートで代替する必要があります。

### 最小ヒープの実装

```ruby
class MinHeap
  def initialize
    @heap = []
  end
  
  # 要素の追加
  def push(value)
    @heap << value
    heapify_up(@heap.length - 1)
  end
  
  # 最小要素の取り出し
  def pop
    return nil if @heap.empty?
    
    # ルートと最後の要素を交換
    @heap[0], @heap[-1] = @heap[-1], @heap[0]
    min = @heap.pop
    
    # ルートから下方向にヒープを再構築
    heapify_down(0) unless @heap.empty?
    
    min
  end
  
  # 最小要素の参照（削除しない）
  def peek
    @heap[0]
  end
  
  # ヒープが空かどうか
  def empty?
    @heap.empty?
  end
  
  # ヒープのサイズ
  def size
    @heap.length
  end
  
  private
  
  # 上方向へのヒープ化
  def heapify_up(index)
    return if index == 0
    
    parent_index = (index - 1) / 2
    
    if @heap[index] < @heap[parent_index]
      @heap[index], @heap[parent_index] = @heap[parent_index], @heap[index]
      heapify_up(parent_index)
    end
  end
  
  # 下方向へのヒープ化
  def heapify_down(index)
    left_child = 2 * index + 1
    right_child = 2 * index + 2
    smallest = index
    
    if left_child < @heap.length && @heap[left_child] < @heap[smallest]
      smallest = left_child
    end
    
    if right_child < @heap.length && @heap[right_child] < @heap[smallest]
      smallest = right_child
    end
    
    if smallest != index
      @heap[index], @heap[smallest] = @heap[smallest], @heap[index]
      heapify_down(smallest)
    end
  end
end

# 使用例
heap = MinHeap.new
heap.push(5)
heap.push(3)
heap.push(7)
heap.push(1)

puts heap.pop  # => 1
puts heap.pop  # => 3
puts heap.peek # => 5
```

### 最大ヒープの実装

```ruby
class MaxHeap
  def initialize
    @heap = []
  end
  
  def push(value)
    @heap << value
    heapify_up(@heap.length - 1)
  end
  
  def pop
    return nil if @heap.empty?
    
    @heap[0], @heap[-1] = @heap[-1], @heap[0]
    max = @heap.pop
    
    heapify_down(0) unless @heap.empty?
    
    max
  end
  
  def peek
    @heap[0]
  end
  
  def empty?
    @heap.empty?
  end
  
  def size
    @heap.length
  end
  
  private
  
  def heapify_up(index)
    return if index == 0
    
    parent_index = (index - 1) / 2
    
    if @heap[index] > @heap[parent_index]
      @heap[index], @heap[parent_index] = @heap[parent_index], @heap[index]
      heapify_up(parent_index)
    end
  end
  
  def heapify_down(index)
    left_child = 2 * index + 1
    right_child = 2 * index + 2
    largest = index
    
    if left_child < @heap.length && @heap[left_child] > @heap[largest]
      largest = left_child
    end
    
    if right_child < @heap.length && @heap[right_child] > @heap[largest]
      largest = right_child
    end
    
    if largest != index
      @heap[index], @heap[largest] = @heap[largest], @heap[index]
      heapify_down(largest)
    end
  end
end
```

## 基礎問題

### 問題1: K番目に小さい要素

配列の中でK番目に小さい要素を見つけてください。

```ruby
def kth_smallest(nums, k)
  heap = MinHeap.new
  
  nums.each { |num| heap.push(num) }
  
  result = nil
  k.times { result = heap.pop }
  
  result
end

# テストケース
puts kth_smallest([3, 2, 1, 5, 6, 4], 2)  # => 2
puts kth_smallest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4)  # => 3
```

### 問題2: K番目に大きい要素

配列の中でK番目に大きい要素を見つけてください。

```ruby
def kth_largest(nums, k)
  # 最大ヒープを使用
  heap = MaxHeap.new
  
  nums.each { |num| heap.push(num) }
  
  result = nil
  k.times { result = heap.pop }
  
  result
end

# 配列のソートを使う簡易版
def kth_largest_simple(nums, k)
  nums.sort.reverse[k - 1]
end

# テストケース
puts kth_largest([3, 2, 1, 5, 6, 4], 2)  # => 5
puts kth_largest([3, 2, 3, 1, 2, 4, 5, 5, 6], 1)  # => 6
```

### 問題3: 最小ヒープの検証

与えられた配列が最小ヒープの性質を満たしているか確認してください。

```ruby
def is_min_heap(arr)
  n = arr.length
  
  # 各親ノードについて、子ノードより小さいかチェック
  (n / 2).times do |i|
    left_child = 2 * i + 1
    right_child = 2 * i + 2
    
    # 左の子が存在し、親より小さい場合はfalse
    return false if left_child < n && arr[i] > arr[left_child]
    
    # 右の子が存在し、親より小さい場合はfalse
    return false if right_child < n && arr[i] > arr[right_child]
  end
  
  true
end

# テストケース
puts is_min_heap([1, 3, 2, 7, 5, 8])  # => true
puts is_min_heap([1, 2, 3, 4, 5])     # => true
puts is_min_heap([5, 3, 8, 1, 2])     # => false
```

## ヒープソート

ヒープを使用して配列をソートするアルゴリズムです。時間計算量はO(n log n)です。

### ヒープソートの実装

```ruby
def heap_sort(arr)
  # 最大ヒープを構築
  heap = MaxHeap.new
  arr.each { |num| heap.push(num) }
  
  # ヒープから順に取り出して降順の配列を作る
  result = []
  until heap.empty?
    result << heap.pop
  end
  
  # 昇順にするため反転
  result.reverse
end

# in-placeなヒープソート
def heap_sort_inplace(arr)
  n = arr.length
  
  # ヒープを構築（最大ヒープ）
  (n / 2 - 1).downto(0) do |i|
    heapify_down(arr, n, i)
  end
  
  # ヒープから要素を一つずつ取り出してソート
  (n - 1).downto(1) do |i|
    # ルートと最後の要素を交換
    arr[0], arr[i] = arr[i], arr[0]
    
    # ヒープサイズを減らしてヒープ化
    heapify_down(arr, i, 0)
  end
  
  arr
end

def heapify_down(arr, heap_size, index)
  largest = index
  left = 2 * index + 1
  right = 2 * index + 2
  
  if left < heap_size && arr[left] > arr[largest]
    largest = left
  end
  
  if right < heap_size && arr[right] > arr[largest]
    largest = right
  end
  
  if largest != index
    arr[index], arr[largest] = arr[largest], arr[index]
    heapify_down(arr, heap_size, largest)
  end
end

# テストケース
p heap_sort([3, 2, 1, 5, 6, 4])  # => [1, 2, 3, 4, 5, 6]
p heap_sort([5, 2, 3, 1])        # => [1, 2, 3, 5]
```

## 応用問題

### 問題4: K個の最頻出要素

配列が与えられたとき、最も頻出するK個の要素を返してください。

```ruby
def top_k_frequent(nums, k)
  # 頻度をカウント
  freq = Hash.new(0)
  nums.each { |num| freq[num] += 1 }
  
  # 最大ヒープを使用（頻度でソート）
  heap = MaxHeap.new
  
  freq.each do |num, count|
    # [頻度, 値]のペアでヒープに追加
    # 比較は頻度で行う
    heap.push([count, num])
  end
  
  # K個取り出す
  result = []
  k.times do
    count, num = heap.pop
    result << num
  end
  
  result
end

# 配列のソートを使う簡易版
def top_k_frequent_simple(nums, k)
  freq = Hash.new(0)
  nums.each { |num| freq[num] += 1 }
  
  freq.sort_by { |num, count| -count }.first(k).map { |num, _| num }
end

# テストケース
p top_k_frequent([1, 1, 1, 2, 2, 3], 2)  # => [1, 2]
p top_k_frequent([1], 1)                  # => [1]
```

### 問題5: データストリームの中央値

データストリームから要素が追加されるたびに、現在の中央値を求めてください。

```ruby
class MedianFinder
  def initialize
    # 小さい方の半分（最大ヒープ）
    @small = MaxHeap.new
    # 大きい方の半分（最小ヒープ）
    @large = MinHeap.new
  end
  
  def add_num(num)
    # まず小さい方のヒープに追加
    @small.push(num)
    
    # 小さい方の最大値が大きい方の最小値より大きければバランスを取る
    if !@large.empty? && @small.peek > @large.peek
      @large.push(@small.pop)
    end
    
    # ヒープのサイズのバランスを取る
    if @small.size > @large.size + 1
      @large.push(@small.pop)
    elsif @large.size > @small.size
      @small.push(@large.pop)
    end
  end
  
  def find_median
    if @small.size > @large.size
      @small.peek.to_f
    else
      (@small.peek + @large.peek) / 2.0
    end
  end
end

# 使用例
mf = MedianFinder.new
mf.add_num(1)
mf.add_num(2)
puts mf.find_median  # => 1.5
mf.add_num(3)
puts mf.find_median  # => 2.0
```

### 問題6: K個の最も近い要素

ソート済み配列とターゲット値x、整数kが与えられます。配列からxに最も近いK個の要素を返してください。

```ruby
def k_closest_elements(arr, k, x)
  # 距離と値のペアでヒープを作成
  heap = MinHeap.new
  
  arr.each do |num|
    distance = (num - x).abs
    # [距離, 値]のペアで管理
    heap.push([distance, num])
  end
  
  # K個取り出す
  result = []
  k.times do
    _, num = heap.pop
    result << num
  end
  
  result.sort
end

# 二分探索とTwo Pointersを使う効率的な解法
def k_closest_elements_optimal(arr, k, x)
  left = 0
  right = arr.length - k
  
  while left < right
    mid = (left + right) / 2
    
    if x - arr[mid] > arr[mid + k] - x
      left = mid + 1
    else
      right = mid
    end
  end
  
  arr[left...left + k]
end

# テストケース
p k_closest_elements([1, 2, 3, 4, 5], 4, 3)  # => [1, 2, 3, 4]
p k_closest_elements([1, 2, 3, 4, 5], 4, -1) # => [1, 2, 3, 4]
```

## まとめ

このセクションでは、ヒープと優先度付きキューについて学びました。

重要なポイントは以下の通りです。

- ヒープは完全二分木で、効率的に最大値や最小値を管理できます
- 主な操作（push, pop）の計算量はO(log n)です
- ヒープソートはO(n log n)の時間計算量で動作します
- 優先度付きキューはヒープで実装できます
- Rubyには標準ライブラリにヒープがないため、独自実装が必要です

ヒープは、K番目に大きい/小さい要素の検索、中央値の動的計算、優先度付きタスク管理など、多くの問題で活用できる重要なデータ構造です。
