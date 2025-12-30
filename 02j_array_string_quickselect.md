# 配列と文字列 - 応用（Quickselect）

## 概要

このセクションでは、Quickselect アルゴリズムを学びます。Quickselectは、配列のk番目に小さい（または大きい）要素を平均O(n)時間で見つけるアルゴリズムです。Quicksortのパーティション操作を利用しますが、片側のみを再帰的に処理します。

---

## 問題1: 配列のk番目に小さい要素

### 問題文

ソートされていない配列とkが与えられます。配列のk番目に小さい要素を返してください（1-indexed）。

**入力例:**

```text
nums = [3, 2, 1, 5, 6, 4], k = 2
```

**出力例:**

```text
2
```

### アルゴリズム概説

Quickselectアルゴリズムを使用します。ピボットを選び、パーティション後、ピボットの位置によって左右どちらかを再帰的に処理します。

**時間計算量:** O(n) - 平均、O(n²) - 最悪  
**空間計算量:** O(1)

### 擬似コード

```text
関数 find_kth_smallest(配列, k):
    左 = 0
    右 = 配列の長さ - 1
    
    true の間:
        もし 左 == 右 なら:
            配列[左] を返す
        
        # パーティション
        ピボット位置 = partition(配列, 左, 右)
        
        もし k == ピボット位置 + 1 なら:
            配列[ピボット位置] を返す
        もし k < ピボット位置 + 1 なら:
            右 = ピボット位置 - 1
        そうでなければ:
            左 = ピボット位置 + 1

関数 partition(配列, 左, 右):
    ピボット = 配列[右]
    i = 左
    
    各jについて（左から右-1まで）:
        もし 配列[j] < ピボット なら:
            配列[i] と 配列[j] を交換
            i += 1
    
    配列[i] と 配列[右] を交換
    i を返す
```

### 解答

```ruby
# 解法1: Quickselect
def find_kth_smallest(nums, k)
  left = 0
  right = nums.length - 1
  
  loop do
    return nums[left] if left == right
    
    # パーティション
    pivot_idx = partition(nums, left, right)
    
    # k-1 はゼロインデックス
    if k - 1 == pivot_idx
      return nums[pivot_idx]
    elsif k - 1 < pivot_idx
      right = pivot_idx - 1
    else
      left = pivot_idx + 1
    end
  end
end

def partition(nums, left, right)
  # ランダムなピボットを選んで右端と交換（最悪ケースを回避）
  pivot_idx = rand(left..right)
  nums[pivot_idx], nums[right] = nums[right], nums[pivot_idx]
  
  pivot = nums[right]
  i = left
  
  (left...right).each do |j|
    if nums[j] < pivot
      nums[i], nums[j] = nums[j], nums[i]
      i += 1
    end
  end
  
  nums[i], nums[right] = nums[right], nums[i]
  i
end

# 解法2: ソートを使用（比較用）
def find_kth_smallest_sort(nums, k)
  nums.sort[k - 1]
end

# 解法3: MinHeapを使用
def find_kth_smallest_heap(nums, k)
  # Rubyには組み込みのMinHeapがないので、MaxHeapを負の値で使用
  heap = []
  
  nums.each do |num|
    heap << -num
    heap.sort!  # 簡易実装（実際はheapifyを使用）
    heap.pop if heap.size > k
  end
  
  -heap[0]
end

# テストケース
p find_kth_smallest([3, 2, 1, 5, 6, 4], 2)  # => 2
p find_kth_smallest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4)  # => 3
p find_kth_smallest([1], 1)  # => 1
```

---

## 問題2: 配列のk番目に大きい要素

### 問題文

ソートされていない配列とkが与えられます。配列のk番目に大きい要素を返してください。

**入力例:**

```text
nums = [3, 2, 1, 5, 6, 4], k = 2
```

**出力例:**

```text
5
```

### アルゴリズム概説

k番目に大きい要素は、(n - k + 1)番目に小さい要素と同じです。または、降順パーティションを使用します。

**時間計算量:** O(n) - 平均  
**空間計算量:** O(1)

### 擬似コード

```text
関数 find_kth_largest(配列, k):
    # k番目に大きい = (n - k + 1)番目に小さい
    n = 配列の長さ
    quickselect(配列, n - k)

関数 quickselect(配列, k):
    左 = 0
    右 = 配列の長さ - 1
    
    true の間:
        ピボット位置 = partition(配列, 左, 右)
        
        もし ピボット位置 == k なら:
            配列[k] を返す
        もし ピボット位置 > k なら:
            右 = ピボット位置 - 1
        そうでなければ:
            左 = ピボット位置 + 1
```

### 解答

```ruby
# 解法1: Quickselect（k番目に小さいを利用）
def find_kth_largest(nums, k)
  n = nums.length
  quickselect(nums, n - k)
end

def quickselect(nums, k)
  left = 0
  right = nums.length - 1
  
  loop do
    pivot_idx = partition_asc(nums, left, right)
    
    if pivot_idx == k
      return nums[k]
    elsif pivot_idx > k
      right = pivot_idx - 1
    else
      left = pivot_idx + 1
    end
  end
end

def partition_asc(nums, left, right)
  pivot_idx = rand(left..right)
  nums[pivot_idx], nums[right] = nums[right], nums[pivot_idx]
  
  pivot = nums[right]
  i = left
  
  (left...right).each do |j|
    if nums[j] < pivot
      nums[i], nums[j] = nums[j], nums[i]
      i += 1
    end
  end
  
  nums[i], nums[right] = nums[right], nums[i]
  i
end

# 解法2: 降順パーティション
def find_kth_largest_desc(nums, k)
  left = 0
  right = nums.length - 1
  
  loop do
    pivot_idx = partition_desc(nums, left, right)
    
    if pivot_idx == k - 1
      return nums[k - 1]
    elsif pivot_idx > k - 1
      right = pivot_idx - 1
    else
      left = pivot_idx + 1
    end
  end
end

def partition_desc(nums, left, right)
  pivot_idx = rand(left..right)
  nums[pivot_idx], nums[right] = nums[right], nums[pivot_idx]
  
  pivot = nums[right]
  i = left
  
  (left...right).each do |j|
    if nums[j] > pivot  # 降順
      nums[i], nums[j] = nums[j], nums[i]
      i += 1
    end
  end
  
  nums[i], nums[right] = nums[right], nums[i]
  i
end

# 解法3: MinHeapを使用（サイズkを維持）
def find_kth_largest_heap(nums, k)
  # k個の最大要素を保持するMinHeap
  heap = []
  
  nums.each do |num|
    if heap.size < k
      heap << num
      heap.sort!
    elsif num > heap[0]
      heap[0] = num
      heap.sort!
    end
  end
  
  heap[0]
end

# テストケース
p find_kth_largest([3, 2, 1, 5, 6, 4], 2)  # => 5
p find_kth_largest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4)  # => 4
p find_kth_largest([1], 1)  # => 1
```

---

## 問題3: トップK頻出要素（Quickselect版）

### 問題文

整数の配列が与えられます。最も頻繁に出現するk個の要素を返してください。

**入力例:**

```text
nums = [1, 1, 1, 2, 2, 3], k = 2
```

**出力例:**

```text
[1, 2]
```

### アルゴリズム概説

頻度をカウントし、その頻度配列に対してQuickselectを適用します。

**時間計算量:** O(n) - 平均  
**空間計算量:** O(n)

### 擬似コード

```text
関数 top_k_frequent(配列, k):
    頻度マップ = 各要素の出現回数
    ユニーク要素 = 頻度マップのキー配列
    
    # k番目に高い頻度を持つ要素のインデックスを見つける
    quickselect_by_frequency(ユニーク要素, k, 頻度マップ)
    
    # 上位k個を返す
    ユニーク要素の最後のk個を返す
```

### 解答

```ruby
# 解法1: Quickselect + 頻度マップ
def top_k_frequent(nums, k)
  # 頻度をカウント
  freq = nums.tally
  unique = freq.keys
  
  # k番目に高い頻度を持つ要素のインデックスを見つける
  quickselect_by_frequency(unique, unique.length - k, freq)
  
  # 上位k個を返す
  unique[unique.length - k..-1]
end

def quickselect_by_frequency(nums, k, freq)
  left = 0
  right = nums.length - 1
  
  loop do
    pivot_idx = partition_by_frequency(nums, left, right, freq)
    
    if pivot_idx == k
      return
    elsif pivot_idx > k
      right = pivot_idx - 1
    else
      left = pivot_idx + 1
    end
  end
end

def partition_by_frequency(nums, left, right, freq)
  pivot_idx = rand(left..right)
  nums[pivot_idx], nums[right] = nums[right], nums[pivot_idx]
  
  pivot_freq = freq[nums[right]]
  i = left
  
  (left...right).each do |j|
    if freq[nums[j]] < pivot_freq
      nums[i], nums[j] = nums[j], nums[i]
      i += 1
    end
  end
  
  nums[i], nums[right] = nums[right], nums[i]
  i
end

# 解法2: バケットソート
def top_k_frequent_bucket(nums, k)
  freq = nums.tally
  
  # 頻度ごとのバケット
  buckets = Array.new(nums.length + 1) { [] }
  
  freq.each do |num, count|
    buckets[count] << num
  end
  
  # 高頻度から取得
  result = []
  
  buckets.reverse_each do |bucket|
    bucket.each do |num|
      result << num
      return result if result.size == k
    end
  end
  
  result
end

# テストケース
p top_k_frequent([1, 1, 1, 2, 2, 3], 2)  # => [1, 2] または [2, 1]
p top_k_frequent([1], 1)  # => [1]
p top_k_frequent([4, 1, -1, 2, -1, 2, 3], 2)  # => [-1, 2] または [2, -1]
```

---

## 問題4: k番目に近い要素

### 問題文

ソート済み配列、ターゲット値x、整数kが与えられます。配列からxに最も近いk個の要素を返してください。

**入力例:**

```text
arr = [1, 2, 3, 4, 5], x = 3, k = 4
```

**出力例:**

```text
[1, 2, 3, 4]
```

### アルゴリズム概説

Binary Searchで開始位置を見つけ、Two Pointersで拡張するか、Quickselectで距離に基づいて選択します。

**時間計算量:** O(log n + k) - Binary Search + Two Pointers  
**空間計算量:** O(1)

### 擬似コード

```text
関数 find_closest_elements(配列, k, x):
    # Binary Searchでxまたはxに最も近い値を見つける
    左 = 0
    右 = 配列の長さ - k
    
    左 < 右 の間:
        中央 = (左 + 右) / 2
        
        もし x - 配列[中央] > 配列[中央 + k] - x なら:
            左 = 中央 + 1
        そうでなければ:
            右 = 中央
    
    配列[左...左 + k] を返す
```

### 解答

```ruby
# 解法1: Binary Search + Sliding Window
def find_closest_elements(arr, k, x)
  left = 0
  right = arr.length - k
  
  while left < right
    mid = (left + right) / 2
    
    # 中央位置のウィンドウとその次のウィンドウを比較
    if x - arr[mid] > arr[mid + k] - x
      left = mid + 1
    else
      right = mid
    end
  end
  
  arr[left, k]
end

# 解法2: Two Pointers（両端から縮小）
def find_closest_elements_two_pointers(arr, k, x)
  left = 0
  right = arr.length - 1
  
  # k個になるまで遠い方を削除
  while right - left >= k
    if (x - arr[left]).abs <= (arr[right] - x).abs
      right -= 1
    else
      left += 1
    end
  end
  
  arr[left..right]
end

# 解法3: Quickselect（距離でソート）
def find_closest_elements_quickselect(arr, k, x)
  # 距離の配列を作成
  distances = arr.map.with_index { |num, i| [i, (num - x).abs, num] }
  
  # k番目に近い要素を見つける
  quickselect_distance(distances, k)
  
  # 上位k個をソートして返す
  distances[0...k].map { |_, _, num| num }.sort
end

def quickselect_distance(arr, k)
  left = 0
  right = arr.length - 1
  
  loop do
    pivot_idx = partition_distance(arr, left, right)
    
    if pivot_idx == k - 1
      return
    elsif pivot_idx > k - 1
      right = pivot_idx - 1
    else
      left = pivot_idx + 1
    end
  end
end

def partition_distance(arr, left, right)
  pivot_idx = rand(left..right)
  arr[pivot_idx], arr[right] = arr[right], arr[pivot_idx]
  
  pivot = arr[right]
  i = left
  
  (left...right).each do |j|
    # 距離で比較、同じなら値で比較
    if arr[j][1] < pivot[1] || (arr[j][1] == pivot[1] && arr[j][2] < pivot[2])
      arr[i], arr[j] = arr[j], arr[i]
      i += 1
    end
  end
  
  arr[i], arr[right] = arr[right], arr[i]
  i
end

# テストケース
p find_closest_elements([1, 2, 3, 4, 5], 4, 3)  # => [1, 2, 3, 4]
p find_closest_elements([1, 2, 3, 4, 5], 4, -1)  # => [1, 2, 3, 4]
p find_closest_elements([1, 1, 1, 10, 10, 10], 1, 9)  # => [10]
```

---

## 問題5: ウィグルソート

### 問題文

整数の配列が与えられます。nums[0] < nums[1] > nums[2] < nums[3]... のようにウィグル順序に並べ替えてください。

**入力例:**

```text
[1, 5, 1, 1, 6, 4]
```

**出力例:**

```text
[1, 6, 1, 5, 1, 4]  # または他の有効な並び
```

### アルゴリズム概説

中央値を見つけて、小さい値、中央値、大きい値に分割します。その後、ウィグル順序に配置します。

**時間計算量:** O(n)  
**空間計算量:** O(n)

### 擬似コード

```text
関数 wiggle_sort(配列):
    n = 配列の長さ
    
    # 中央値を見つける
    中央値 = find_median(配列)
    
    # 3-way partition
    smaller = 中央値より小さい要素
    equal = 中央値と等しい要素
    larger = 中央値より大きい要素
    
    # ウィグル順序に配置
    # 奇数インデックスに大きい値、偶数インデックスに小さい値
    結果 = 空配列
    
    larger, equal, smaller を適切に配置
    
    配列 = 結果
```

### 解答

```ruby
# 解法1: Quickselect + 3-way partition
def wiggle_sort(nums)
  n = nums.length
  
  # 中央値を見つける
  median = find_median(nums.dup)
  
  # 3-way partition
  smaller = []
  equal = []
  larger = []
  
  nums.each do |num|
    if num < median
      smaller << num
    elsif num > median
      larger << num
    else
      equal << num
    end
  end
  
  # ウィグル順序に配置
  # 奇数インデックス（1, 3, 5...）に大きい値
  # 偶数インデックス（0, 2, 4...）に小さい値
  
  result = Array.new(n)
  
  # 大きい値を奇数インデックスに配置（降順）
  pos = 1
  larger.reverse_each do |num|
    result[pos] = num
    pos += 2
  end
  
  # 中央値を奇数インデックスに配置（残りがあれば）
  equal.reverse_each do |num|
    if pos < n
      result[pos] = num
      pos += 2
    else
      break
    end
  end
  
  # 小さい値を偶数インデックスに配置（降順）
  pos = 0
  
  # 残りの中央値を偶数インデックスに
  equal.reverse_each do |num|
    if result[1].nil? || num != result[1]
      result[pos] = num
      pos += 2
    end
  end
  
  smaller.reverse_each do |num|
    result[pos] = num
    pos += 2
  end
  
  nums.replace(result)
end

def find_median(nums)
  n = nums.length
  k = n / 2
  
  left = 0
  right = nums.length - 1
  
  loop do
    pivot_idx = partition_asc(nums, left, right)
    
    if pivot_idx == k
      return nums[k]
    elsif pivot_idx > k
      right = pivot_idx - 1
    else
      left = pivot_idx + 1
    end
  end
end

def partition_asc(nums, left, right)
  pivot_idx = rand(left..right)
  nums[pivot_idx], nums[right] = nums[right], nums[pivot_idx]
  
  pivot = nums[right]
  i = left
  
  (left...right).each do |j|
    if nums[j] < pivot
      nums[i], nums[j] = nums[j], nums[i]
      i += 1
    end
  end
  
  nums[i], nums[right] = nums[right], nums[i]
  i
end

# 解法2: ソートしてから配置
def wiggle_sort_simple(nums)
  sorted = nums.sort
  n = nums.length
  mid = (n + 1) / 2
  
  smaller = sorted[0...mid].reverse
  larger = sorted[mid..-1].reverse
  
  result = []
  
  [smaller.length, larger.length].max.times do |i|
    result << smaller[i] if i < smaller.length
    result << larger[i] if i < larger.length
  end
  
  nums.replace(result)
end

# テストケース
nums1 = [1, 5, 1, 1, 6, 4]
wiggle_sort(nums1)
p nums1  # => [1, 6, 1, 5, 1, 4] または類似

nums2 = [1, 3, 2, 2, 3, 1]
wiggle_sort(nums2)
p nums2  # => [2, 3, 1, 3, 1, 2] または類似
```

---

## 問題6: k番目に小さいペアの距離

### 問題文

整数の配列が与えられます。すべてのペア(i, j)（i < j）について、|nums[i] - nums[j]|を距離とします。k番目に小さい距離を返してください。

**入力例:**

```text
nums = [1, 3, 1], k = 1
```

**出力例:**

```text
0  # |1 - 1| = 0
```

### アルゴリズム概説

Binary Search on Answer を使用します。可能な距離の範囲で二分探索し、各距離について、それ以下のペアがいくつあるかカウントします。

**時間計算量:** O(n log n + n log W) - Wは最大距離  
**空間計算量:** O(1)

### 擬似コード

```text
関数 smallest_distance_pair(配列, k):
    配列をソート
    
    左 = 0
    右 = 配列[n-1] - 配列[0]
    
    左 < 右 の間:
        中央 = (左 + 右) / 2
        
        # 中央以下の距離を持つペアの数を数える
        カウント = count_pairs_with_distance_le(配列, 中央)
        
        もし カウント >= k なら:
            右 = 中央
        そうでなければ:
            左 = 中央 + 1
    
    左 を返す

関数 count_pairs_with_distance_le(配列, 距離):
    カウント = 0
    左 = 0
    
    各右について:
        配列[右] - 配列[左] > 距離 の間:
            左 += 1
        
        カウント += 右 - 左
    
    カウントを返す
```

### 解答

```ruby
# 解法1: Binary Search on Answer
def smallest_distance_pair(nums, k)
  nums.sort!
  
  left = 0
  right = nums[-1] - nums[0]
  
  while left < right
    mid = (left + right) / 2
    
    # mid以下の距離を持つペアの数を数える
    count = count_pairs_with_distance_le(nums, mid)
    
    if count >= k
      right = mid
    else
      left = mid + 1
    end
  end
  
  left
end

def count_pairs_with_distance_le(nums, distance)
  count = 0
  left = 0
  
  nums.each_with_index do |num, right|
    # 距離が distance を超えたら left を移動
    left += 1 while nums[right] - nums[left] > distance
    
    count += right - left
  end
  
  count
end

# 解法2: すべてのペアを列挙してQuickselect（小さい配列用）
def smallest_distance_pair_quickselect(nums, k)
  distances = []
  
  nums.length.times do |i|
    (i + 1...nums.length).each do |j|
      distances << (nums[i] - nums[j]).abs
    end
  end
  
  quickselect_simple(distances, k - 1)
end

def quickselect_simple(arr, k)
  left = 0
  right = arr.length - 1
  
  loop do
    pivot_idx = partition_simple(arr, left, right)
    
    if pivot_idx == k
      return arr[k]
    elsif pivot_idx > k
      right = pivot_idx - 1
    else
      left = pivot_idx + 1
    end
  end
end

def partition_simple(arr, left, right)
  pivot_idx = rand(left..right)
  arr[pivot_idx], arr[right] = arr[right], arr[pivot_idx]
  
  pivot = arr[right]
  i = left
  
  (left...right).each do |j|
    if arr[j] < pivot
      arr[i], arr[j] = arr[j], arr[i]
      i += 1
    end
  end
  
  arr[i], arr[right] = arr[right], arr[i]
  i
end

# テストケース
p smallest_distance_pair([1, 3, 1], 1)  # => 0
p smallest_distance_pair([1, 1, 1], 2)  # => 0
p smallest_distance_pair([1, 6, 1], 3)  # => 5
```

---

## まとめ

このセクションでは、Quickselect アルゴリズムとその応用を学びました。

重要なポイントは以下の通りです。

1. Quickselectは平均O(n)でk番目の要素を見つけます
2. ランダムなピボット選択で最悪ケースを回避できます
3. パーティション操作はQuicksortと同じですが、片側のみ処理します
4. 頻度、距離などのカスタム基準でも適用できます
5. Binary Search on Answer と組み合わせると強力です

Quickselectは、完全なソートが不要な場合に非常に効率的なアルゴリズムです。k番目の要素を見つける問題や、トップK問題で頻繁に使用されます。
