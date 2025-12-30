# 配列と文字列 - 基礎（ソート、カスタムソート、バケットソート）

## 概要

このセクションでは、ソートアルゴリズムとその応用を学びます。基本的なソートアルゴリズム、カスタムソート、特殊なケースで使用されるバケットソート（計数ソート）について理解を深めます。

---

## 問題1: 選択ソートの実装

### 問題文

配列が与えられます。選択ソートアルゴリズムを使用して配列をソートしてください。

**入力例:**

```text
[64, 25, 12, 22, 11]
```

**出力例:**

```text
[11, 12, 22, 25, 64]
```

### アルゴリズム概説

選択ソートは、未ソート部分から最小の要素を選択し、未ソート部分の先頭と交換を繰り返すアルゴリズムです。

**時間計算量:** O(n²) - 常に  
**空間計算量:** O(1) - in-placeソート

### 擬似コード

```text
関数 selection_sort(配列):
    n = 配列の長さ
    
    各インデックスiについて（0からn-2まで）:
        min_index = i
        
        各インデックスjについて（i+1からn-1まで）:
            もし 配列[j] < 配列[min_index] なら:
                min_index = j
        
        配列[i] と 配列[min_index] を交換
    
    配列を返す
```

### 解答

```ruby
# 解法1: 基本的な選択ソート
def selection_sort(arr)
  n = arr.length
  
  # 各位置について最小値を探す
  (n - 1).times do |i|
    min_index = i
    
    # 未ソート部分から最小値を探す
    (i + 1...n).each do |j|
      min_index = j if arr[j] < arr[min_index]
    end
    
    # 最小値を現在位置と交換
    arr[i], arr[min_index] = arr[min_index], arr[i]
  end
  
  arr
end

# 解法2: 降順選択ソート
def selection_sort_descending(arr)
  n = arr.length
  
  (n - 1).times do |i|
    max_index = i
    
    (i + 1...n).each do |j|
      max_index = j if arr[j] > arr[max_index]
    end
    
    arr[i], arr[max_index] = arr[max_index], arr[i]
  end
  
  arr
end

# 解法3: 選択ソートでk番目に小さい要素を見つける
def kth_smallest_selection(arr, k)
  # k-1回だけ選択ソートを実行
  (k - 1).times do |i|
    min_index = i
    
    (i + 1...arr.length).each do |j|
      min_index = j if arr[j] < arr[min_index]
    end
    
    arr[i], arr[min_index] = arr[min_index], arr[i]
  end
  
  arr[k - 1]
end

# テストケース
p selection_sort([64, 25, 12, 22, 11])        # => [11, 12, 22, 25, 64]
p selection_sort([5, 2, 8, 1, 9])             # => [1, 2, 5, 8, 9]
p selection_sort_descending([64, 25, 12, 22, 11])  # => [64, 25, 22, 12, 11]
p kth_smallest_selection([7, 10, 4, 3, 20, 15], 3)  # => 7
```

---

## 問題2: 挿入ソートの実装

### 問題文

配列が与えられます。挿入ソートアルゴリズムを使用して配列をソートしてください。

**入力例:**

```text
[5, 2, 4, 6, 1, 3]
```

**出力例:**

```text
[1, 2, 3, 4, 5, 6]
```

### アルゴリズム概説

挿入ソートは、配列を「ソート済み部分」と「未ソート部分」に分け、未ソート部分から要素を取り出してソート済み部分の適切な位置に挿入します。

**時間計算量:** O(n²) - 最悪・平均ケース、O(n) - 最良ケース  
**空間計算量:** O(1) - in-placeソート

### 擬似コード

```text
関数 insertion_sort(配列):
    n = 配列の長さ
    
    各インデックスiについて（1からn-1まで）:
        key = 配列[i]
        j = i - 1
        
        j >= 0 かつ 配列[j] > key の間:
            配列[j + 1] = 配列[j]
            j -= 1
        
        配列[j + 1] = key
    
    配列を返す
```

### 解答

```ruby
# 解法1: 基本的な挿入ソート
def insertion_sort(arr)
  n = arr.length
  
  # 2番目の要素から開始（最初の要素はソート済みとみなす）
  (1...n).each do |i|
    key = arr[i]
    j = i - 1
    
    # keyより大きい要素を右にシフト
    while j >= 0 && arr[j] > key
      arr[j + 1] = arr[j]
      j -= 1
    end
    
    # keyを適切な位置に挿入
    arr[j + 1] = key
  end
  
  arr
end

# 解法2: 交換を使った実装
def insertion_sort_swap(arr)
  (1...arr.length).each do |i|
    j = i
    
    # 左側のソート済み部分で適切な位置まで交換
    while j > 0 && arr[j - 1] > arr[j]
      arr[j - 1], arr[j] = arr[j], arr[j - 1]
      j -= 1
    end
  end
  
  arr
end

# 解法3: 降順挿入ソート
def insertion_sort_descending(arr)
  (1...arr.length).each do |i|
    key = arr[i]
    j = i - 1
    
    while j >= 0 && arr[j] < key  # 比較演算子を逆にする
      arr[j + 1] = arr[j]
      j -= 1
    end
    
    arr[j + 1] = key
  end
  
  arr
end

# テストケース
p insertion_sort([5, 2, 4, 6, 1, 3])  # => [1, 2, 3, 4, 5, 6]
p insertion_sort([12, 11, 13, 5, 6])  # => [5, 6, 11, 12, 13]
p insertion_sort([1, 2, 3])           # => [1, 2, 3] (既にソート済み)
p insertion_sort_descending([5, 2, 4, 6, 1, 3])  # => [6, 5, 4, 3, 2, 1]
```

---

## 問題3: カスタムソート - 絶対値でソート

### 問題文

整数の配列が与えられます。絶対値の昇順でソートしてください。絶対値が同じ場合は、元の値の昇順でソートします。

**入力例:**

```text
[-5, -3, 3, 2, -1]
```

**出力例:**

```text
[-1, 2, -3, 3, -5]
```

### アルゴリズム概説

Rubyのsortメソッドにブロックを渡して、カスタムな比較条件を指定します。または、sort_byメソッドを使用してソートのキーを指定します。

**時間計算量:** O(n log n)  
**空間計算量:** O(n)

### 擬似コード

```text
関数 sort_by_absolute_value(配列):
    配列をソート（キー: [絶対値, 元の値]）
    ソートされた配列を返す
```

### 解答

```ruby
# 解法1: sort_byを使用（推奨）
def sort_by_absolute_value(arr)
  arr.sort_by { |x| [x.abs, x] }
end

# 解法2: sortとブロックを使用
def sort_by_absolute_value_sort(arr)
  arr.sort do |a, b|
    if a.abs == b.abs
      a <=> b  # 絶対値が同じなら元の値で比較
    else
      a.abs <=> b.abs  # 絶対値で比較
    end
  end
end

# 解法3: stable_sortが必要な場合（元の順序を保持）
def sort_by_absolute_value_stable(arr)
  arr.each_with_index.sort_by { |x, i| [x.abs, x, i] }.map(&:first)
end

# テストケース
p sort_by_absolute_value([-5, -3, 3, 2, -1])
# => [-1, 2, -3, 3, -5]

p sort_by_absolute_value([1, -1, 2, -2, 3, -3])
# => [-1, 1, -2, 2, -3, 3]

p sort_by_absolute_value([5, -7, 3, -3])
# => [-3, 3, 5, -7]
```

---

## 問題4: カスタムソート - 文字列を長さでソート

### 問題文

文字列の配列が与えられます。文字列の長さの昇順でソートしてください。長さが同じ場合は辞書順でソートします。

**入力例:**

```text
["apple", "pie", "a", "zoo", "elephant"]
```

**出力例:**

```text
["a", "pie", "zoo", "apple", "elephant"]
```

### アルゴリズム概説

sort_byで文字列の長さと文字列自体をキーとして使用します。

**時間計算量:** O(n log n)  
**空間計算量:** O(n)

### 擬似コード

```text
関数 sort_by_length(文字列配列):
    文字列配列をソート（キー: [長さ, 文字列]）
    ソートされた配列を返す
```

### 解答

```ruby
# 解法1: sort_byを使用（推奨）
def sort_by_length(strs)
  strs.sort_by { |s| [s.length, s] }
end

# 解法2: sortとブロックを使用
def sort_by_length_sort(strs)
  strs.sort do |a, b|
    if a.length == b.length
      a <=> b
    else
      a.length <=> b.length
    end
  end
end

# 解法3: 降順ソート（長い順）
def sort_by_length_descending(strs)
  strs.sort_by { |s| [-s.length, s] }
end

# テストケース
p sort_by_length(["apple", "pie", "a", "zoo", "elephant"])
# => ["a", "pie", "zoo", "apple", "elephant"]

p sort_by_length(["aa", "a", "aaa", "aaaa"])
# => ["a", "aa", "aaa", "aaaa"]

p sort_by_length_descending(["apple", "pie", "a", "zoo"])
# => ["apple", "pie", "zoo", "a"]
```

---

## 問題5: バケットソート（計数ソート）

### 問題文

0からkの範囲の整数配列が与えられます。計数ソート（カウンティングソート）を使用してO(n + k)の時間でソートしてください。

**入力例:**

```text
[4, 2, 2, 8, 3, 3, 1]
k = 8
```

**出力例:**

```text
[1, 2, 2, 3, 3, 4, 8]
```

### アルゴリズム概説

各値の出現回数をカウントする配列を作成し、その配列を使ってソート済み配列を構築します。値の範囲が小さい場合に非常に効率的です。

**時間計算量:** O(n + k) - nは配列の長さ、kは値の範囲  
**空間計算量:** O(k)

### 擬似コード

```text
関数 counting_sort(配列, k):
    count = サイズk+1の配列（0で初期化）
    
    # 出現回数をカウント
    配列の各要素について:
        count[要素] += 1
    
    # ソート済み配列を構築
    結果 = 空配列
    各値vについて（0からkまで）:
        count[v]回だけvを結果に追加
    
    結果を返す
```

### 解答

```ruby
# 解法1: 基本的な計数ソート
def counting_sort(arr, k)
  count = Array.new(k + 1, 0)
  
  # 各値の出現回数をカウント
  arr.each { |num| count[num] += 1 }
  
  # カウントから結果配列を構築
  result = []
  count.each_with_index do |freq, value|
    freq.times { result << value }
  end
  
  result
end

# 解法2: 累積カウントを使用（安定ソート版）
def counting_sort_stable(arr, k)
  count = Array.new(k + 1, 0)
  output = Array.new(arr.length)
  
  # 各値の出現回数をカウント
  arr.each { |num| count[num] += 1 }
  
  # 累積カウントに変換
  (1..k).each { |i| count[i] += count[i - 1] }
  
  # 結果配列を構築（逆順で安定性を保証）
  (arr.length - 1).downto(0) do |i|
    value = arr[i]
    output[count[value] - 1] = value
    count[value] -= 1
  end
  
  output
end

# 解法3: ハッシュを使用（値の範囲が大きい場合）
def counting_sort_hash(arr)
  freq = Hash.new(0)
  arr.each { |num| freq[num] += 1 }
  
  result = []
  freq.keys.sort.each do |value|
    freq[value].times { result << value }
  end
  
  result
end

# テストケース
p counting_sort([4, 2, 2, 8, 3, 3, 1], 8)
# => [1, 2, 2, 3, 3, 4, 8]

p counting_sort([1, 0, 3, 1, 3, 1], 3)
# => [0, 1, 1, 1, 3, 3]

p counting_sort_hash([64, 25, 12, 22, 11])
# => [11, 12, 22, 25, 64]
```

---

## 問題6: バケットソート

### 問題文

0.0から1.0の範囲の浮動小数点数の配列が与えられます。バケットソートを使用してソートしてください。

**入力例:**

```text
[0.897, 0.565, 0.656, 0.1234, 0.665, 0.3434]
```

**出力例:**

```text
[0.1234, 0.3434, 0.565, 0.656, 0.665, 0.897]
```

### アルゴリズム概説

配列を複数のバケット（範囲）に分割し、各バケット内で個別にソートします。最後に全バケットを連結します。

**時間計算量:** O(n + k) - 平均ケース、O(n²) - 最悪ケース  
**空間計算量:** O(n + k)

### 擬似コード

```text
関数 bucket_sort(配列, バケット数):
    バケット = バケット数個の空配列
    
    # 各要素を適切なバケットに配置
    配列の各要素について:
        インデックス = floor(要素 * バケット数)
        バケット[インデックス]に要素を追加
    
    # 各バケットをソート
    各バケットをソート
    
    # すべてのバケットを連結
    結果を返す
```

### 解答

```ruby
# 解法1: 基本的なバケットソート
def bucket_sort(arr, bucket_count = 10)
  return arr if arr.empty?
  
  # バケットを初期化
  buckets = Array.new(bucket_count) { [] }
  
  # 各要素を適切なバケットに配置
  arr.each do |num|
    index = (num * bucket_count).to_i
    index = bucket_count - 1 if index >= bucket_count
    buckets[index] << num
  end
  
  # 各バケットをソートして連結
  buckets.flat_map { |bucket| bucket.sort }
end

# 解法2: 整数配列用のバケットソート
def bucket_sort_integers(arr, bucket_size = 5)
  return arr if arr.empty?
  
  min_val = arr.min
  max_val = arr.max
  bucket_count = ((max_val - min_val) / bucket_size).to_i + 1
  
  buckets = Array.new(bucket_count) { [] }
  
  arr.each do |num|
    index = ((num - min_val) / bucket_size).to_i
    buckets[index] << num
  end
  
  buckets.flat_map { |bucket| bucket.sort }
end

# 解法3: 挿入ソートを使ったバケットソート
def bucket_sort_with_insertion(arr, bucket_count = 10)
  return arr if arr.empty?
  
  buckets = Array.new(bucket_count) { [] }
  
  arr.each do |num|
    index = (num * bucket_count).to_i
    index = bucket_count - 1 if index >= bucket_count
    buckets[index] << num
  end
  
  # 各バケットを挿入ソート
  buckets.each do |bucket|
    (1...bucket.length).each do |i|
      key = bucket[i]
      j = i - 1
      while j >= 0 && bucket[j] > key
        bucket[j + 1] = bucket[j]
        j -= 1
      end
      bucket[j + 1] = key
    end
  end
  
  buckets.flatten
end

# テストケース
p bucket_sort([0.897, 0.565, 0.656, 0.1234, 0.665, 0.3434])
# => [0.1234, 0.3434, 0.565, 0.656, 0.665, 0.897]

p bucket_sort_integers([29, 25, 3, 49, 9, 37, 21, 43])
# => [3, 9, 21, 25, 29, 37, 43, 49]
```

---

## 問題7: カスタムソート - 偶数を前、奇数を後ろ

### 問題文

整数の配列が与えられます。偶数を配列の前半に、奇数を後半に配置してください。各グループ内での順序は問いません。

**入力例:**

```text
[3, 1, 2, 4, 5, 6]
```

**出力例:**

```text
[2, 4, 6, 3, 1, 5]  # または他の有効な配置
```

### アルゴリズム概説

2つのポインタを使用するか、パーティション関数を使用します。または、selectで偶数と奇数を分けて連結することもできます。

**時間計算量:** O(n)  
**空間計算量:** O(n) - 新しい配列を作成する場合

### 擬似コード

```text
関数 segregate_even_odd(配列):
    偶数 = 配列から偶数を選択
    奇数 = 配列から奇数を選択
    偶数 + 奇数を返す
```

### 解答

```ruby
# 解法1: selectで分離（推奨、簡単）
def segregate_even_odd(arr)
  even = arr.select(&:even?)
  odd = arr.select(&:odd?)
  even + odd
end

# 解法2: partitionを使用
def segregate_even_odd_partition(arr)
  even, odd = arr.partition(&:even?)
  even + odd
end

# 解法3: 2ポインタでin-place
def segregate_even_odd_inplace(arr)
  left = 0
  right = arr.length - 1
  
  while left < right
    # 左から奇数を探す
    left += 1 while left < right && arr[left].even?
    
    # 右から偶数を探す
    right -= 1 while left < right && arr[right].odd?
    
    # 交換
    if left < right
      arr[left], arr[right] = arr[right], arr[left]
      left += 1
      right -= 1
    end
  end
  
  arr
end

# 解法4: sort_byを使用（偶数が前）
def segregate_even_odd_sort(arr)
  arr.sort_by { |x| [x % 2, x] }
end

# テストケース
p segregate_even_odd([3, 1, 2, 4, 5, 6])
# => [2, 4, 6, 3, 1, 5] または類似

p segregate_even_odd([12, 34, 45, 9, 8, 90, 3])
# => [12, 34, 8, 90, 45, 9, 3] または類似

p segregate_even_odd([1, 3, 5, 7])
# => [1, 3, 5, 7] (すべて奇数)
```

---

## 問題8: トップK頻出要素（ソート版）

### 問題文

整数の配列が与えられます。最も頻繁に出現するK個の要素を返してください。

**入力例:**

```text
nums = [1, 1, 1, 2, 2, 3]
k = 2
```

**出力例:**

```text
[1, 2]
```

### アルゴリズム概説

各要素の出現回数をカウントし、頻度でソートしてトップKを取得します。

**時間計算量:** O(n log n) - ソートが支配的  
**空間計算量:** O(n)

### 擬似コード

```text
関数 top_k_frequent(配列, k):
    頻度 = 各要素の出現回数をカウント
    
    頻度を値（頻度）の降順でソート
    
    上位k個の要素を返す
```

### 解答

```ruby
# 解法1: ハッシュとソート（推奨）
def top_k_frequent(nums, k)
  freq = nums.tally
  
  # 頻度の降順でソートし、トップk個の要素を取得
  freq.sort_by { |_, count| -count }.first(k).map(&:first)
end

# 解法2: sort_byとtake
def top_k_frequent_take(nums, k)
  nums.tally
      .sort_by { |num, count| -count }
      .take(k)
      .map { |num, _| num }
end

# 解法3: max_byを使用（k個取得）
def top_k_frequent_max(nums, k)
  freq = nums.tally
  
  result = []
  k.times do
    break if freq.empty?
    
    max_num = freq.max_by { |_, count| count }[0]
    result << max_num
    freq.delete(max_num)
  end
  
  result
end

# テストケース
p top_k_frequent([1, 1, 1, 2, 2, 3], 2)
# => [1, 2]

p top_k_frequent([1], 1)
# => [1]

p top_k_frequent([4, 1, -1, 2, -1, 2, 3], 2)
# => [-1, 2] または [2, -1]
```

---

## まとめ

このセクションでは、ソートアルゴリズムとその応用を学びました。

重要なポイントは以下の通りです。

1. 選択ソートと挿入ソートはO(n²)だが、実装が簡単です
2. カスタムソートにはsort_byが便利で読みやすいです
3. 計数ソートは値の範囲が小さい場合にO(n)で動作します
4. バケットソートは均等に分散したデータで効率的です
5. partitionやselectで簡単に要素を分離できます

ソートは多くのアルゴリズム問題の基礎となります。適切なソートアルゴリズムを選択することで、問題を効率的に解決できます。
