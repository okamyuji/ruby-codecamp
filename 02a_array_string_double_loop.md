# 配列と文字列 - 基礎（二重ループ）

## 概要

このセクションでは、二重ループを使用した配列と文字列の問題を学びます。二重ループは、配列のすべてのペアを調べる必要がある問題で頻繁に使用されます。時間計算量はO(n²)になることが多いため、効率を意識することが重要です。

---

## 問題1: 配列内のすべてのペアの和を求める

### 問題文

整数の配列が与えられます。配列内のすべての異なるペア（i, j）について、i < j の条件下でarr[i] + arr[j]の値をすべて求めてください。

**入力例:**

```text
[1, 2, 3]
```

**出力例:**

```text
[3, 4, 5]  # (1+2, 1+3, 2+3)
```

### アルゴリズム概説

外側のループで最初の要素を選び、内側のループでそれより後ろの要素を選んでペアを作ります。これにより、すべての一意なペアを生成できます。

**時間計算量:** O(n²) - すべてのペアを調べる  
**空間計算量:** O(n²) - 最悪の場合、すべてのペアを保存

### 擬似コード

```text
関数 all_pair_sums(配列):
    結果 = 空配列
    
    配列の各インデックスiについて:
        インデックスi+1から配列の最後まで、各インデックスjについて:
            結果に 配列[i] + 配列[j] を追加
    
    結果を返す
```

### 解答

```ruby
# 解法1: 基本的な二重ループ
def all_pair_sums(arr)
  result = []
  
  # 外側のループ: 最初の要素を選ぶ
  arr.each_with_index do |num1, i|
    # 内側のループ: i より後ろの要素を選ぶ
    (i + 1...arr.length).each do |j|
      result << num1 + arr[j]
    end
  end
  
  result
end

# 解法2: 範囲を使った実装
def all_pair_sums_range(arr)
  result = []
  
  (0...arr.length).each do |i|
    (i + 1...arr.length).each do |j|
      result << arr[i] + arr[j]
    end
  end
  
  result
end

# 解法3: combination を使った関数型スタイル
def all_pair_sums_combination(arr)
  arr.combination(2).map { |a, b| a + b }
end

# テストケース
p all_pair_sums([1, 2, 3])           # => [3, 4, 5]
p all_pair_sums([1, 2, 3, 4])        # => [3, 4, 5, 5, 6, 7]
p all_pair_sums([5])                 # => []
p all_pair_sums([])                  # => []
p all_pair_sums([1, 1, 1])           # => [2, 2, 2]
```

---

## 問題2: Two Sum（ペアの和が目標値と一致）

### 問題文

整数の配列と目標値が与えられます。配列内の2つの数の和が目標値と一致するようなインデックスのペアを返してください。各入力には必ず1つの解が存在すると仮定します。

**入力例:**

```text
nums = [2, 7, 11, 15]
target = 9
```

**出力例:**

```text
[0, 1]  # nums[0] + nums[1] = 2 + 7 = 9
```

### アルゴリズム概説

二重ループを使用すると単純ですが、O(n²)の計算量になります。より効率的な解法として、ハッシュテーブルを使用してO(n)で解くことができます。

**時間計算量:** O(n²) - 二重ループ版、O(n) - ハッシュテーブル版  
**空間計算量:** O(1) - 二重ループ版、O(n) - ハッシュテーブル版

### 擬似コード

```text
関数 two_sum(配列, 目標値):
    配列の各インデックスiについて:
        インデックスi+1から配列の最後まで、各インデックスjについて:
            もし 配列[i] + 配列[j] == 目標値 なら:
                [i, j]を返す
    
    nilを返す
```

### 解答

```ruby
# 解法1: 二重ループ（O(n²)）
def two_sum_brute_force(nums, target)
  nums.each_with_index do |num1, i|
    (i + 1...nums.length).each do |j|
      return [i, j] if num1 + nums[j] == target
    end
  end
  
  nil
end

# 解法2: ハッシュテーブル（O(n)、推奨）
def two_sum(nums, target)
  hash = {}
  
  nums.each_with_index do |num, i|
    complement = target - num
    return [hash[complement], i] if hash.key?(complement)
    hash[num] = i
  end
  
  nil
end

# 解法3: ハッシュテーブル（2パス）
def two_sum_two_pass(nums, target)
  hash = {}
  
  # 1パス目: すべての要素をハッシュに格納
  nums.each_with_index { |num, i| hash[num] = i }
  
  # 2パス目: 補数を探す
  nums.each_with_index do |num, i|
    complement = target - num
    if hash.key?(complement) && hash[complement] != i
      return [i, hash[complement]]
    end
  end
  
  nil
end

# テストケース
p two_sum([2, 7, 11, 15], 9)     # => [0, 1]
p two_sum([3, 2, 4], 6)          # => [1, 2]
p two_sum([3, 3], 6)             # => [0, 1]
p two_sum([1, 2, 3, 4], 7)       # => [2, 3]
```

---

## 問題3: Three Sum（3つの数の和がゼロ）

### 問題文

整数の配列が与えられます。配列内の3つの要素の和が0になるすべての一意な組み合わせを見つけてください。

**入力例:**

```text
[-1, 0, 1, 2, -1, -4]
```

**出力例:**

```text
[[-1, -1, 2], [-1, 0, 1]]
```

### アルゴリズム概説

まず配列をソートします。その後、各要素を固定して、残りの2つの要素をTwo Pointersで探します。重複を避けるために、同じ値が連続する場合はスキップします。

**時間計算量:** O(n²) - ソートがO(n log n)、各要素についてO(n)の探索  
**空間計算量:** O(1) - 結果配列を除く

### 擬似コード

```text
関数 three_sum(配列):
    配列をソート
    結果 = 空配列
    
    配列の各インデックスiについて:
        もし i > 0 かつ 配列[i] == 配列[i-1] なら:
            continue  # 重複をスキップ
        
        left = i + 1
        right = 配列の長さ - 1
        
        left < right の間:
            合計 = 配列[i] + 配列[left] + 配列[right]
            
            もし 合計 == 0 なら:
                結果に [配列[i], 配列[left], 配列[right]] を追加
                left を進める、right を戻す
                重複をスキップ
            もし 合計 < 0 なら:
                left を進める
            そうでなければ:
                right を戻す
    
    結果を返す
```

### 解答

```ruby
# 解法1: ソート + Two Pointers（推奨）
def three_sum(nums)
  nums.sort!
  result = []
  
  (0...nums.length - 2).each do |i|
    # 重複する値をスキップ
    next if i > 0 && nums[i] == nums[i - 1]
    
    left = i + 1
    right = nums.length - 1
    
    while left < right
      sum = nums[i] + nums[left] + nums[right]
      
      if sum == 0
        result << [nums[i], nums[left], nums[right]]
        
        # 重複をスキップ
        left += 1
        right -= 1
        left += 1 while left < right && nums[left] == nums[left - 1]
        right -= 1 while left < right && nums[right] == nums[right + 1]
      elsif sum < 0
        left += 1
      else
        right -= 1
      end
    end
  end
  
  result
end

# 解法2: 三重ループ（効率悪い、O(n³)）
def three_sum_brute_force(nums)
  result = []
  seen = Set.new
  
  (0...nums.length).each do |i|
    (i + 1...nums.length).each do |j|
      (j + 1...nums.length).each do |k|
        if nums[i] + nums[j] + nums[k] == 0
          triplet = [nums[i], nums[j], nums[k]].sort
          result << triplet unless seen.include?(triplet)
          seen.add(triplet)
        end
      end
    end
  end
  
  result
end

# テストケース
p three_sum([-1, 0, 1, 2, -1, -4])  # => [[-1, -1, 2], [-1, 0, 1]]
p three_sum([0, 0, 0])               # => [[0, 0, 0]]
p three_sum([0, 1, 1])               # => []
```

---

## 問題4: バブルソートの実装

### 問題文

配列が与えられます。バブルソートアルゴリズムを使用して配列をソートしてください。

**入力例:**

```text
[5, 2, 8, 1, 9]
```

**出力例:**

```text
[1, 2, 5, 8, 9]
```

### アルゴリズム概説

バブルソートは、隣接する要素を比較して、順序が逆であれば交換を繰り返すアルゴリズムです。各パスで最大の要素が末尾に「浮き上がる」ため、バブルソートと呼ばれます。

**時間計算量:** O(n²) - 最悪・平均ケース、O(n) - 最良ケース（既にソート済み）  
**空間計算量:** O(1) - in-placeソート

### 擬似コード

```text
関数 bubble_sort(配列):
    n = 配列の長さ
    
    n-1 回繰り返す（外側のループ）:
        swapped = false
        
        配列の先頭から n-i-2 まで（内側のループ）:
            もし 配列[j] > 配列[j+1] なら:
                配列[j] と 配列[j+1] を交換
                swapped = true
        
        もし swapped == false なら:
            break  # すでにソート済み
    
    配列を返す
```

### 解答

```ruby
# 解法1: 基本的なバブルソート
def bubble_sort(arr)
  n = arr.length
  
  # 外側のループ: パスの回数
  (n - 1).times do |i|
    # 内側のループ: 隣接要素の比較
    (n - i - 1).times do |j|
      if arr[j] > arr[j + 1]
        # 交換
        arr[j], arr[j + 1] = arr[j + 1], arr[j]
      end
    end
  end
  
  arr
end

# 解法2: 最適化版（早期終了）
def bubble_sort_optimized(arr)
  n = arr.length
  
  (n - 1).times do |i|
    swapped = false
    
    (n - i - 1).times do |j|
      if arr[j] > arr[j + 1]
        arr[j], arr[j + 1] = arr[j + 1], arr[j]
        swapped = true
      end
    end
    
    # 交換が発生しなければ、すでにソート済み
    break unless swapped
  end
  
  arr
end

# 解法3: 降順バブルソート
def bubble_sort_descending(arr)
  n = arr.length
  
  (n - 1).times do |i|
    (n - i - 1).times do |j|
      if arr[j] < arr[j + 1]  # 比較演算子を逆にする
        arr[j], arr[j + 1] = arr[j + 1], arr[j]
      end
    end
  end
  
  arr
end

# テストケース
p bubble_sort([5, 2, 8, 1, 9])       # => [1, 2, 5, 8, 9]
p bubble_sort([3, 2, 1])             # => [1, 2, 3]
p bubble_sort([1, 2, 3])             # => [1, 2, 3]
p bubble_sort([1])                   # => [1]
p bubble_sort_descending([5, 2, 8, 1, 9])  # => [9, 8, 5, 2, 1]
```

---

## 問題5: 行列の転置

### 問題文

m × n の行列が与えられます。この行列を転置（行と列を入れ替え）してください。

**入力例:**

```text
[[1, 2, 3],
 [4, 5, 6]]
```

**出力例:**

```text
[[1, 4],
 [2, 5],
 [3, 6]]
```

### アルゴリズム概説

元の行列の行と列を入れ替えることで、新しい行列を作成します。元の行列がm × nであれば、転置後はn × mになります。

**時間計算量:** O(m × n) - すべての要素を一度処理  
**空間計算量:** O(m × n) - 新しい行列を作成

### 擬似コード

```text
関数 transpose(行列):
    rows = 行列の行数
    cols = 行列の列数
    結果 = cols × rows の新しい行列
    
    各行iについて:
        各列jについて:
            結果[j][i] = 行列[i][j]
    
    結果を返す
```

### 解答

```ruby
# 解法1: 二重ループで転置
def transpose(matrix)
  return [] if matrix.empty?
  
  rows = matrix.length
  cols = matrix[0].length
  result = Array.new(cols) { Array.new(rows) }
  
  # 各要素を転置位置にコピー
  rows.times do |i|
    cols.times do |j|
      result[j][i] = matrix[i][j]
    end
  end
  
  result
end

# 解法2: Rubyのtransposeメソッド（推奨）
def transpose_builtin(matrix)
  matrix.transpose
end

# 解法3: mapを使った関数型スタイル
def transpose_functional(matrix)
  return [] if matrix.empty?
  
  cols = matrix[0].length
  
  (0...cols).map do |j|
    matrix.map { |row| row[j] }
  end
end

# 解法4: zipを使った実装
def transpose_zip(matrix)
  matrix[0].zip(*matrix[1..-1])
end

# テストケース
p transpose([[1, 2, 3], [4, 5, 6]])
# => [[1, 4], [2, 5], [3, 6]]

p transpose([[1, 2], [3, 4], [5, 6]])
# => [[1, 3, 5], [2, 4, 6]]

p transpose([[1]])
# => [[1]]

p transpose([[1, 2, 3]])
# => [[1], [2], [3]]
```

---

## 問題6: 最大の積を持つペアを見つける

### 問題文

整数の配列が与えられます。配列内の2つの要素の積が最大となるペアを見つけてください。

**入力例:**

```text
[3, 4, 5, 2]
```

**出力例:**

```text
20  # 4 * 5 = 20
```

### アルゴリズム概説

すべてのペアの積を計算して最大値を見つけるか、配列をソートして最大の2つの要素を掛けるという方法があります。負の数がある場合は注意が必要です。

**時間計算量:** O(n²) - 二重ループ版、O(n log n) - ソート版  
**空間計算量:** O(1)

### 擬似コード

```text
関数 max_product_pair(配列):
    max_product = -無限大
    
    配列の各インデックスiについて:
        インデックスi+1から配列の最後まで、各インデックスjについて:
            product = 配列[i] * 配列[j]
            もし product > max_product なら:
                max_product = product
    
    max_productを返す
```

### 解答

```ruby
# 解法1: 二重ループ
def max_product_pair_brute_force(arr)
  return nil if arr.length < 2
  
  max_product = -Float::INFINITY
  
  arr.each_with_index do |num1, i|
    (i + 1...arr.length).each do |j|
      product = num1 * arr[j]
      max_product = product if product > max_product
    end
  end
  
  max_product
end

# 解法2: ソートして最大の2つを掛ける（正の数のみの場合）
def max_product_pair_sorted(arr)
  return nil if arr.length < 2
  
  sorted = arr.sort
  # 最大の2つの要素の積
  sorted[-1] * sorted[-2]
end

# 解法3: 負の数も考慮した完全版
def max_product_pair(arr)
  return nil if arr.length < 2
  
  sorted = arr.sort
  
  # 最大の2つの正の数の積と、最小の2つの負の数の積を比較
  max_positive = sorted[-1] * sorted[-2]
  max_negative = sorted[0] * sorted[1]
  
  [max_positive, max_negative].max
end

# 解法4: 1パスで解く
def max_product_pair_one_pass(arr)
  return nil if arr.length < 2
  
  # 最大の2つと最小の2つを追跡
  max1 = max2 = -Float::INFINITY
  min1 = min2 = Float::INFINITY
  
  arr.each do |num|
    if num > max1
      max2 = max1
      max1 = num
    elsif num > max2
      max2 = num
    end
    
    if num < min1
      min2 = min1
      min1 = num
    elsif num < min2
      min2 = num
    end
  end
  
  [max1 * max2, min1 * min2].max
end

# テストケース
p max_product_pair([3, 4, 5, 2])         # => 20 (4 * 5)
p max_product_pair([1, 2, 3, 4])         # => 12 (3 * 4)
p max_product_pair([-10, -3, 5, 6])     # => 30 (5 * 6 または -10 * -3)
p max_product_pair([-10, -20, 1, 5])    # => 200 (-10 * -20)
```

---

## 問題7: 行列の対角線の和

### 問題文

n × n の正方行列が与えられます。主対角線と副対角線の要素の和を求めてください。ただし、中央の要素が重複する場合は1回だけカウントします。

**入力例:**

```text
[[1, 2, 3],
 [4, 5, 6],
 [7, 8, 9]]
```

**出力例:**

```text
25  # 1+5+9+3+7 = 25
```

### アルゴリズム概説

主対角線はi == jの要素、副対角線はi + j == n - 1の要素です。一度のループですべての対角線要素を訪問できます。

**時間計算量:** O(n) - 対角線の要素数  
**空間計算量:** O(1)

### 擬似コード

```text
関数 diagonal_sum(行列):
    n = 行列のサイズ
    合計 = 0
    
    各iについて:
        合計 += 行列[i][i]           # 主対角線
        合計 += 行列[i][n - 1 - i]   # 副対角線
    
    もし n が奇数なら:
        # 中央要素を重複して加算したので引く
        合計 -= 行列[n/2][n/2]
    
    合計を返す
```

### 解答

```ruby
# 解法1: 効率的な1パス実装
def diagonal_sum(matrix)
  n = matrix.length
  sum = 0
  
  n.times do |i|
    # 主対角線
    sum += matrix[i][i]
    # 副対角線
    sum += matrix[i][n - 1 - i]
  end
  
  # nが奇数の場合、中央要素が重複するので引く
  sum -= matrix[n / 2][n / 2] if n.odd?
  
  sum
end

# 解法2: 二重ループで条件チェック
def diagonal_sum_loop(matrix)
  n = matrix.length
  sum = 0
  
  n.times do |i|
    n.times do |j|
      # 主対角線または副対角線の要素
      if i == j || i + j == n - 1
        sum += matrix[i][j]
      end
    end
  end
  
  sum
end

# 解法3: 主対角線と副対角線を別々に計算
def diagonal_sum_separate(matrix)
  n = matrix.length
  
  # 主対角線の和
  primary = (0...n).sum { |i| matrix[i][i] }
  
  # 副対角線の和
  secondary = (0...n).sum { |i| matrix[i][n - 1 - i] }
  
  # 合計から中央要素の重複を引く（nが奇数の場合）
  total = primary + secondary
  total -= matrix[n / 2][n / 2] if n.odd?
  
  total
end

# テストケース
p diagonal_sum([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
# => 25 (1+5+9+3+7)

p diagonal_sum([[1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1]])
# => 8 (すべて1なので、8個の対角線要素)

p diagonal_sum([[5]])
# => 5 (1×1行列)

p diagonal_sum([[1, 2], [3, 4]])
# => 10 (1+4+2+3)
```

---

## 問題8: 配列内の重複するペアの数

### 問題文

整数の配列が与えられます。同じ値を持つ要素のペアがいくつあるかを数えてください。

**入力例:**

```text
[1, 2, 1, 2, 3]
```

**出力例:**

```text
2  # (0,2)と(1,3)の2ペア
```

### アルゴリズム概説

二重ループですべてのペアをチェックするか、各値の出現回数をカウントして組み合わせ数を計算します。後者の方が効率的です。

**時間計算量:** O(n²) - 二重ループ版、O(n) - ハッシュ版  
**空間計算量:** O(1) - 二重ループ版、O(n) - ハッシュ版

### 擬似コード

```text
関数 count_duplicate_pairs(配列):
    カウント = 0
    
    配列の各インデックスiについて:
        インデックスi+1から配列の最後まで、各インデックスjについて:
            もし 配列[i] == 配列[j] なら:
                カウント += 1
    
    カウントを返す
```

### 解答

```ruby
# 解法1: 二重ループ（O(n²)）
def count_duplicate_pairs_brute_force(arr)
  count = 0
  
  arr.each_with_index do |num1, i|
    (i + 1...arr.length).each do |j|
      count += 1 if num1 == arr[j]
    end
  end
  
  count
end

# 解法2: ハッシュで頻度カウント（O(n)、推奨）
def count_duplicate_pairs(arr)
  freq = Hash.new(0)
  
  # 各値の出現回数をカウント
  arr.each { |num| freq[num] += 1 }
  
  # 各値について、組み合わせ数C(n, 2) = n * (n - 1) / 2 を計算
  count = 0
  freq.each_value do |n|
    count += n * (n - 1) / 2 if n > 1
  end
  
  count
end

# 解法3: 関数型スタイル
def count_duplicate_pairs_functional(arr)
  arr.group_by(&:itself)
     .values
     .sum { |group| group.size * (group.size - 1) / 2 }
end

# テストケース
p count_duplicate_pairs([1, 2, 1, 2, 3])      # => 2
p count_duplicate_pairs([1, 1, 1, 1])         # => 6 (C(4,2) = 6)
p count_duplicate_pairs([1, 2, 3, 4])         # => 0
p count_duplicate_pairs([5, 5, 5])            # => 3 (C(3,2) = 3)
p count_duplicate_pairs([])                   # => 0
```

---

## まとめ

このセクションでは、二重ループを使用した配列と文字列の問題を学びました。

重要なポイントは以下の通りです。

1. 二重ループの基本パターン（外側でi、内側でi+1から開始）を理解します
2. 時間計算量がO(n²)になることを意識します
3. ハッシュテーブルやソートで計算量を改善できる場合があります
4. combinationメソッドなど、Rubyの便利なメソッドも活用できます
5. 重複を避ける処理や早期終了の最適化も重要です

二重ループは直感的ですが計算量が大きいため、より効率的なアルゴリズムがないか常に考えることが大切です。
