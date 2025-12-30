# Ruby 3.4 初級者向け問題集 - Part 1: 配列・基本操作

## 概要

このセクションでは、配列の基本的な操作を学びます。配列はプログラミングで最も頻繁に使用されるデータ構造の一つであり、要素の追加、削除、検索、変換など多くの操作を理解することが重要です。

---

## 問題1: 配列の合計値

### 問題文

整数の配列が与えられます。配列内のすべての要素の合計値を返してください。

**入力例:**

```text
[1, 2, 3, 4, 5]
```

**出力例:**

```text
15
```

### アルゴリズム概説

配列の全要素を走査し、累積的に加算していきます。Rubyでは`sum`メソッドや`reduce`メソッドを使用できますが、基本的なループでも実装可能です。

**時間計算量:** O(n) - 配列の全要素を一度走査  
**空間計算量:** O(1) - 追加のメモリは定数量のみ

### 擬似コード

```text
関数 array_sum(配列):
    合計 = 0
    配列の各要素について:
        合計 += 要素
    合計を返す
```

### 解答

```ruby
# 解法1: 基本的なループを使用
# 配列の各要素を順番に走査し、累積的に加算する
def array_sum_loop(arr)
  # 合計値を保持する変数を初期化
  total = 0
  
  # 配列の各要素をイテレート
  arr.each do |num|
    total += num
  end
  
  total
end

# 解法2: sumメソッドを使用（推奨）
# Rubyの組み込みメソッドで最も簡潔
def array_sum(arr)
  # 空配列の場合は0を返す
  arr.sum
end

# 解法3: reduceを使用
# 関数型プログラミングスタイル
def array_sum_reduce(arr)
  # 初期値0から始めて、各要素を累積的に加算
  # accはアキュムレータ（累積値）、numは現在の要素
  arr.reduce(0) { |acc, num| acc + num }
end

# テストケース
puts array_sum([1, 2, 3, 4, 5])  # => 15
puts array_sum([])               # => 0
puts array_sum([-1, 1])          # => 0
puts array_sum([100])            # => 100
```

---

## 問題2: 配列の最大値と最小値

### 問題文

整数の配列が与えられます。配列内の最大値と最小値を配列として返してください。

**入力例:**

```text
[3, 1, 4, 1, 5, 9, 2, 6]
```

**出力例:**

```text
[1, 9]  # [最小値, 最大値]
```

### アルゴリズム概説

配列を走査しながら、現在の最大値・最小値を追跡します。各要素を比較し、必要に応じて更新します。

**時間計算量:** O(n) - 配列を一度走査  
**空間計算量:** O(1) - 定数量のメモリのみ使用

### 擬似コード

```text
関数 min_max(配列):
    もし配列が空なら:
        nilを返す
    
    最小値 = 配列[0]
    最大値 = 配列[0]
    
    配列の各要素について:
        もし要素 < 最小値なら:
            最小値 = 要素
        もし要素 > 最大値なら:
            最大値 = 要素
    
    [最小値, 最大値]を返す
```

### 解答

```ruby
# 解法1: 手動で最大値・最小値を追跡
def min_max_manual(arr)
  # 空配列のエッジケース処理
  return nil if arr.empty?
  
  # 最初の要素で初期化
  min_val = arr[0]
  max_val = arr[0]
  
  # 2番目の要素から走査（最初は既に処理済み）
  arr[1..].each do |num|
    # 現在の最小値より小さければ更新
    min_val = num if num < min_val
    # 現在の最大値より大きければ更新
    max_val = num if num > max_val
  end
  
  [min_val, max_val]
end

# 解法2: 組み込みメソッドを使用（推奨）
def min_max(arr)
  return nil if arr.empty?
  
  # minmaxメソッドは[最小値, 最大値]の配列を返す
  arr.minmax
end

# 解法3: min, maxを個別に使用
def min_max_separate(arr)
  return nil if arr.empty?
  
  [arr.min, arr.max]
end

# テストケース
p min_max([3, 1, 4, 1, 5, 9, 2, 6])  # => [1, 9]
p min_max([5])                       # => [5, 5]
p min_max([-10, 0, 10])              # => [-10, 10]
p min_max([])                        # => nil
```

---

## 問題3: 配列の要素を2倍にする

### 問題文

整数の配列が与えられます。各要素を2倍にした新しい配列を返してください。

**入力例:**

```text
[1, 2, 3, 4, 5]
```

**出力例:**

```text
[2, 4, 6, 8, 10]
```

### アルゴリズム概説

配列の各要素に対して変換（2倍）を適用し、新しい配列を生成します。Rubyの`map`メソッドが最適です。

**時間計算量:** O(n) - 各要素を一度処理  
**空間計算量:** O(n) - 新しい配列を作成

### 擬似コード

```text
関数 double_array(配列):
    結果 = 空配列
    配列の各要素について:
        結果に (要素 * 2) を追加
    結果を返す
```

### 解答

```ruby
# 解法1: mapメソッドを使用（推奨）
# mapは各要素にブロックを適用し、新しい配列を返す
def double_array(arr)
  arr.map { |num| num * 2 }
end

# 解法2: 手動でループ
def double_array_loop(arr)
  result = []
  
  arr.each do |num|
    # 各要素を2倍にして結果配列に追加
    result << num * 2
  end
  
  result
end

# 解法3: 破壊的メソッドを使用（元の配列を変更）
def double_array_destructive!(arr)
  # map!は元の配列を直接変更する
  arr.map! { |num| num * 2 }
end

# テストケース
p double_array([1, 2, 3, 4, 5])  # => [2, 4, 6, 8, 10]
p double_array([0])              # => [0]
p double_array([-1, -2])         # => [-2, -4]
p double_array([])               # => []
```

---

## 問題4: 偶数のみをフィルタリング

### 問題文

整数の配列が与えられます。偶数のみを含む新しい配列を返してください。

**入力例:**

```text
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```

**出力例:**

```text
[2, 4, 6, 8, 10]
```

### アルゴリズム概説

配列の各要素をチェックし、条件（偶数であること）を満たす要素のみを選択します。`select`メソッドを使用します。

**時間計算量:** O(n) - 各要素を一度チェック  
**空間計算量:** O(k) - kは偶数の個数

### 擬似コード

```text
関数 filter_even(配列):
    結果 = 空配列
    配列の各要素について:
        もし要素 % 2 == 0 なら:
            結果に要素を追加
    結果を返す
```

### 解答

```ruby
# 解法1: selectメソッドを使用（推奨）
# selectは条件を満たす要素のみを含む新しい配列を返す
def filter_even(arr)
  # even?メソッドは偶数の場合trueを返す
  arr.select { |num| num.even? }
end

# 解法2: 条件式を明示的に記述
def filter_even_explicit(arr)
  arr.select { |num| num % 2 == 0 }
end

# 解法3: 手動でループ
def filter_even_loop(arr)
  result = []
  
  arr.each do |num|
    # 偶数かどうかをチェック
    result << num if num.even?
  end
  
  result
end

# 解法4: rejectを使用して奇数を除外
def filter_even_reject(arr)
  # rejectは条件を満たす要素を除外する
  arr.reject { |num| num.odd? }
end

# テストケース
p filter_even([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])  # => [2, 4, 6, 8, 10]
p filter_even([1, 3, 5])                         # => []
p filter_even([2, 4, 6])                         # => [2, 4, 6]
p filter_even([])                                # => []
p filter_even([-2, -1, 0, 1, 2])                 # => [-2, 0, 2]
```

---

## 問題5: 配列の反転

### 問題文

配列が与えられます。要素の順序を反転した新しい配列を返してください。

**入力例:**

```text
[1, 2, 3, 4, 5]
```

**出力例:**

```text
[5, 4, 3, 2, 1]
```

### アルゴリズム概説

配列の最後の要素から最初の要素に向かって新しい配列を構築します。または、両端からスワップしていく方法もあります。

**時間計算量:** O(n) - 全要素を処理  
**空間計算量:** O(n) - 新しい配列を作成（破壊的メソッドならO(1)）

### 擬似コード

```text
関数 reverse_array(配列):
    結果 = 空配列
    インデックス = 配列の長さ - 1
    
    インデックス >= 0 の間:
        結果に 配列[インデックス] を追加
        インデックス -= 1
    
    結果を返す
```

### 解答

```ruby
# 解法1: reverseメソッドを使用（推奨）
def reverse_array(arr)
  # 新しい配列を返す（元の配列は変更されない）
  arr.reverse
end

# 解法2: 手動で逆順に構築
def reverse_array_manual(arr)
  result = []
  
  # 最後のインデックスから0まで逆順にイテレート
  (arr.length - 1).downto(0) do |i|
    result << arr[i]
  end
  
  result
end

# 解法3: 両端からスワップ（破壊的、in-place）
def reverse_array_inplace!(arr)
  left = 0
  right = arr.length - 1
  
  while left < right
    # 両端の要素を交換
    arr[left], arr[right] = arr[right], arr[left]
    left += 1
    right -= 1
  end
  
  arr
end

# 解法4: reverse_eachを使用
def reverse_array_each(arr)
  result = []
  # reverse_eachは逆順にイテレートする
  arr.reverse_each { |elem| result << elem }
  result
end

# テストケース
p reverse_array([1, 2, 3, 4, 5])  # => [5, 4, 3, 2, 1]
p reverse_array(['a', 'b', 'c']) # => ['c', 'b', 'a']
p reverse_array([1])             # => [1]
p reverse_array([])              # => []
```

---

## 問題6: 配列内の特定要素のカウント

### 問題文

配列と検索する値が与えられます。配列内でその値が何回出現するかをカウントしてください。

**入力例:**

```text
配列: [1, 2, 2, 3, 2, 4, 2]
値: 2
```

**出力例:**

```text
4
```

### アルゴリズム概説

配列を走査し、目標値と一致する要素をカウントします。`count`メソッドが最も効率的です。

**時間計算量:** O(n) - 全要素をチェック  
**空間計算量:** O(1) - カウンター変数のみ

### 擬似コード

```text
関数 count_element(配列, 値):
    カウント = 0
    配列の各要素について:
        もし要素 == 値なら:
            カウント += 1
    カウントを返す
```

### 解答

```ruby
# 解法1: countメソッドを使用（推奨）
def count_element(arr, target)
  # countメソッドに引数を渡すと、その値の出現回数を返す
  arr.count(target)
end

# 解法2: countメソッドとブロック
def count_element_block(arr, target)
  # ブロックで条件を指定することも可能
  arr.count { |elem| elem == target }
end

# 解法3: 手動でカウント
def count_element_manual(arr, target)
  count = 0
  
  arr.each do |elem|
    # 一致する要素をカウント
    count += 1 if elem == target
  end
  
  count
end

# 解法4: selectしてサイズを取得
def count_element_select(arr, target)
  arr.select { |elem| elem == target }.size
end

# テストケース
puts count_element([1, 2, 2, 3, 2, 4, 2], 2)  # => 4
puts count_element([1, 1, 1, 1, 1], 1)        # => 5
puts count_element([1, 2, 3], 5)              # => 0
puts count_element([], 1)                     # => 0
puts count_element(['a', 'b', 'a'], 'a')      # => 2
```

---

## 問題7: 配列の重複を除去

### 問題文

配列が与えられます。重複する要素を除去し、ユニークな要素のみを含む配列を返してください。元の順序は保持してください。

**入力例:**

```text
[1, 2, 2, 3, 4, 4, 5]
```

**出力例:**

```text
[1, 2, 3, 4, 5]
```

### アルゴリズム概説

既に見た要素を追跡し、新しい要素のみを結果に追加します。Rubyの`uniq`メソッドが最適です。

**時間計算量:** O(n) - 各要素を一度処理（ハッシュを使用した場合）  
**空間計算量:** O(n) - 見た要素を追跡するためのセット

### 擬似コード

```text
関数 remove_duplicates(配列):
    見た要素 = 空セット
    結果 = 空配列
    
    配列の各要素について:
        もし要素が見た要素に含まれていないなら:
            見た要素に要素を追加
            結果に要素を追加
    
    結果を返す
```

### 解答

```ruby
# 解法1: uniqメソッドを使用（推奨）
def remove_duplicates(arr)
  # uniqは重複を除去した新しい配列を返す
  # 元の順序は保持される
  arr.uniq
end

# 解法2: 手動でセットを使用
def remove_duplicates_manual(arr)
  require 'set'
  
  seen = Set.new  # 見た要素を追跡するセット
  result = []
  
  arr.each do |elem|
    unless seen.include?(elem)
      seen.add(elem)
      result << elem
    end
  end
  
  result
end

# 解法3: ハッシュを使用（Setがない場合）
def remove_duplicates_hash(arr)
  seen = {}
  result = []
  
  arr.each do |elem|
    unless seen[elem]
      seen[elem] = true
      result << elem
    end
  end
  
  result
end

# 解法4: each_with_objectを使用
def remove_duplicates_each_with_object(arr)
  arr.each_with_object([]) do |elem, result|
    result << elem unless result.include?(elem)
  end
end

# テストケース
p remove_duplicates([1, 2, 2, 3, 4, 4, 5])       # => [1, 2, 3, 4, 5]
p remove_duplicates([1, 1, 1, 1])                # => [1]
p remove_duplicates(['a', 'b', 'a', 'c', 'b'])   # => ['a', 'b', 'c']
p remove_duplicates([])                          # => []
p remove_duplicates([1, 2, 3])                   # => [1, 2, 3]
```

---

## 問題8: 配列の要素を平坦化

### 問題文

ネストした配列が与えられます。すべての要素を1次元の配列に平坦化してください。

**入力例:**

```text
[[1, 2], [3, [4, 5]], 6]
```

**出力例:**

```text
[1, 2, 3, 4, 5, 6]
```

### アルゴリズム概説

再帰的にネストした配列を処理し、すべての要素を1次元に展開します。`flatten`メソッドが最適です。

**時間計算量:** O(n) - nは全要素数  
**空間計算量:** O(n) - 結果配列のサイズ

### 擬似コード

```text
関数 flatten_array(配列):
    結果 = 空配列
    
    配列の各要素について:
        もし要素が配列なら:
            結果 += flatten_array(要素)  # 再帰呼び出し
        そうでなければ:
            結果に要素を追加
    
    結果を返す
```

### 解答

```ruby
# 解法1: flattenメソッドを使用（推奨）
def flatten_array(arr)
  # flattenは完全に平坦化する
  arr.flatten
end

# 解法2: 1段階のみ平坦化
def flatten_one_level(arr)
  # flatten(1)は1段階のみ平坦化
  arr.flatten(1)
end

# 解法3: 再帰的に手動実装
def flatten_array_recursive(arr)
  result = []
  
  arr.each do |elem|
    if elem.is_a?(Array)
      # 配列の場合は再帰的に平坦化して結果に連結
      result.concat(flatten_array_recursive(elem))
    else
      # 配列でない場合はそのまま追加
      result << elem
    end
  end
  
  result
end

# 解法4: スタックを使用（再帰なし）
def flatten_array_iterative(arr)
  result = []
  stack = arr.dup  # 元の配列をコピー
  
  while !stack.empty?
    elem = stack.shift  # 先頭から取り出し
    
    if elem.is_a?(Array)
      # 配列の場合はその要素をスタックの先頭に追加
      stack.unshift(*elem)
    else
      result << elem
    end
  end
  
  result
end

# テストケース
p flatten_array([[1, 2], [3, [4, 5]], 6])  # => [1, 2, 3, 4, 5, 6]
p flatten_array([1, [2, [3, [4]]]])        # => [1, 2, 3, 4]
p flatten_array([[]])                       # => []
p flatten_array([1, 2, 3])                  # => [1, 2, 3]
```

---

## 問題9: 配列の回転

### 問題文

配列と回転数kが与えられます。配列を右にk回回転させた結果を返してください。

**入力例:**

```text
配列: [1, 2, 3, 4, 5]
k: 2
```

**出力例:**

```text
[4, 5, 1, 2, 3]
```

### アルゴリズム概説

配列を右にk回回転させることは、最後のk要素を先頭に移動することと同じです。kが配列の長さより大きい場合は、kを配列の長さで割った余りを使用します。

**時間計算量:** O(n) - 配列を再構築  
**空間計算量:** O(n) - 新しい配列を作成

### 擬似コード

```text
関数 rotate_array(配列, k):
    n = 配列の長さ
    k = k % n  # kが配列長より大きい場合に対応
    
    # 最後のk要素 + 最初の(n-k)要素
    配列の最後k要素 + 配列の最初(n-k)要素を返す
```

### 解答

```ruby
# 解法1: rotateメソッドを使用（推奨）
def rotate_array(arr, k)
  return arr if arr.empty?
  
  # Rubyのrotateは左回転なので、負の値を渡して右回転
  arr.rotate(-k)
end

# 解法2: スライスを使用
def rotate_array_slice(arr, k)
  return arr if arr.empty?
  
  n = arr.length
  k = k % n  # kを正規化（配列長より大きい場合に対応）
  
  # 最後のk要素を先頭に移動
  arr[-k..] + arr[0...-k]
end

# 解法3: 手動で新しい配列を構築
def rotate_array_manual(arr, k)
  return arr if arr.empty?
  
  n = arr.length
  k = k % n
  result = Array.new(n)
  
  # 各要素の新しい位置を計算
  arr.each_with_index do |elem, i|
    new_index = (i + k) % n
    result[new_index] = elem
  end
  
  result
end

# 解法4: 3回の反転を使用（in-place）
def rotate_array_reverse!(arr, k)
  return arr if arr.empty?
  
  n = arr.length
  k = k % n
  
  # 配列全体を反転
  arr.reverse!
  # 最初のk要素を反転
  arr[0...k] = arr[0...k].reverse
  # 残りの要素を反転
  arr[k...n] = arr[k...n].reverse
  
  arr
end

# テストケース
p rotate_array([1, 2, 3, 4, 5], 2)   # => [4, 5, 1, 2, 3]
p rotate_array([1, 2, 3, 4, 5], 0)   # => [1, 2, 3, 4, 5]
p rotate_array([1, 2, 3, 4, 5], 5)   # => [1, 2, 3, 4, 5]
p rotate_array([1, 2, 3, 4, 5], 7)   # => [4, 5, 1, 2, 3] (7 % 5 = 2)
p rotate_array([], 3)                 # => []
```

---

## 問題10: 2つの配列のマージ

### 問題文

2つのソート済み配列が与えられます。これらをマージして、1つのソート済み配列を返してください。

**入力例:**

```text
配列1: [1, 3, 5, 7]
配列2: [2, 4, 6, 8]
```

**出力例:**

```text
[1, 2, 3, 4, 5, 6, 7, 8]
```

### アルゴリズム概説

両方の配列の先頭から比較しながら、小さい方を結果に追加していきます。これはマージソートのマージステップと同じアルゴリズムです。

**時間計算量:** O(n + m) - 両配列の全要素を一度処理  
**空間計算量:** O(n + m) - 結果配列のサイズ

### 擬似コード

```text
関数 merge_sorted_arrays(配列1, 配列2):
    結果 = 空配列
    i = 0, j = 0
    
    i < 配列1の長さ かつ j < 配列2の長さ の間:
        もし 配列1[i] <= 配列2[j] なら:
            結果に 配列1[i] を追加
            i += 1
        そうでなければ:
            結果に 配列2[j] を追加
            j += 1
    
    # 残りの要素を追加
    結果に配列1の残りを追加
    結果に配列2の残りを追加
    
    結果を返す
```

### 解答

```ruby
# 解法1: 2ポインタ法（効率的な実装）
def merge_sorted_arrays(arr1, arr2)
  result = []
  i = 0  # arr1のポインタ
  j = 0  # arr2のポインタ
  
  # 両方の配列に要素がある間、比較しながらマージ
  while i < arr1.length && j < arr2.length
    if arr1[i] <= arr2[j]
      result << arr1[i]
      i += 1
    else
      result << arr2[j]
      j += 1
    end
  end
  
  # 残りの要素を追加（片方の配列が先に終わった場合）
  result.concat(arr1[i..]) if i < arr1.length
  result.concat(arr2[j..]) if j < arr2.length
  
  result
end

# 解法2: 連結してソート（シンプルだが効率は劣る）
def merge_sorted_simple(arr1, arr2)
  # O(n log n)の計算量になるが、コードはシンプル
  (arr1 + arr2).sort
end

# 解法3: Ruby的な実装
def merge_sorted_ruby(arr1, arr2)
  # 連結して配列のソートメソッドを使用
  [*arr1, *arr2].sort
end

# 解法4: 再帰的な実装
def merge_sorted_recursive(arr1, arr2)
  # ベースケース
  return arr2 if arr1.empty?
  return arr1 if arr2.empty?
  
  if arr1[0] <= arr2[0]
    [arr1[0]] + merge_sorted_recursive(arr1[1..], arr2)
  else
    [arr2[0]] + merge_sorted_recursive(arr1, arr2[1..])
  end
end

# テストケース
p merge_sorted_arrays([1, 3, 5, 7], [2, 4, 6, 8])  # => [1, 2, 3, 4, 5, 6, 7, 8]
p merge_sorted_arrays([1, 2, 3], [4, 5, 6])        # => [1, 2, 3, 4, 5, 6]
p merge_sorted_arrays([], [1, 2, 3])               # => [1, 2, 3]
p merge_sorted_arrays([1, 2, 3], [])               # => [1, 2, 3]
p merge_sorted_arrays([1, 1, 1], [1, 1])           # => [1, 1, 1, 1, 1]
```

---

## まとめ

このセクションでは、配列の基本操作を10問を通じて学びました。

**学んだ主なメソッド:**

- `sum`, `reduce` - 集計操作
- `min`, `max`, `minmax` - 最大・最小値の取得
- `map` - 要素の変換
- `select`, `reject` - フィルタリング
- `reverse` - 反転
- `count` - カウント
- `uniq` - 重複除去
- `flatten` - 平坦化
- `rotate` - 回転
- `sort` - ソート

**重要なポイント:**

1. Rubyには多くの便利な組み込みメソッドがある
2. 計算量を意識したアルゴリズム選択が重要
3. エッジケース（空配列など）の処理を忘れずに
4. 破壊的メソッド（`!`付き）と非破壊的メソッドの違いを理解する
