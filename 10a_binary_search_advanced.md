# 二分探索 - 応用問題

## 概要

このセクションでは、二分探索の応用問題を扱います。下界（lower bound）、上界（upper bound）、答えの二分探索（binary search on answer）など、より高度なテクニックを学びます。

---

## 問題1: 下界（Lower Bound）の実装

### 問題文

ソート済み配列とターゲット値が与えられます。ターゲット以上の最小の要素のインデックスを返してください。存在しない場合は配列の長さを返します。

**入力例:**

```text
nums = [1, 2, 4, 4, 5, 6], target = 4
```

**出力例:**

```text
2  # 最初の4のインデックス
```

### アルゴリズム概説

二分探索を使用しますが、ターゲットと等しい要素を見つけてもさらに左側を探索します。

**時間計算量:** O(log n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 lower_bound(配列, ターゲット):
    左 = 0
    右 = 配列の長さ
    
    左 < 右 の間:
        中央 = (左 + 右) / 2
        
        もし 配列[中央] < ターゲット なら:
            左 = 中央 + 1
        そうでなければ:
            右 = 中央
    
    左 を返す
```

### 解答

```ruby
# 解法1: 標準的な Lower Bound
def lower_bound(nums, target)
  left = 0
  right = nums.length
  
  while left < right
    mid = (left + right) / 2
    
    if nums[mid] < target
      left = mid + 1
    else
      right = mid
    end
  end
  
  left
end

# 解法2: Rubyの bsearch_index を使用
def lower_bound_builtin(nums, target)
  nums.bsearch_index { |x| x >= target } || nums.length
end

# 解法3: より明示的な実装
def lower_bound_explicit(nums, target)
  left = 0
  right = nums.length - 1
  result = nums.length
  
  while left <= right
    mid = (left + right) / 2
    
    if nums[mid] >= target
      result = mid
      right = mid - 1
    else
      left = mid + 1
    end
  end
  
  result
end

# テストケース
p lower_bound([1, 2, 4, 4, 5, 6], 4)  # => 2
p lower_bound([1, 2, 4, 4, 5, 6], 3)  # => 2
p lower_bound([1, 2, 4, 4, 5, 6], 7)  # => 6
p lower_bound([1, 2, 4, 4, 5, 6], 0)  # => 0
```

---

## 問題2: 上界（Upper Bound）の実装

### 問題文

ソート済み配列とターゲット値が与えられます。ターゲットより大きい最小の要素のインデックスを返してください。存在しない場合は配列の長さを返します。

**入力例:**

```text
nums = [1, 2, 4, 4, 5, 6], target = 4
```

**出力例:**

```text
4  # 最初の4より大きい要素（5）のインデックス
```

### アルゴリズム概説

二分探索を使用し、ターゲットより大きい最初の要素を見つけます。

**時間計算量:** O(log n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 upper_bound(配列, ターゲット):
    左 = 0
    右 = 配列の長さ
    
    左 < 右 の間:
        中央 = (左 + 右) / 2
        
        もし 配列[中央] <= ターゲット なら:
            左 = 中央 + 1
        そうでなければ:
            右 = 中央
    
    左 を返す
```

### 解答

```ruby
# 解法1: 標準的な Upper Bound
def upper_bound(nums, target)
  left = 0
  right = nums.length
  
  while left < right
    mid = (left + right) / 2
    
    if nums[mid] <= target
      left = mid + 1
    else
      right = mid
    end
  end
  
  left
end

# 解法2: Rubyの bsearch_index を使用
def upper_bound_builtin(nums, target)
  nums.bsearch_index { |x| x > target } || nums.length
end

# 解法3: より明示的な実装
def upper_bound_explicit(nums, target)
  left = 0
  right = nums.length - 1
  result = nums.length
  
  while left <= right
    mid = (left + right) / 2
    
    if nums[mid] > target
      result = mid
      right = mid - 1
    else
      left = mid + 1
    end
  end
  
  result
end

# 解法4: Lower Bound を利用
def upper_bound_from_lower(nums, target)
  lower_bound(nums, target + 1)
end

# テストケース
p upper_bound([1, 2, 4, 4, 5, 6], 4)  # => 4
p upper_bound([1, 2, 4, 4, 5, 6], 3)  # => 2
p upper_bound([1, 2, 4, 4, 5, 6], 7)  # => 6
p upper_bound([1, 2, 4, 4, 5, 6], 0)  # => 0
```

---

## 問題3: 回転ソート配列の検索

### 問題文

昇順にソートされた配列が、あるピボットで回転されています。ターゲット値のインデックスを返してください。存在しない場合は-1を返します。

**入力例:**

```text
nums = [4, 5, 6, 7, 0, 1, 2], target = 0
```

**出力例:**

```text
4
```

### アルゴリズム概説

二分探索を使用しますが、どちらの半分がソートされているかを判定します。

**時間計算量:** O(log n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 search_rotated(配列, ターゲット):
    左 = 0
    右 = 配列の長さ - 1
    
    左 <= 右 の間:
        中央 = (左 + 右) / 2
        
        もし 配列[中央] == ターゲット なら:
            中央 を返す
        
        # 左半分がソート済み
        もし 配列[左] <= 配列[中央] なら:
            もし 配列[左] <= ターゲット < 配列[中央] なら:
                右 = 中央 - 1
            そうでなければ:
                左 = 中央 + 1
        # 右半分がソート済み
        そうでなければ:
            もし 配列[中央] < ターゲット <= 配列[右] なら:
                左 = 中央 + 1
            そうでなければ:
                右 = 中央 - 1
    
    -1 を返す
```

### 解答

```ruby
# 解法1: 標準的な二分探索
def search_rotated(nums, target)
  left = 0
  right = nums.length - 1
  
  while left <= right
    mid = (left + right) / 2
    
    return mid if nums[mid] == target
    
    # 左半分がソート済み
    if nums[left] <= nums[mid]
      if nums[left] <= target && target < nums[mid]
        right = mid - 1
      else
        left = mid + 1
      end
    # 右半分がソート済み
    else
      if nums[mid] < target && target <= nums[right]
        left = mid + 1
      else
        right = mid - 1
      end
    end
  end
  
  -1
end

# 解法2: ピボットを先に見つける
def search_rotated_pivot(nums, target)
  # ピボット（最小値）を見つける
  pivot = find_pivot(nums)
  
  # どちらの半分を探索するか決定
  if target >= nums[0]
    # 左半分を探索
    binary_search(nums, 0, pivot - 1, target)
  else
    # 右半分を探索
    binary_search(nums, pivot, nums.length - 1, target)
  end
end

def find_pivot(nums)
  left = 0
  right = nums.length - 1
  
  while left < right
    mid = (left + right) / 2
    
    if nums[mid] > nums[right]
      left = mid + 1
    else
      right = mid
    end
  end
  
  left
end

def binary_search(nums, left, right, target)
  while left <= right
    mid = (left + right) / 2
    
    return mid if nums[mid] == target
    
    if nums[mid] < target
      left = mid + 1
    else
      right = mid - 1
    end
  end
  
  -1
end

# テストケース
p search_rotated([4, 5, 6, 7, 0, 1, 2], 0)  # => 4
p search_rotated([4, 5, 6, 7, 0, 1, 2], 3)  # => -1
p search_rotated([1], 0)  # => -1
```

---

## 問題4: 山の配列でのピーク要素の検索

### 問題文

配列が与えられます。ピーク要素（隣接要素より大きい要素）のインデックスを返してください。複数存在する場合はいずれかを返します。

**入力例:**

```text
nums = [1, 2, 3, 1]
```

**出力例:**

```text
2  # nums[2] = 3 がピーク
```

### アルゴリズム概説

二分探索を使用し、上り坂の方向に進みます。

**時間計算量:** O(log n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 find_peak_element(配列):
    左 = 0
    右 = 配列の長さ - 1
    
    左 < 右 の間:
        中央 = (左 + 右) / 2
        
        もし 配列[中央] < 配列[中央 + 1] なら:
            # 上り坂、右へ
            左 = 中央 + 1
        そうでなければ:
            # 下り坂、左へ
            右 = 中央
    
    左 を返す
```

### 解答

```ruby
# 解法1: 二分探索
def find_peak_element(nums)
  left = 0
  right = nums.length - 1
  
  while left < right
    mid = (left + right) / 2
    
    if nums[mid] < nums[mid + 1]
      # 上り坂、ピークは右側
      left = mid + 1
    else
      # 下り坂、ピークは左側または mid
      right = mid
    end
  end
  
  left
end

# 解法2: 線形探索（比較用）
def find_peak_element_linear(nums)
  (0...nums.length - 1).each do |i|
    return i if nums[i] > nums[i + 1]
  end
  
  nums.length - 1
end

# 解法3: 再帰的二分探索
def find_peak_element_recursive(nums)
  search_peak(nums, 0, nums.length - 1)
end

def search_peak(nums, left, right)
  return left if left == right
  
  mid = (left + right) / 2
  
  if nums[mid] < nums[mid + 1]
    search_peak(nums, mid + 1, right)
  else
    search_peak(nums, left, mid)
  end
end

# テストケース
p find_peak_element([1, 2, 3, 1])  # => 2
p find_peak_element([1, 2, 1, 3, 5, 6, 4])  # => 1 または 5
p find_peak_element([1])  # => 0
```

---

## 問題5: 平方根の計算（整数部分）

### 問題文

負でない整数xが与えられます。xの平方根の整数部分を返してください。

**入力例:**

```text
x = 8
```

**出力例:**

```text
2  # √8 ≈ 2.828
```

### アルゴリズム概説

0からxまでの範囲で二分探索し、mid * mid <= x となる最大のmidを見つけます。

**時間計算量:** O(log x)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 my_sqrt(x):
    もし x < 2 なら:
        x を返す
    
    左 = 0
    右 = x
    
    左 <= 右 の間:
        中央 = (左 + 右) / 2
        
        もし 中央 * 中央 == x なら:
            中央 を返す
        もし 中央 * 中央 < x なら:
            左 = 中央 + 1
        そうでなければ:
            右 = 中央 - 1
    
    右 を返す
```

### 解答

```ruby
# 解法1: 二分探索
def my_sqrt(x)
  return x if x < 2
  
  left = 0
  right = x
  
  while left <= right
    mid = (left + right) / 2
    square = mid * mid
    
    return mid if square == x
    
    if square < x
      left = mid + 1
    else
      right = mid - 1
    end
  end
  
  right
end

# 解法2: より効率的な範囲設定
def my_sqrt_optimized(x)
  return x if x < 2
  
  left = 1
  right = x / 2  # √x <= x/2 for x >= 2
  
  while left <= right
    mid = (left + right) / 2
    square = mid * mid
    
    return mid if square == x
    
    if square < x
      left = mid + 1
    else
      right = mid - 1
    end
  end
  
  right
end

# 解法3: ニュートン法
def my_sqrt_newton(x)
  return x if x < 2
  
  guess = x.to_f
  
  while (guess * guess - x).abs >= 0.5
    guess = (guess + x / guess) / 2
  end
  
  guess.to_i
end

# 解法4: 組み込み関数（比較用）
def my_sqrt_builtin(x)
  Math.sqrt(x).to_i
end

# テストケース
p my_sqrt(4)   # => 2
p my_sqrt(8)   # => 2
p my_sqrt(16)  # => 4
p my_sqrt(0)   # => 0
p my_sqrt(1)   # => 1
```

---

## 問題6: 最小の分割数（答えの二分探索）

### 問題文

整数の配列とmが与えられます。配列を最大m個の部分配列に分割します。各部分配列の和の最大値を最小化してください。

**入力例:**

```text
nums = [7, 2, 5, 10, 8], m = 2
```

**出力例:**

```text
18  # [7, 2, 5] と [10, 8] に分割
```

### アルゴリズム概説

答えの二分探索を使用します。可能な最大和の範囲で二分探索し、各候補について実際に分割できるかチェックします。

**時間計算量:** O(n × log(sum - max))  
**空間計算量:** O(1)

### 擬似コード

```text
関数 split_array(配列, m):
    左 = 配列の最大値
    右 = 配列の合計
    
    左 < 右 の間:
        中央 = (左 + 右) / 2
        
        もし can_split(配列, m, 中央) なら:
            右 = 中央
        そうでなければ:
            左 = 中央 + 1
    
    左 を返す

関数 can_split(配列, m, 最大和):
    部分配列数 = 1
    現在の和 = 0
    
    各要素について:
        もし 現在の和 + 要素 > 最大和 なら:
            部分配列数 += 1
            現在の和 = 要素
        そうでなければ:
            現在の和 += 要素
    
    部分配列数 <= m を返す
```

### 解答

```ruby
# 解法1: 答えの二分探索
def split_array(nums, m)
  left = nums.max
  right = nums.sum
  
  while left < right
    mid = (left + right) / 2
    
    if can_split(nums, m, mid)
      right = mid
    else
      left = mid + 1
    end
  end
  
  left
end

def can_split(nums, m, max_sum)
  subarrays = 1
  current_sum = 0
  
  nums.each do |num|
    if current_sum + num > max_sum
      subarrays += 1
      current_sum = num
      
      return false if subarrays > m
    else
      current_sum += num
    end
  end
  
  true
end

# 解法2: 動的計画法（比較用、O(n²m)）
def split_array_dp(nums, m)
  n = nums.length
  
  # dp[i][j] = nums[0...i]をj個に分割した場合の最小の最大和
  dp = Array.new(n + 1) { Array.new(m + 1, Float::INFINITY) }
  
  # 累積和
  prefix_sum = [0]
  nums.each { |num| prefix_sum << prefix_sum.last + num }
  
  dp[0][0] = 0
  
  (1..n).each do |i|
    (1..[i, m].min).each do |j|
      (j - 1...i).each do |k|
        # nums[k...i] を j番目の部分配列とする
        subarray_sum = prefix_sum[i] - prefix_sum[k]
        dp[i][j] = [dp[i][j], [dp[k][j - 1], subarray_sum].max].min
      end
    end
  end
  
  dp[n][m]
end

# テストケース
p split_array([7, 2, 5, 10, 8], 2)  # => 18
p split_array([1, 2, 3, 4, 5], 2)   # => 9
p split_array([1, 4, 4], 3)         # => 4
```

---

## 問題7: 木材の切断（答えの二分探索）

### 問題文

各木の高さの配列と、必要な木材の長さmが与えられます。カッターの高さhを設定し、h以上の部分を切り取ります。少なくともm長の木材を得られる最大のhを求めてください。

**入力例:**

```text
trees = [20, 15, 10, 17], m = 7
```

**出力例:**

```text
15  # h=15で切ると、5 + 0 + 0 + 2 = 7
```

### アルゴリズム概説

答えの二分探索を使用します。可能な高さの範囲で二分探索し、各高さで得られる木材の量をチェックします。

**時間計算量:** O(n × log(max_height))  
**空間計算量:** O(1)

### 擬似コード

```text
関数 max_cutter_height(木の配列, m):
    左 = 0
    右 = 木の配列の最大値
    結果 = 0
    
    左 <= 右 の間:
        中央 = (左 + 右) / 2
        
        得られる木材 = sum(max(0, 木 - 中央) for 各木)
        
        もし 得られる木材 >= m なら:
            結果 = 中央
            左 = 中央 + 1
        そうでなければ:
            右 = 中央 - 1
    
    結果 を返す
```

### 解答

```ruby
# 解法1: 答えの二分探索
def max_cutter_height(trees, m)
  left = 0
  right = trees.max
  result = 0
  
  while left <= right
    mid = (left + right) / 2
    
    # mid の高さで切った場合の木材の量
    wood = trees.sum { |height| [0, height - mid].max }
    
    if wood >= m
      # 十分な木材が得られる、さらに高く設定できるか試す
      result = mid
      left = mid + 1
    else
      # 木材が不足、もっと低く設定する必要がある
      right = mid - 1
    end
  end
  
  result
end

# 解法2: より明示的な実装
def max_cutter_height_explicit(trees, m)
  left = 0
  right = trees.max
  
  while left < right
    # 上界を探索（最大値を求めるため mid を切り上げ）
    mid = (left + right + 1) / 2
    
    wood = calculate_wood(trees, mid)
    
    if wood >= m
      left = mid
    else
      right = mid - 1
    end
  end
  
  left
end

def calculate_wood(trees, height)
  trees.sum { |tree| tree > height ? tree - height : 0 }
end

# テストケース
p max_cutter_height([20, 15, 10, 17], 7)  # => 15
p max_cutter_height([4, 42, 40, 26, 46], 20)  # => 36
p max_cutter_height([1, 2, 3, 4, 5], 5)  # => 3
```

---

## 問題8: 最小の最大距離（答えの二分探索）

### 問題文

n個のボールをm個のバスケットに入れます。バスケットの位置が配列で与えられます。最も近い2つのボールの距離を最大化してください。

**入力例:**

```text
positions = [1, 2, 8, 4, 9], m = 3
```

**出力例:**

```text
3  # 位置1, 4, 8 または 1, 4, 9 など
```

### アルゴリズム概説

答えの二分探索を使用します。可能な最小距離の範囲で二分探索し、各距離でm個のボールを配置できるかチェックします。

**時間計算量:** O(n log n + n log(max - min))  
**空間計算量:** O(1)

### 擬似コード

```text
関数 max_min_distance(位置配列, m):
    位置配列をソート
    
    左 = 1
    右 = 位置配列[n-1] - 位置配列[0]
    結果 = 0
    
    左 <= 右 の間:
        中央 = (左 + 右) / 2
        
        もし can_place(位置配列, m, 中央) なら:
            結果 = 中央
            左 = 中央 + 1
        そうでなければ:
            右 = 中央 - 1
    
    結果 を返す

関数 can_place(位置配列, m, 最小距離):
    配置数 = 1
    最後の位置 = 位置配列[0]
    
    各位置について:
        もし 位置 - 最後の位置 >= 最小距離 なら:
            配置数 += 1
            最後の位置 = 位置
            
            もし 配置数 == m なら:
                true を返す
    
    false を返す
```

### 解答

```ruby
# 解法1: 答えの二分探索
def max_min_distance(positions, m)
  positions.sort!
  
  left = 1
  right = positions[-1] - positions[0]
  result = 0
  
  while left <= right
    mid = (left + right) / 2
    
    if can_place_balls(positions, m, mid)
      # mid の距離で配置可能、さらに大きい距離を試す
      result = mid
      left = mid + 1
    else
      # mid の距離では配置不可、距離を小さくする
      right = mid - 1
    end
  end
  
  result
end

def can_place_balls(positions, m, min_distance)
  count = 1  # 最初のボールを最初の位置に配置
  last_pos = positions[0]
  
  positions.each do |pos|
    if pos - last_pos >= min_distance
      count += 1
      last_pos = pos
      
      return true if count == m
    end
  end
  
  false
end

# 解法2: より明示的な実装
def max_min_distance_explicit(positions, m)
  positions.sort!
  
  # 二分探索の範囲
  min_possible = 1
  max_possible = (positions[-1] - positions[0]) / (m - 1)
  
  result = 0
  
  while min_possible <= max_possible
    mid = (min_possible + max_possible) / 2
    
    # mid の距離でボールを配置
    placed = place_balls(positions, m, mid)
    
    if placed >= m
      result = mid
      min_possible = mid + 1
    else
      max_possible = mid - 1
    end
  end
  
  result
end

def place_balls(positions, m, min_distance)
  count = 1
  last_pos = positions[0]
  
  (1...positions.length).each do |i|
    if positions[i] - last_pos >= min_distance
      count += 1
      last_pos = positions[i]
    end
  end
  
  count
end

# テストケース
p max_min_distance([1, 2, 8, 4, 9], 3)  # => 3
p max_min_distance([1, 2, 3, 4, 7], 3)  # => 3
p max_min_distance([5, 4, 3, 2, 1, 1000000000], 2)  # => 999999995
```

---

## まとめ

このセクションでは、二分探索の応用問題を学びました。

重要なポイントは以下の通りです。

1. Lower Bound と Upper Bound は多くの問題で基本となります
2. 回転配列では、どちらの半分がソート済みかを判定します
3. 答えの二分探索は、最適化問題を判定問題に変換します
4. 答えの二分探索では、条件を満たすかチェックする関数が重要です
5. 範囲設定を適切に行うことで効率が向上します

二分探索は、ソート済み配列だけでなく、単調性のある問題全般に適用できます。答えの二分探索は特に強力で、多くの最適化問題を効率的に解くことができます。
