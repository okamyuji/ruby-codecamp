# Ruby 3.4 初級者向け問題集 - Part 5: 探索・ソート

## 概要

このセクションでは、探索アルゴリズムとソートアルゴリズムを学びます。これらは基本的なアルゴリズムの中でも特に重要であり、多くの問題解決の基盤となります。

---

## 問題35: 二分探索

### 問題文

ソート済みの整数配列と目標値が与えられます。目標値が配列に存在する場合はそのインデックスを、存在しない場合は-1を返してください。

**入力例:**

```text
nums = [-1, 0, 3, 5, 9, 12]
target = 9
```

**出力例:**

```text
4
```

### アルゴリズム概説

二分探索は、ソート済み配列で効率的に要素を検索するアルゴリズムです。配列の中央の要素と目標値を比較し、探索範囲を半分に絞り込んでいきます。

**時間計算量:** O(log n) - 毎回範囲が半分になる  
**空間計算量:** O(1) - 定数量のメモリ

### 擬似コード

```text
関数 binary_search(配列, 目標値):
    左 = 0
    右 = 配列の長さ - 1
    
    左 <= 右 の間:
        中央 = (左 + 右) / 2
        
        もし 配列[中央] == 目標値 なら:
            中央を返す
        もし 配列[中央] < 目標値 なら:
            左 = 中央 + 1
        そうでなければ:
            右 = 中央 - 1
    
    -1を返す
```

### 解答

```ruby
# 解法1: 反復的な二分探索（推奨）
def binary_search(nums, target)
  left = 0
  right = nums.length - 1
  
  while left <= right
    # オーバーフローを避ける計算方法
    mid = left + (right - left) / 2
    
    if nums[mid] == target
      return mid
    elsif nums[mid] < target
      # 目標値は右半分にある
      left = mid + 1
    else
      # 目標値は左半分にある
      right = mid - 1
    end
  end
  
  -1  # 見つからない
end

# 解法2: 組み込みメソッドを使用
def binary_search_builtin(nums, target)
  # bsearchはブロックの戻り値で探索方向を決定
  index = nums.bsearch_index { |x| x >= target }
  index && nums[index] == target ? index : -1
end

# 解法3: 再帰的な二分探索
def binary_search_recursive(nums, target, left = 0, right = nil)
  right ||= nums.length - 1
  
  return -1 if left > right
  
  mid = left + (right - left) / 2
  
  if nums[mid] == target
    mid
  elsif nums[mid] < target
    binary_search_recursive(nums, target, mid + 1, right)
  else
    binary_search_recursive(nums, target, left, mid - 1)
  end
end

# 解法4: indexを使用（線形探索、参考）
def linear_search(nums, target)
  nums.index(target) || -1
end

# テストケース
puts binary_search([-1, 0, 3, 5, 9, 12], 9)   # => 4
puts binary_search([-1, 0, 3, 5, 9, 12], 2)   # => -1
puts binary_search([5], 5)                     # => 0
puts binary_search([], 5)                      # => -1
puts binary_search([1, 2, 3, 4, 5], 1)        # => 0
```

---

## 問題36: 挿入位置の検索

### 問題文

ソート済みの配列と目標値が与えられます。目標値が見つかった場合はそのインデックスを返し、見つからない場合は順序を保つように挿入すべき位置を返してください。

**入力例:**

```text
nums = [1, 3, 5, 6]
target = 5
```

**出力例:**

```text
2
```

**入力例2:**

```text
nums = [1, 3, 5, 6]
target = 2
```

**出力例2:**

```text
1
```

### アルゴリズム概説

二分探索を応用し、目標値以上の最初の要素の位置を見つけます。これは「下限（lower bound）」を求める問題です。

**時間計算量:** O(log n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 search_insert(配列, 目標値):
    左 = 0
    右 = 配列の長さ
    
    左 < 右 の間:
        中央 = (左 + 右) / 2
        
        もし 配列[中央] < 目標値 なら:
            左 = 中央 + 1
        そうでなければ:
            右 = 中央
    
    左を返す
```

### 解答

```ruby
# 解法1: 二分探索で下限を求める（推奨）
def search_insert(nums, target)
  left = 0
  right = nums.length
  
  while left < right
    mid = left + (right - left) / 2
    
    if nums[mid] < target
      left = mid + 1
    else
      right = mid
    end
  end
  
  left
end

# 解法2: bsearch_indexを使用
def search_insert_builtin(nums, target)
  # bsearch_indexは条件を満たす最小のインデックスを返す
  nums.bsearch_index { |x| x >= target } || nums.length
end

# 解法3: 線形探索（シンプルだがO(n)）
def search_insert_linear(nums, target)
  nums.each_with_index do |num, i|
    return i if num >= target
  end
  nums.length
end

# 解法4: 要素が見つかるかどうかも判定
def search_insert_with_found(nums, target)
  left = 0
  right = nums.length - 1
  
  while left <= right
    mid = left + (right - left) / 2
    
    if nums[mid] == target
      return { index: mid, found: true }
    elsif nums[mid] < target
      left = mid + 1
    else
      right = mid - 1
    end
  end
  
  { index: left, found: false }
end

# テストケース
puts search_insert([1, 3, 5, 6], 5)  # => 2
puts search_insert([1, 3, 5, 6], 2)  # => 1
puts search_insert([1, 3, 5, 6], 7)  # => 4
puts search_insert([1, 3, 5, 6], 0)  # => 0
puts search_insert([], 1)            # => 0
```

---

## 問題37: バブルソート

### 問題文

整数の配列が与えられます。バブルソートアルゴリズムを使用して昇順にソートしてください。

**入力例:**

```text
[64, 34, 25, 12, 22, 11, 90]
```

**出力例:**

```text
[11, 12, 22, 25, 34, 64, 90]
```

### アルゴリズム概説

隣接する要素を比較し、順序が逆なら交換します。これを配列全体に対して繰り返し、交換がなくなるまで続けます。

**時間計算量:** O(n²) - 最悪・平均  
**空間計算量:** O(1) - in-place

### 擬似コード

```text
関数 bubble_sort(配列):
    n = 配列の長さ
    
    i = 0 から n-1 まで:
        交換あり = false
        
        j = 0 から n-i-2 まで:
            もし 配列[j] > 配列[j+1] なら:
                配列[j], 配列[j+1] = 配列[j+1], 配列[j]
                交換あり = true
        
        もし 交換なし なら:
            break  # 既にソート済み
    
    配列を返す
```

### 解答

```ruby
# 解法1: 基本的なバブルソート（最適化あり）
def bubble_sort(arr)
  arr = arr.dup  # 元の配列を変更しない
  n = arr.length
  
  (0...n).each do |i|
    swapped = false
    
    # 各パスで最大の要素が末尾に移動
    (0...(n - i - 1)).each do |j|
      if arr[j] > arr[j + 1]
        # 隣接要素を交換
        arr[j], arr[j + 1] = arr[j + 1], arr[j]
        swapped = true
      end
    end
    
    # 交換がなければソート完了
    break unless swapped
  end
  
  arr
end

# 解法2: 破壊的なバブルソート
def bubble_sort!(arr)
  n = arr.length
  
  loop do
    swapped = false
    
    (0...(n - 1)).each do |i|
      if arr[i] > arr[i + 1]
        arr[i], arr[i + 1] = arr[i + 1], arr[i]
        swapped = true
      end
    end
    
    break unless swapped
  end
  
  arr
end

# 解法3: whileループを使用
def bubble_sort_while(arr)
  arr = arr.dup
  n = arr.length
  
  sorted = false
  until sorted
    sorted = true
    
    (0...(n - 1)).each do |i|
      if arr[i] > arr[i + 1]
        arr[i], arr[i + 1] = arr[i + 1], arr[i]
        sorted = false
      end
    end
  end
  
  arr
end

# 比較: 組み込みsortを使用（推奨）
def sort_builtin(arr)
  arr.sort
end

# テストケース
p bubble_sort([64, 34, 25, 12, 22, 11, 90])  # => [11, 12, 22, 25, 34, 64, 90]
p bubble_sort([5, 1, 4, 2, 8])               # => [1, 2, 4, 5, 8]
p bubble_sort([1, 2, 3])                     # => [1, 2, 3] (既にソート済み)
p bubble_sort([])                            # => []
p bubble_sort([1])                           # => [1]
```

---

## 問題38: 選択ソート

### 問題文

整数の配列が与えられます。選択ソートアルゴリズムを使用して昇順にソートしてください。

**入力例:**

```text
[64, 25, 12, 22, 11]
```

**出力例:**

```text
[11, 12, 22, 25, 64]
```

### アルゴリズム概説

未ソート部分から最小の要素を見つけ、未ソート部分の先頭と交換します。これを繰り返して配列全体をソートします。

**時間計算量:** O(n²) - すべての場合  
**空間計算量:** O(1) - in-place

### 擬似コード

```text
関数 selection_sort(配列):
    n = 配列の長さ
    
    i = 0 から n-2 まで:
        最小インデックス = i
        
        j = i+1 から n-1 まで:
            もし 配列[j] < 配列[最小インデックス] なら:
                最小インデックス = j
        
        もし 最小インデックス != i なら:
            配列[i], 配列[最小インデックス] = 配列[最小インデックス], 配列[i]
    
    配列を返す
```

### 解答

```ruby
# 解法1: 基本的な選択ソート
def selection_sort(arr)
  arr = arr.dup
  n = arr.length
  
  (0...(n - 1)).each do |i|
    # 未ソート部分の最小要素のインデックスを見つける
    min_index = i
    
    ((i + 1)...n).each do |j|
      min_index = j if arr[j] < arr[min_index]
    end
    
    # 最小要素を未ソート部分の先頭と交換
    arr[i], arr[min_index] = arr[min_index], arr[i] if min_index != i
  end
  
  arr
end

# 解法2: min_byを使用
def selection_sort_min_by(arr)
  arr = arr.dup
  n = arr.length
  
  (0...(n - 1)).each do |i|
    # 未ソート部分から最小要素のインデックスを見つける
    min_index = (i...n).min_by { |j| arr[j] }
    arr[i], arr[min_index] = arr[min_index], arr[i]
  end
  
  arr
end

# 解法3: 降順の選択ソート
def selection_sort_desc(arr)
  arr = arr.dup
  n = arr.length
  
  (0...(n - 1)).each do |i|
    max_index = i
    
    ((i + 1)...n).each do |j|
      max_index = j if arr[j] > arr[max_index]
    end
    
    arr[i], arr[max_index] = arr[max_index], arr[i]
  end
  
  arr
end

# テストケース
p selection_sort([64, 25, 12, 22, 11])  # => [11, 12, 22, 25, 64]
p selection_sort([5, 3, 8, 4, 2])       # => [2, 3, 4, 5, 8]
p selection_sort([1])                   # => [1]
p selection_sort([])                    # => []
p selection_sort([3, 3, 3])             # => [3, 3, 3]
```

---

## 問題39: 挿入ソート

### 問題文

整数の配列が与えられます。挿入ソートアルゴリズムを使用して昇順にソートしてください。

**入力例:**

```text
[12, 11, 13, 5, 6]
```

**出力例:**

```text
[5, 6, 11, 12, 13]
```

### アルゴリズム概説

配列を左から右に走査し、各要素を既にソート済みの部分の適切な位置に挿入します。トランプを並べ替える時のような操作です。

**時間計算量:** O(n²) - 最悪、O(n) - 最良（既にソート済み）  
**空間計算量:** O(1) - in-place

### 擬似コード

```text
関数 insertion_sort(配列):
    n = 配列の長さ
    
    i = 1 から n-1 まで:
        キー = 配列[i]
        j = i - 1
        
        j >= 0 かつ 配列[j] > キー の間:
            配列[j + 1] = 配列[j]
            j -= 1
        
        配列[j + 1] = キー
    
    配列を返す
```

### 解答

```ruby
# 解法1: 基本的な挿入ソート
def insertion_sort(arr)
  arr = arr.dup
  n = arr.length
  
  (1...n).each do |i|
    # 現在の要素を保存
    key = arr[i]
    j = i - 1
    
    # keyより大きい要素を右にシフト
    while j >= 0 && arr[j] > key
      arr[j + 1] = arr[j]
      j -= 1
    end
    
    # keyを正しい位置に挿入
    arr[j + 1] = key
  end
  
  arr
end

# 解法2: bsearchを使用して挿入位置を見つける
def insertion_sort_binary(arr)
  arr = arr.dup
  
  (1...arr.length).each do |i|
    key = arr[i]
    
    # 二分探索で挿入位置を見つける
    insert_pos = (0...i).bsearch { |j| arr[j] > key } || i
    
    # 要素を右にシフトして挿入
    (insert_pos...i).reverse_each { |j| arr[j + 1] = arr[j] }
    arr[insert_pos] = key
  end
  
  arr
end

# 解法3: Rubyらしい実装
def insertion_sort_ruby(arr)
  result = []
  
  arr.each do |num|
    # 挿入位置を見つける
    insert_index = result.find_index { |x| x > num } || result.length
    result.insert(insert_index, num)
  end
  
  result
end

# 解法4: 降順の挿入ソート
def insertion_sort_desc(arr)
  arr = arr.dup
  
  (1...arr.length).each do |i|
    key = arr[i]
    j = i - 1
    
    while j >= 0 && arr[j] < key
      arr[j + 1] = arr[j]
      j -= 1
    end
    
    arr[j + 1] = key
  end
  
  arr
end

# テストケース
p insertion_sort([12, 11, 13, 5, 6])   # => [5, 6, 11, 12, 13]
p insertion_sort([5, 2, 4, 6, 1, 3])   # => [1, 2, 3, 4, 5, 6]
p insertion_sort([1, 2, 3])            # => [1, 2, 3]
p insertion_sort([3, 2, 1])            # => [1, 2, 3]
p insertion_sort([])                   # => []
```

---

## 問題40: マージソート

### 問題文

整数の配列が与えられます。マージソートアルゴリズムを使用して昇順にソートしてください。

**入力例:**

```text
[38, 27, 43, 3, 9, 82, 10]
```

**出力例:**

```text
[3, 9, 10, 27, 38, 43, 82]
```

### アルゴリズム概説

分割統治法を使用します。配列を半分に分割し、それぞれを再帰的にソートし、最後にマージします。

**時間計算量:** O(n log n) - すべての場合  
**空間計算量:** O(n) - マージ時の一時配列

### 擬似コード

```text
関数 merge_sort(配列):
    もし 配列の長さ <= 1 なら:
        配列を返す
    
    中央 = 配列の長さ / 2
    左半分 = merge_sort(配列の前半)
    右半分 = merge_sort(配列の後半)
    
    merge(左半分, 右半分) を返す

関数 merge(左, 右):
    結果 = 空配列
    
    左と右の両方に要素がある間:
        もし 左の先頭 <= 右の先頭 なら:
            結果に左の先頭を追加し、左から削除
        そうでなければ:
            結果に右の先頭を追加し、右から削除
    
    結果に残りの要素を追加
    結果を返す
```

### 解答

```ruby
# 解法1: 再帰的なマージソート（推奨）
def merge_sort(arr)
  # ベースケース: 要素が1つ以下なら既にソート済み
  return arr if arr.length <= 1
  
  # 配列を半分に分割
  mid = arr.length / 2
  left = merge_sort(arr[0...mid])
  right = merge_sort(arr[mid..])
  
  # ソートされた2つの配列をマージ
  merge(left, right)
end

def merge(left, right)
  result = []
  
  # 両方の配列に要素がある間、比較しながらマージ
  while !left.empty? && !right.empty?
    if left.first <= right.first
      result << left.shift
    else
      result << right.shift
    end
  end
  
  # 残りの要素を追加
  result + left + right
end

# 解法2: インデックスベースのマージ
def merge_sort_index(arr)
  return arr if arr.length <= 1
  
  mid = arr.length / 2
  left = merge_sort_index(arr[0...mid])
  right = merge_sort_index(arr[mid..])
  
  merge_index(left, right)
end

def merge_index(left, right)
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
  
  result.concat(left[i..]).concat(right[j..])
end

# 解法3: 反復的なマージソート
def merge_sort_iterative(arr)
  return arr if arr.length <= 1
  
  arr = arr.dup
  n = arr.length
  width = 1
  
  while width < n
    (0...n).step(width * 2) do |i|
      left = arr[i, width]
      right = arr[i + width, width] || []
      merged = merge(left, right)
      merged.each_with_index { |val, j| arr[i + j] = val }
    end
    width *= 2
  end
  
  arr
end

# テストケース
p merge_sort([38, 27, 43, 3, 9, 82, 10])  # => [3, 9, 10, 27, 38, 43, 82]
p merge_sort([5, 2, 4, 6, 1, 3])          # => [1, 2, 3, 4, 5, 6]
p merge_sort([1])                         # => [1]
p merge_sort([])                          # => []
p merge_sort([2, 1])                      # => [1, 2]
```

---

## 問題41: クイックソート

### 問題文

整数の配列が与えられます。クイックソートアルゴリズムを使用して昇順にソートしてください。

**入力例:**

```text
[10, 7, 8, 9, 1, 5]
```

**出力例:**

```text
[1, 5, 7, 8, 9, 10]
```

### アルゴリズム概説

ピボットを選択し、配列をピボットより小さい要素と大きい要素に分割します。各部分を再帰的にソートします。

**時間計算量:** O(n log n) - 平均、O(n²) - 最悪  
**空間計算量:** O(log n) - 再帰スタック

### 擬似コード

```text
関数 quick_sort(配列):
    もし 配列の長さ <= 1 なら:
        配列を返す
    
    ピボット = 配列の中央の要素
    小さい = ピボットより小さい要素
    等しい = ピボットと等しい要素
    大きい = ピボットより大きい要素
    
    quick_sort(小さい) + 等しい + quick_sort(大きい) を返す
```

### 解答

```ruby
# 解法1: 関数型スタイル（シンプルで推奨）
def quick_sort(arr)
  return arr if arr.length <= 1
  
  # 中央の要素をピボットとして選択
  pivot = arr[arr.length / 2]
  
  # 配列をピボットを基準に3つに分割
  smaller = arr.select { |x| x < pivot }
  equal = arr.select { |x| x == pivot }
  larger = arr.select { |x| x > pivot }
  
  # 再帰的にソートして結合
  quick_sort(smaller) + equal + quick_sort(larger)
end

# 解法2: partitionを使用
def quick_sort_partition(arr)
  return arr if arr.length <= 1
  
  pivot = arr.first
  smaller, larger = arr[1..].partition { |x| x < pivot }
  
  quick_sort_partition(smaller) + [pivot] + quick_sort_partition(larger)
end

# 解法3: in-placeクイックソート
def quick_sort_inplace(arr, low = 0, high = arr.length - 1)
  return arr if low >= high
  
  pivot_index = partition_inplace(arr, low, high)
  quick_sort_inplace(arr, low, pivot_index - 1)
  quick_sort_inplace(arr, pivot_index + 1, high)
  
  arr
end

def partition_inplace(arr, low, high)
  pivot = arr[high]
  i = low - 1
  
  (low...high).each do |j|
    if arr[j] <= pivot
      i += 1
      arr[i], arr[j] = arr[j], arr[i]
    end
  end
  
  arr[i + 1], arr[high] = arr[high], arr[i + 1]
  i + 1
end

# 解法4: ランダムピボット
def quick_sort_random(arr)
  return arr if arr.length <= 1
  
  pivot_index = rand(arr.length)
  pivot = arr[pivot_index]
  
  smaller = []
  equal = []
  larger = []
  
  arr.each do |x|
    if x < pivot
      smaller << x
    elsif x == pivot
      equal << x
    else
      larger << x
    end
  end
  
  quick_sort_random(smaller) + equal + quick_sort_random(larger)
end

# テストケース
p quick_sort([10, 7, 8, 9, 1, 5])   # => [1, 5, 7, 8, 9, 10]
p quick_sort([3, 6, 8, 10, 1, 2])   # => [1, 2, 3, 6, 8, 10]
p quick_sort([1])                   # => [1]
p quick_sort([])                    # => []
p quick_sort([5, 5, 5, 5])          # => [5, 5, 5, 5]
```

---

## 問題42: K番目に大きい要素

### 問題文

整数の配列と整数kが与えられます。配列内でk番目に大きい要素を返してください。

**入力例:**

```text
nums = [3, 2, 1, 5, 6, 4]
k = 2
```

**出力例:**

```text
5
```

### アルゴリズム概説

ソートして末尾からk番目を取得する方法、またはクイックセレクトアルゴリズムを使用する方法があります。

**時間計算量:** O(n log n) - ソート、O(n) - クイックセレクト（平均）  
**空間計算量:** O(1) ～ O(n) - アルゴリズムによる

### 擬似コード

```text
関数 find_kth_largest(配列, k):
    # 方法1: ソートを使用
    ソート済み = 配列を降順にソート
    ソート済み[k - 1] を返す
```

### 解答

```ruby
# 解法1: ソートを使用（シンプル）
def find_kth_largest(nums, k)
  # 降順にソートしてk番目を取得
  nums.sort.reverse[k - 1]
end

# 解法2: sort_byを使用
def find_kth_largest_sort_by(nums, k)
  nums.sort_by { |x| -x }[k - 1]
end

# 解法3: 最大ヒープを使用（概念的な実装）
def find_kth_largest_heap(nums, k)
  # Rubyには標準のヒープがないが、maxを使用して模倣
  heap = nums.dup
  
  (k - 1).times do
    max_val = heap.max
    heap.delete_at(heap.index(max_val))
  end
  
  heap.max
end

# 解法4: クイックセレクト
def find_kth_largest_quickselect(nums, k)
  # k番目に大きい = (n - k + 1)番目に小さい
  quickselect(nums.dup, nums.length - k)
end

def quickselect(arr, k)
  pivot = arr.sample
  
  smaller = arr.select { |x| x < pivot }
  equal = arr.select { |x| x == pivot }
  larger = arr.select { |x| x > pivot }
  
  if k < smaller.length
    quickselect(smaller, k)
  elsif k < smaller.length + equal.length
    pivot
  else
    quickselect(larger, k - smaller.length - equal.length)
  end
end

# 解法5: 部分ソートを使用
def find_kth_largest_partial(nums, k)
  nums.max(k).last
end

# テストケース
puts find_kth_largest([3, 2, 1, 5, 6, 4], 2)          # => 5
puts find_kth_largest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4) # => 4
puts find_kth_largest([1], 1)                         # => 1
puts find_kth_largest([7, 6, 5, 4, 3, 2, 1], 5)       # => 3
```

---

## まとめ

このセクションでは、探索・ソートアルゴリズムを8問を通じて学びました。

**学んだ主なアルゴリズム:**

| アルゴリズム | 時間計算量（平均） | 空間計算量 | 特徴 |
| ------------ | ------------------ | ---------- | -------------------- |
| 二分探索 | O(log n) | O(1) | ソート済み配列必須 |
| バブルソート | O(n²) | O(1) | シンプルだが遅い |
| 選択ソート | O(n²) | O(1) | 交換回数が少ない |
| 挿入ソート | O(n²) | O(1) | 小さい配列に効率的 |
| マージソート | O(n log n) | O(n) | 安定ソート |
| クイックソート | O(n log n) | O(log n) | 実用上最速 |

**学んだ主なメソッド:**

- `sort`, `sort_by` - 組み込みソート
- `bsearch`, `bsearch_index` - 二分探索
- `partition` - 配列の分割
- `max(k)` - 上位k個の取得

**重要なポイント:**

1. 問題の制約に応じて適切なアルゴリズムを選択する
2. ソートはO(n log n)が理論上の下限
3. 二分探索はソート済み配列でのみ使用可能
4. in-placeアルゴリズムは空間効率が良い
5. 安定ソートは同値要素の順序を保持する
