# 配列と文字列 - 応用（In-place Counting, Negative Marking）

## 概要

このセクションでは、In-place Counting と Negative Marking テクニックを学びます。これらは、追加の空間を使わずに配列自体を使って情報を記録する高度なテクニックです。主に1からnの範囲の整数を含む配列の問題で使用されます。

---

## 問題1: 消えた数字を見つける

### 問題文

1からnの範囲のn個の整数を含む配列が与えられます。1つの数字が抜けています。その数字を見つけてください。

**入力例:**

```text
[3, 0, 1]
```

**出力例:**

```text
2
```

### アルゴリズム概説

期待される合計（1+2+...+n）から実際の合計を引きます。または、XOR演算を使用してO(1)空間で解きます。

**時間計算量:** O(n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 missing_number(配列):
    n = 配列の長さ
    期待される合計 = n * (n + 1) / 2
    実際の合計 = 配列の合計
    
    期待される合計 - 実際の合計 を返す
```

### 解答

```ruby
# 解法1: 合計の差を使用
def missing_number(nums)
  n = nums.length
  expected_sum = n * (n + 1) / 2
  actual_sum = nums.sum
  
  expected_sum - actual_sum
end

# 解法2: XOR演算を使用
def missing_number_xor(nums)
  result = nums.length
  
  nums.each_with_index do |num, i|
    result ^= i ^ num
  end
  
  result
end

# 解法3: Negative Markingを使用（範囲が0からn-1の場合）
def missing_number_marking(nums)
  n = nums.length
  
  # 各数字に対応する位置をマーク
  nums.each do |num|
    next if num == n  # n は配列外
    
    # 負にする
    idx = num.abs
    nums[idx] = -nums[idx].abs if idx < n
  end
  
  # 正の値のインデックスが消えた数字
  nums.each_with_index do |num, i|
    return i if num >= 0
  end
  
  n
end

# テストケース
p missing_number([3, 0, 1])        # => 2
p missing_number([0, 1])           # => 2
p missing_number([9, 6, 4, 2, 3, 5, 7, 0, 1])  # => 8

p missing_number_xor([3, 0, 1])    # => 2
```

---

## 問題2: 重複する数字を見つける

### 問題文

n+1個の整数を含む配列が与えられます。各整数は1からnの範囲です。1つの数字が重複しています。その数字を見つけてください。配列を変更せず、O(1)の追加空間で解いてください。

**入力例:**

```text
[1, 3, 4, 2, 2]
```

**出力例:**

```text
2
```

### アルゴリズム概説

Floyd's Cycle Detection（亀と兎のアルゴリズム）を使用します。配列をリンクリストのように扱い、nums[i]を次のノードへのポインタとみなします。

**時間計算量:** O(n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 find_duplicate(配列):
    # フェーズ1: サイクルを検出
    亀 = 配列[0]
    兎 = 配列[0]
    
    do:
        亀 = 配列[亀]
        兎 = 配列[配列[兎]]
    while 亀 != 兎
    
    # フェーズ2: サイクルの開始点を見つける
    亀 = 配列[0]
    
    亀 != 兎 の間:
        亀 = 配列[亀]
        兎 = 配列[兎]
    
    兎 を返す
```

### 解答

```ruby
# 解法1: Floyd's Cycle Detection
def find_duplicate(nums)
  # フェーズ1: サイクルを検出
  slow = nums[0]
  fast = nums[0]
  
  loop do
    slow = nums[slow]
    fast = nums[nums[fast]]
    break if slow == fast
  end
  
  # フェーズ2: サイクルの開始点を見つける
  slow = nums[0]
  
  while slow != fast
    slow = nums[slow]
    fast = nums[fast]
  end
  
  fast
end

# 解法2: Negative Marking（配列を変更可能な場合）
def find_duplicate_marking(nums)
  nums.each do |num|
    idx = num.abs
    
    # 既に負の場合、これが重複
    return idx if nums[idx] < 0
    
    # マークする
    nums[idx] = -nums[idx]
  end
  
  -1
end

# 解法3: Binary Search（値の範囲で二分探索）
def find_duplicate_binary_search(nums)
  left = 1
  right = nums.length - 1
  
  while left < right
    mid = (left + right) / 2
    
    # mid以下の数字が何個あるか数える
    count = nums.count { |num| num <= mid }
    
    # mid以下の数字がmid個より多ければ、重複はmid以下
    if count > mid
      right = mid
    else
      left = mid + 1
    end
  end
  
  left
end

# テストケース
p find_duplicate([1, 3, 4, 2, 2])  # => 2
p find_duplicate([3, 1, 3, 4, 2])  # => 3
p find_duplicate([1, 1])           # => 1
p find_duplicate([1, 1, 2])        # => 1
```

---

## 問題3: すべての重複を見つける

### 問題文

1からnの範囲のn個の整数を含む配列が与えられます。いくつかの数字が重複しています。すべての重複を見つけてください。

**入力例:**

```text
[4, 3, 2, 7, 8, 2, 3, 1]
```

**出力例:**

```text
[2, 3]
```

### アルゴリズム概説

Negative Markingを使用します。各値に対応するインデックスを負にマークし、既に負の場合はそれが重複です。

**時間計算量:** O(n)  
**空間計算量:** O(1) - 出力配列を除く

### 擬似コード

```text
関数 find_duplicates(配列):
    重複 = 空配列
    
    配列の各要素について:
        インデックス = abs(要素) - 1
        
        もし 配列[インデックス] < 0 なら:
            # 既に訪問済み = 重複
            重複に abs(要素) を追加
        そうでなければ:
            # マークする
            配列[インデックス] = -配列[インデックス]
    
    重複を返す
```

### 解答

```ruby
# 解法1: Negative Marking
def find_duplicates(nums)
  duplicates = []
  
  nums.each do |num|
    idx = num.abs - 1
    
    if nums[idx] < 0
      # 既に訪問済み = 重複
      duplicates << num.abs
    else
      # マークする
      nums[idx] = -nums[idx]
    end
  end
  
  duplicates
end

# 解法2: 元の配列を復元する版
def find_duplicates_restore(nums)
  duplicates = []
  
  # マークして重複を見つける
  nums.each do |num|
    idx = num.abs - 1
    
    if nums[idx] < 0
      duplicates << num.abs
    else
      nums[idx] = -nums[idx]
    end
  end
  
  # 配列を元に戻す
  nums.map! { |num| num.abs }
  
  duplicates
end

# 解法3: ハッシュセットを使用（O(n)空間）
def find_duplicates_hash(nums)
  seen = Set.new
  duplicates = []
  
  nums.each do |num|
    if seen.include?(num)
      duplicates << num
    else
      seen << num
    end
  end
  
  duplicates
end

# テストケース
p find_duplicates([4, 3, 2, 7, 8, 2, 3, 1])  # => [2, 3]
p find_duplicates([1, 1, 2])                 # => [1]
p find_duplicates([1])                       # => []
```

---

## 問題4: 消えたすべての数字を見つける

### 問題文

1からnの範囲のn個の整数を含む配列が与えられます。いくつかの数字が消えています。すべての消えた数字を見つけてください。

**入力例:**

```text
[4, 3, 2, 7, 8, 2, 3, 1]
```

**出力例:**

```text
[5, 6]
```

### アルゴリズム概説

Negative Markingを使用します。各値に対応するインデックスを負にマークし、最後に正の値のインデックス+1が消えた数字です。

**時間計算量:** O(n)  
**空間計算量:** O(1) - 出力配列を除く

### 擬似コード

```text
関数 find_disappeared_numbers(配列):
    # 各数字に対応する位置をマーク
    配列の各要素について:
        インデックス = abs(要素) - 1
        配列[インデックス] = -abs(配列[インデックス])
    
    # 正の値のインデックスが消えた数字
    消えた数字 = 空配列
    
    各インデックスiについて:
        もし 配列[i] > 0 なら:
            消えた数字に i + 1 を追加
    
    消えた数字を返す
```

### 解答

```ruby
# 解法1: Negative Marking
def find_disappeared_numbers(nums)
  # 各数字に対応する位置をマーク
  nums.each do |num|
    idx = num.abs - 1
    nums[idx] = -nums[idx].abs
  end
  
  # 正の値のインデックスが消えた数字
  disappeared = []
  
  nums.each_with_index do |num, i|
    disappeared << i + 1 if num > 0
  end
  
  disappeared
end

# 解法2: 元の配列を復元する版
def find_disappeared_numbers_restore(nums)
  nums.each do |num|
    idx = num.abs - 1
    nums[idx] = -nums[idx].abs
  end
  
  disappeared = []
  
  nums.each_with_index do |num, i|
    disappeared << i + 1 if num > 0
  end
  
  # 配列を元に戻す
  nums.map! { |num| num.abs }
  
  disappeared
end

# 解法3: セットを使用（O(n)空間）
def find_disappeared_numbers_set(nums)
  present = Set.new(nums)
  
  (1..nums.length).reject { |num| present.include?(num) }
end

# テストケース
p find_disappeared_numbers([4, 3, 2, 7, 8, 2, 3, 1])  # => [5, 6]
p find_disappeared_numbers([1, 1])                    # => [2]
p find_disappeared_numbers([1, 2, 3])                 # => []
```

---

## 問題5: 最初の消えた正の整数

### 問題文

ソートされていない整数配列が与えられます。出現しない最小の正の整数を見つけてください。

**入力例:**

```text
[3, 4, -1, 1]
```

**出力例:**

```text
2
```

### アルゴリズム概説

1. 負の数、0、n より大きい数を無視できる範囲の数に置き換えます
2. Negative Markingで1からnの範囲の数をマークします
3. 最初の正の値のインデックス+1が答えです

**時間計算量:** O(n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 first_missing_positive(配列):
    n = 配列の長さ
    
    # 範囲外の値を処理
    配列の各要素について:
        もし 要素 <= 0 または 要素 > n なら:
            要素 = n + 1
    
    # Negative Markingでマーク
    配列の各要素について:
        値 = abs(要素)
        もし 値 <= n なら:
            配列[値 - 1] = -abs(配列[値 - 1])
    
    # 最初の正の値を見つける
    各インデックスiについて:
        もし 配列[i] > 0 なら:
            i + 1 を返す
    
    n + 1 を返す
```

### 解答

```ruby
# 解法1: Negative Marking
def first_missing_positive(nums)
  n = nums.length
  
  # 範囲外の値を n + 1 に置き換え
  nums.map! { |num| (num <= 0 || num > n) ? n + 1 : num }
  
  # Negative Markingでマーク
  nums.each do |num|
    val = num.abs
    
    if val <= n
      nums[val - 1] = -nums[val - 1].abs
    end
  end
  
  # 最初の正の値を見つける
  nums.each_with_index do |num, i|
    return i + 1 if num > 0
  end
  
  n + 1
end

# 解法2: インプレースでソート（値を正しい位置に配置）
def first_missing_positive_sort(nums)
  n = nums.length
  i = 0
  
  while i < n
    # nums[i]は位置 nums[i]-1 にあるべき
    correct_pos = nums[i] - 1
    
    if nums[i] > 0 && nums[i] <= n && nums[i] != nums[correct_pos]
      nums[i], nums[correct_pos] = nums[correct_pos], nums[i]
    else
      i += 1
    end
  end
  
  # 最初の不一致を見つける
  nums.each_with_index do |num, i|
    return i + 1 if num != i + 1
  end
  
  n + 1
end

# 解法3: セットを使用（O(n)空間）
def first_missing_positive_set(nums)
  present = Set.new(nums)
  
  i = 1
  i += 1 while present.include?(i)
  
  i
end

# テストケース
p first_missing_positive([1, 2, 0])       # => 3
p first_missing_positive([3, 4, -1, 1])   # => 2
p first_missing_positive([7, 8, 9, 11, 12])  # => 1
p first_missing_positive([1])             # => 2
```

---

## 問題6: 配列の要素を正しい位置に配置

### 問題文

0からn-1の範囲のn個の整数を含む配列が与えられます。各要素を nums[i] = i となるように配置してください。

**入力例:**

```text
[4, 0, 2, 1, 3]
```

**出力例:**

```text
[0, 1, 2, 3, 4]
```

### アルゴリズム概説

各要素を正しい位置に交換しながら配置します。nums[i] != i の間、nums[i]とnums[nums[i]]を交換します。

**時間計算量:** O(n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 arrange_numbers(配列):
    i = 0
    
    i < 配列の長さ の間:
        もし 配列[i] != i かつ 配列[i] != 配列[配列[i]] なら:
            # 交換
            正しい位置 = 配列[i]
            配列[i] と 配列[正しい位置] を交換
        そうでなければ:
            i += 1
    
    配列を返す
```

### 解答

```ruby
# 解法1: In-place交換
def arrange_numbers(nums)
  i = 0
  
  while i < nums.length
    correct_pos = nums[i]
    
    if nums[i] != i && nums[i] != nums[correct_pos]
      # 交換
      nums[i], nums[correct_pos] = nums[correct_pos], nums[i]
    else
      i += 1
    end
  end
  
  nums
end

# 解法2: 1パスで処理
def arrange_numbers_one_pass(nums)
  nums.each_index do |i|
    while nums[i] != i && nums[i] != nums[nums[i]]
      correct_pos = nums[i]
      nums[i], nums[correct_pos] = nums[correct_pos], nums[i]
    end
  end
  
  nums
end

# 解法3: 新しい配列を作成
def arrange_numbers_new_array(nums)
  result = Array.new(nums.length)
  
  nums.each_with_index do |num, i|
    result[num] = num
  end
  
  result
end

# テストケース
p arrange_numbers([4, 0, 2, 1, 3])  # => [0, 1, 2, 3, 4]
p arrange_numbers([3, 1, 0, 2])     # => [0, 1, 2, 3]
p arrange_numbers([0, 1, 2])        # => [0, 1, 2]
```

---

## 問題7: セットの不一致

### 問題文

1からnの範囲の n 個の整数を含む配列が与えられます。1つの数字が重複し、1つの数字が消えています。重複と消えた数字を見つけてください。

**入力例:**

```text
[1, 2, 2, 4]
```

**出力例:**

```text
[2, 3]  # 2が重複、3が消えた
```

### アルゴリズム概説

Negative Markingを使用します。既に負の値なら重複、最後に正の値なら消えた数字です。

**時間計算量:** O(n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 find_error_nums(配列):
    重複 = 0
    
    # Negative Markingで重複を見つける
    配列の各要素について:
        インデックス = abs(要素) - 1
        
        もし 配列[インデックス] < 0 なら:
            重複 = abs(要素)
        そうでなければ:
            配列[インデックス] = -配列[インデックス]
    
    # 正の値のインデックスが消えた数字
    消えた = 0
    各インデックスiについて:
        もし 配列[i] > 0 なら:
            消えた = i + 1
    
    [重複, 消えた] を返す
```

### 解答

```ruby
# 解法1: Negative Marking
def find_error_nums(nums)
  duplicate = 0
  
  # Negative Markingで重複を見つける
  nums.each do |num|
    idx = num.abs - 1
    
    if nums[idx] < 0
      duplicate = num.abs
    else
      nums[idx] = -nums[idx]
    end
  end
  
  # 正の値のインデックスが消えた数字
  missing = 0
  nums.each_with_index do |num, i|
    if num > 0
      missing = i + 1
      break
    end
  end
  
  [duplicate, missing]
end

# 解法2: 合計とXORを使用
def find_error_nums_math(nums)
  n = nums.length
  
  # 実際の合計と期待される合計
  actual_sum = nums.sum
  expected_sum = n * (n + 1) / 2
  
  # 重複を見つける
  duplicate = 0
  seen = Set.new
  
  nums.each do |num|
    duplicate = num if seen.include?(num)
    seen << num
  end
  
  # 消えた数字を計算
  missing = expected_sum - (actual_sum - duplicate)
  
  [duplicate, missing]
end

# 解法3: ハッシュを使用（O(n)空間）
def find_error_nums_hash(nums)
  count = Hash.new(0)
  nums.each { |num| count[num] += 1 }
  
  duplicate = count.find { |_, v| v == 2 }[0]
  missing = (1..nums.length).find { |num| !count.key?(num) }
  
  [duplicate, missing]
end

# テストケース
p find_error_nums([1, 2, 2, 4])  # => [2, 3]
p find_error_nums([1, 1])        # => [1, 2]
p find_error_nums([2, 2])        # => [2, 1]
```

---

## 問題8: 配列内の正しくない数字

### 問題文

0からnの範囲のn+1個の整数を含む配列が与えられます。各要素は正しい位置（nums[i] = i）にあるべきですが、1つだけ間違っています。その数字を見つけてください。

**入力例:**

```text
[0, 1, 3, 3]
```

**出力例:**

```text
2  # インデックス2の位置に2があるべき
```

### アルゴリズム概説

XOR演算またはNegative Markingを使用します。正しい位置にない数字と、その位置にあるべき数字の組み合わせを見つけます。

**時間計算量:** O(n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 find_corrupt_values(配列):
    配列の各要素について:
        インデックス = abs(要素)
        
        もし インデックス < 配列の長さ なら:
            配列[インデックス] = -abs(配列[インデックス])
    
    各インデックスiについて:
        もし 配列[i] > 0 なら:
            i を返す  # この位置が間違っている
    
    配列の長さ を返す
```

### 解答

```ruby
# 解法1: Negative Marking
def find_corrupt_value(nums)
  nums.each do |num|
    idx = num.abs
    
    if idx < nums.length
      nums[idx] = -nums[idx].abs
    end
  end
  
  nums.each_with_index do |num, i|
    return i if num > 0
  end
  
  nums.length
end

# 解法2: XOR演算
def find_corrupt_value_xor(nums)
  result = nums.length
  
  nums.each_with_index do |num, i|
    result ^= i ^ num
  end
  
  result
end

# 解法3: In-place交換
def find_corrupt_value_swap(nums)
  i = 0
  
  while i < nums.length
    correct_pos = nums[i]
    
    if correct_pos < nums.length && nums[i] != nums[correct_pos]
      nums[i], nums[correct_pos] = nums[correct_pos], nums[i]
    else
      i += 1
    end
  end
  
  # 正しくない位置を見つける
  nums.each_with_index do |num, i|
    return i if num != i
  end
  
  nums.length
end

# テストケース
p find_corrupt_value([0, 1, 3, 3])  # => 2
p find_corrupt_value([1, 0, 2, 3])  # => 4
p find_corrupt_value([0, 2, 2, 3])  # => 1
```

---

## まとめ

このセクションでは、In-place Counting と Negative Marking テクニックを学びました。

重要なポイントは以下の通りです。

1. Negative Markingは値に対応するインデックスを負にして訪問済みをマークします
2. 1からnの範囲の整数配列で特に有効です
3. O(1)の追加空間で多くの問題を解けます
4. XOR演算も空間効率の良いテクニックです
5. 配列の値をインデックスとして使うことで追加のデータ構造が不要になります

これらのテクニックは面接でよく出題され、空間計算量を最適化する重要な手法です。配列自体を利用して情報を記録する発想を理解することが鍵となります。
