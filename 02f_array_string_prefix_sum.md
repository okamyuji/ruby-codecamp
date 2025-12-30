# 配列と文字列 - 応用（累積和）

## 概要

このセクションでは、累積和（Prefix Sum）テクニックを学びます。累積和を使用すると、範囲の合計を事前計算することで、クエリをO(1)で処理できます。これは、部分配列の合計、範囲クエリ、2D行列の範囲合計などの問題に非常に有効です。

---

## 問題1: 範囲の合計クエリ

### 問題文

整数の配列が与えられます。複数のクエリがあり、各クエリは[left, right]の範囲の合計を求めます。クエリを効率的に処理してください。

**入力例:**

```text
nums = [1, 2, 3, 4, 5]
クエリ: [[0, 2], [1, 4], [2, 3]]
```

**出力例:**

```text
[6, 14, 7]  # [1+2+3, 2+3+4+5, 3+4]
```

### アルゴリズム概説

累積和配列を事前に計算します。prefix[i]は配列の最初からi番目までの合計を表します。範囲[left, right]の合計はprefix[right + 1] - prefix[left]で求められます。

**時間計算量:** O(n)の事前計算、O(1)のクエリ  
**空間計算量:** O(n)

### 擬似コード

```text
クラス RangeSumQuery:
    初期化(配列):
        n = 配列の長さ
        prefix = サイズn+1の配列（0で初期化）
        
        各インデックスiについて:
            prefix[i + 1] = prefix[i] + 配列[i]
    
    sum_range(left, right):
        prefix[right + 1] - prefix[left] を返す
```

### 解答

```ruby
# 解法1: クラスとして実装
class RangeSumQuery
  def initialize(nums)
    @prefix = [0]
    
    nums.each do |num|
      @prefix << @prefix.last + num
    end
  end
  
  def sum_range(left, right)
    @prefix[right + 1] - @prefix[left]
  end
end

# 解法2: 関数として実装
def build_prefix_sum(nums)
  prefix = [0]
  
  nums.each do |num|
    prefix << prefix.last + num
  end
  
  prefix
end

def range_sum(prefix, left, right)
  prefix[right + 1] - prefix[left]
end

# 解法3: scanを使用
def build_prefix_sum_scan(nums)
  [0] + nums.each_with_object([0]) { |num, acc| acc << acc.last + num }
end

# テストケース
nums = [1, 2, 3, 4, 5]
rsq = RangeSumQuery.new(nums)

p rsq.sum_range(0, 2)  # => 6  (1 + 2 + 3)
p rsq.sum_range(1, 4)  # => 14 (2 + 3 + 4 + 5)
p rsq.sum_range(2, 3)  # => 7  (3 + 4)

# 関数版
prefix = build_prefix_sum(nums)
p range_sum(prefix, 0, 2)  # => 6
p range_sum(prefix, 1, 4)  # => 14
```

---

## 問題2: 部分配列の合計が0

### 問題文

整数の配列が与えられます。合計が0になる部分配列が存在するかどうかを判定してください。

**入力例:**

```text
[4, 2, -3, 1, 6]
```

**出力例:**

```text
true  # [2, -3, 1] の合計が0
```

### アルゴリズム概説

累積和をハッシュセットに記録します。同じ累積和が2回現れた場合、その間の部分配列の合計は0です。

**時間計算量:** O(n)  
**空間計算量:** O(n)

### 擬似コード

```text
関数 has_zero_sum_subarray(配列):
    累積和 = 0
    見つかった和 = セット（0を含む）
    
    配列の各要素について:
        累積和 += 要素
        
        もし 累積和 が 見つかった和 に存在する なら:
            true を返す
        
        見つかった和に累積和を追加
    
    false を返す
```

### 解答

```ruby
# 解法1: ハッシュセットを使用
def has_zero_sum_subarray(nums)
  sum = 0
  seen = Set.new([0])
  
  nums.each do |num|
    sum += num
    
    return true if seen.include?(sum)
    
    seen << sum
  end
  
  false
end

# 解法2: ハッシュを使用（インデックスも記録）
def find_zero_sum_subarray(nums)
  sum = 0
  sum_map = { 0 => -1 }
  
  nums.each_with_index do |num, i|
    sum += num
    
    if sum_map.key?(sum)
      start_idx = sum_map[sum] + 1
      return [start_idx, i]
    end
    
    sum_map[sum] = i
  end
  
  nil
end

# 解法3: すべての0合計部分配列を見つける
def find_all_zero_sum_subarrays(nums)
  result = []
  sum = 0
  sum_map = Hash.new { |h, k| h[k] = [] }
  sum_map[0] << -1
  
  nums.each_with_index do |num, i|
    sum += num
    
    if sum_map.key?(sum)
      sum_map[sum].each do |start_idx|
        result << [start_idx + 1, i]
      end
    end
    
    sum_map[sum] << i
  end
  
  result
end

# テストケース
p has_zero_sum_subarray([4, 2, -3, 1, 6])  # => true
p has_zero_sum_subarray([4, 2, 0, 1, 6])   # => true (0単体)
p has_zero_sum_subarray([1, 2, 3])         # => false

p find_zero_sum_subarray([4, 2, -3, 1, 6])  # => [1, 3]
p find_all_zero_sum_subarrays([1, 2, -3, 3, -1, -1])
# => [[0, 2], [1, 3], [3, 5]]
```

---

## 問題3: 合計がKの部分配列の数

### 問題文

整数の配列と整数kが与えられます。合計がkになる連続する部分配列の数を返してください。

**入力例:**

```text
nums = [1, 1, 1], k = 2
```

**出力例:**

```text
2  # [1, 1] が2回
```

### アルゴリズム概説

累積和とハッシュマップを使用します。現在の累積和からkを引いた値が過去に何回現れたかを数えます。

**時間計算量:** O(n)  
**空間計算量:** O(n)

### 擬似コード

```text
関数 subarray_sum(配列, k):
    カウント = 0
    累積和 = 0
    和マップ = ハッシュ（0 => 1）
    
    配列の各要素について:
        累積和 += 要素
        
        もし (累積和 - k) が 和マップ に存在する なら:
            カウント += 和マップ[累積和 - k]
        
        和マップ[累積和] += 1
    
    カウントを返す
```

### 解答

```ruby
# 解法1: ハッシュマップを使用
def subarray_sum(nums, k)
  count = 0
  sum = 0
  sum_map = Hash.new(0)
  sum_map[0] = 1
  
  nums.each do |num|
    sum += num
    
    # sum - k が存在すれば、その部分配列を除いた残りがk
    count += sum_map[sum - k] if sum_map.key?(sum - k)
    
    sum_map[sum] += 1
  end
  
  count
end

# 解法2: すべての部分配列のインデックスを見つける
def find_subarray_sum_indices(nums, k)
  result = []
  sum = 0
  sum_map = Hash.new { |h, key| h[key] = [] }
  sum_map[0] << -1
  
  nums.each_with_index do |num, i|
    sum += num
    
    if sum_map.key?(sum - k)
      sum_map[sum - k].each do |start_idx|
        result << [start_idx + 1, i]
      end
    end
    
    sum_map[sum] << i
  end
  
  result
end

# 解法3: ブルートフォース（比較用）
def subarray_sum_brute(nums, k)
  count = 0
  
  nums.length.times do |i|
    sum = 0
    
    (i...nums.length).each do |j|
      sum += nums[j]
      count += 1 if sum == k
    end
  end
  
  count
end

# テストケース
p subarray_sum([1, 1, 1], 2)        # => 2
p subarray_sum([1, 2, 3], 3)        # => 2 ([1, 2] と [3])
p subarray_sum([1, -1, 0], 0)       # => 3
p subarray_sum([3, 4, 7, 2, -3, 1, 4, 2], 7)  # => 4

p find_subarray_sum_indices([1, 2, 3], 3)
# => [[0, 0], [0, 1]]  # [3] と [1, 2]
```

---

## 問題4: 2D行列の範囲合計

### 問題文

2D行列が与えられます。複数のクエリがあり、各クエリは矩形領域の合計を求めます。クエリを効率的に処理してください。

**入力例:**

```text
matrix = [[3, 0, 1, 4, 2],
          [5, 6, 3, 2, 1],
          [1, 2, 0, 1, 5],
          [4, 1, 0, 1, 7],
          [1, 0, 3, 0, 5]]
クエリ: [1, 1, 2, 2]  # row1からrow2, col1からcol2
```

**出力例:**

```text
11  # 6 + 3 + 2 + 0 = 11
```

### アルゴリズム概説

2D累積和配列を事前計算します。`prefix[i][j]`は左上から(i-1, j-1)までの矩形の合計を表します。

**時間計算量:** O(m × n)の事前計算、O(1)のクエリ  
**空間計算量:** O(m × n)

### 擬似コード

```text
クラス Matrix2DSum:
    初期化(行列):
        m = 行数
        n = 列数
        prefix = (m+1) × (n+1) の配列
        
        各セル(i, j)について:
            prefix[i+1][j+1] = 
                行列[i][j] +
                prefix[i][j+1] +
                prefix[i+1][j] -
                prefix[i][j]
    
    sum_region(r1, c1, r2, c2):
        prefix[r2+1][c2+1] -
        prefix[r1][c2+1] -
        prefix[r2+1][c1] +
        prefix[r1][c1]
        を返す
```

### 解答

```ruby
# 解法1: 2D累積和配列
class Matrix2DSum
  def initialize(matrix)
    return if matrix.empty? || matrix[0].empty?
    
    m = matrix.length
    n = matrix[0].length
    
    # (m+1) × (n+1) の累積和配列
    @prefix = Array.new(m + 1) { Array.new(n + 1, 0) }
    
    m.times do |i|
      n.times do |j|
        @prefix[i + 1][j + 1] = 
          matrix[i][j] +
          @prefix[i][j + 1] +
          @prefix[i + 1][j] -
          @prefix[i][j]
      end
    end
  end
  
  def sum_region(row1, col1, row2, col2)
    @prefix[row2 + 1][col2 + 1] -
    @prefix[row1][col2 + 1] -
    @prefix[row2 + 1][col1] +
    @prefix[row1][col1]
  end
end

# 解法2: 関数として実装
def build_2d_prefix_sum(matrix)
  return [] if matrix.empty? || matrix[0].empty?
  
  m = matrix.length
  n = matrix[0].length
  prefix = Array.new(m + 1) { Array.new(n + 1, 0) }
  
  m.times do |i|
    n.times do |j|
      prefix[i + 1][j + 1] = 
        matrix[i][j] +
        prefix[i][j + 1] +
        prefix[i + 1][j] -
        prefix[i][j]
    end
  end
  
  prefix
end

def query_2d_sum(prefix, row1, col1, row2, col2)
  prefix[row2 + 1][col2 + 1] -
  prefix[row1][col2 + 1] -
  prefix[row2 + 1][col1] +
  prefix[row1][col1]
end

# テストケース
matrix = [[3, 0, 1, 4, 2],
          [5, 6, 3, 2, 1],
          [1, 2, 0, 1, 5],
          [4, 1, 0, 1, 7],
          [1, 0, 3, 0, 5]]

m2d = Matrix2DSum.new(matrix)

p m2d.sum_region(1, 1, 2, 2)  # => 11
p m2d.sum_region(0, 0, 4, 4)  # => 58 (全体の合計)
p m2d.sum_region(2, 1, 4, 3)  # => 8
```

---

## 問題5: 等しい0と1の最長部分配列

### 問題文

0と1のみからなる配列が与えられます。0と1の個数が等しい最長の連続部分配列の長さを返してください。

**入力例:**

```text
[0, 1, 0]
```

**出力例:**

```text
2  # [0, 1] または [1, 0]
```

### アルゴリズム概説

0を-1に変換すると、問題は「合計が0の最長部分配列」になります。累積和とハッシュマップで最初の出現位置を記録します。

**時間計算量:** O(n)  
**空間計算量:** O(n)

### 擬似コード

```text
関数 find_max_length(配列):
    最大長 = 0
    累積和 = 0
    和マップ = ハッシュ（0 => -1）
    
    各インデックスiについて:
        # 0を-1として扱う
        累積和 += 配列[i] == 1 ? 1 : -1
        
        もし 累積和 が 和マップ に存在する なら:
            長さ = i - 和マップ[累積和]
            最大長 = max(最大長, 長さ)
        そうでなければ:
            和マップ[累積和] = i
    
    最大長を返す
```

### 解答

```ruby
# 解法1: 累積和とハッシュマップ
def find_max_length(nums)
  max_len = 0
  sum = 0
  sum_map = { 0 => -1 }
  
  nums.each_with_index do |num, i|
    # 0を-1として扱う
    sum += num == 1 ? 1 : -1
    
    if sum_map.key?(sum)
      length = i - sum_map[sum]
      max_len = [max_len, length].max
    else
      sum_map[sum] = i
    end
  end
  
  max_len
end

# 解法2: 配列を変換してから処理
def find_max_length_transform(nums)
  # 0を-1に変換
  transformed = nums.map { |x| x == 1 ? 1 : -1 }
  
  max_len = 0
  sum = 0
  sum_map = { 0 => -1 }
  
  transformed.each_with_index do |num, i|
    sum += num
    
    if sum_map.key?(sum)
      max_len = [max_len, i - sum_map[sum]].max
    else
      sum_map[sum] = i
    end
  end
  
  max_len
end

# 解法3: 部分配列のインデックスも返す
def find_max_length_with_indices(nums)
  max_len = 0
  start_idx = 0
  end_idx = -1
  sum = 0
  sum_map = { 0 => -1 }
  
  nums.each_with_index do |num, i|
    sum += num == 1 ? 1 : -1
    
    if sum_map.key?(sum)
      length = i - sum_map[sum]
      
      if length > max_len
        max_len = length
        start_idx = sum_map[sum] + 1
        end_idx = i
      end
    else
      sum_map[sum] = i
    end
  end
  
  { length: max_len, start: start_idx, end: end_idx }
end

# テストケース
p find_max_length([0, 1])        # => 2
p find_max_length([0, 1, 0])     # => 2
p find_max_length([0, 0, 1, 0, 0, 0, 1, 1])  # => 6

p find_max_length_with_indices([0, 1, 0])
# => { length: 2, start: 0, end: 1 }
```

---

## 問題6: 積が正の最長部分配列

### 問題文

整数の配列が与えられます。積が正になる最長の連続部分配列の長さを返してください。

**入力例:**

```text
[1, -2, -3, 4]
```

**出力例:**

```text
4  # 全体の積が24（正）
```

### アルゴリズム概説

負の数の個数の偶奇を追跡します。負の数の個数が偶数の区間は積が正です。

**時間計算量:** O(n)  
**空間計算量:** O(n)

### 擬似コード

```text
関数 max_length_positive_product(配列):
    最大長 = 0
    負の数カウント = 0
    パリティマップ = ハッシュ（0 => -1）
    
    各インデックスiについて:
        もし 配列[i] < 0 なら:
            負の数カウント += 1
        
        パリティ = 負の数カウント % 2
        
        もし パリティ が パリティマップ に存在する なら:
            長さ = i - パリティマップ[パリティ]
            最大長 = max(最大長, 長さ)
        そうでなければ:
            パリティマップ[パリティ] = i
    
    最大長を返す
```

### 解答

```ruby
# 解法1: 負の数の偶奇を追跡
def max_length_positive_product(nums)
  max_len = 0
  neg_count = 0
  parity_map = { 0 => -1 }
  
  nums.each_with_index do |num, i|
    # 0を含む部分配列は積が0なので除外
    if num.zero?
      neg_count = 0
      parity_map = { 0 => i }
      next
    end
    
    neg_count += 1 if num < 0
    
    parity = neg_count % 2
    
    if parity_map.key?(parity)
      length = i - parity_map[parity]
      max_len = [max_len, length].max
    else
      parity_map[parity] = i
    end
  end
  
  max_len
end

# 解法2: 符号の累積和を使用
def max_length_positive_product_sign(nums)
  max_len = 0
  sign = 1
  sign_map = { 1 => -1 }
  
  nums.each_with_index do |num, i|
    if num.zero?
      sign = 1
      sign_map = { 1 => i }
      next
    end
    
    sign *= num <=> 0  # -1, 0, or 1
    
    if sign_map.key?(sign)
      max_len = [max_len, i - sign_map[sign]].max
    else
      sign_map[sign] = i
    end
  end
  
  max_len
end

# テストケース
p max_length_positive_product([1, -2, -3, 4])      # => 4
p max_length_positive_product([0, 1, -2, -3, -4])  # => 3
p max_length_positive_product([-1, -2, -3, 0, 1])  # => 2
```

---

## 問題7: 部分配列の合計がKの倍数

### 問題文

整数の配列と整数kが与えられます。合計がkの倍数になる長さが少なくとも2の連続部分配列が存在するかどうかを判定してください。

**入力例:**

```text
nums = [23, 2, 4, 6, 7], k = 6
```

**出力例:**

```text
true  # [2, 4] の合計6はkの倍数
```

### アルゴリズム概説

累積和をkで割った余りを記録します。同じ余りが2回現れ、その間に少なくとも2つの要素があれば、その部分配列の合計はkの倍数です。

**時間計算量:** O(n)  
**空間計算量:** O(k)

### 擬似コード

```text
関数 check_subarray_sum(配列, k):
    累積和 = 0
    余りマップ = ハッシュ（0 => -1）
    
    各インデックスiについて:
        累積和 += 配列[i]
        余り = 累積和 % k
        
        もし 余り が 余りマップ に存在する なら:
            もし i - 余りマップ[余り] >= 2 なら:
                true を返す
        そうでなければ:
            余りマップ[余り] = i
    
    false を返す
```

### 解答

```ruby
# 解法1: 余りを記録
def check_subarray_sum(nums, k)
  sum = 0
  remainder_map = { 0 => -1 }
  
  nums.each_with_index do |num, i|
    sum += num
    remainder = sum % k
    
    if remainder_map.key?(remainder)
      return true if i - remainder_map[remainder] >= 2
    else
      remainder_map[remainder] = i
    end
  end
  
  false
end

# 解法2: すべての有効な部分配列を見つける
def find_all_subarray_sum_multiple(nums, k)
  result = []
  sum = 0
  remainder_map = Hash.new { |h, key| h[key] = [] }
  remainder_map[0] << -1
  
  nums.each_with_index do |num, i|
    sum += num
    remainder = sum % k
    
    remainder_map[remainder].each do |start_idx|
      if i - start_idx >= 2
        result << [start_idx + 1, i]
      end
    end
    
    remainder_map[remainder] << i
  end
  
  result
end

# テストケース
p check_subarray_sum([23, 2, 4, 6, 7], 6)  # => true
p check_subarray_sum([23, 2, 6, 4, 7], 6)  # => true
p check_subarray_sum([23, 2, 6, 4, 7], 13) # => false

p find_all_subarray_sum_multiple([23, 2, 4, 6, 7], 6)
# => [[1, 2], [0, 4]]
```

---

## 問題8: 製品の配列（自分以外）

### 問題文

整数の配列が与えられます。output[i]がnums[i]以外のすべての要素の積になるような配列を返してください。除算を使わずにO(n)で解いてください。

**入力例:**

```text
[1, 2, 3, 4]
```

**出力例:**

```text
[24, 12, 8, 6]
```

### アルゴリズム概説

左からの累積積と右からの累積積を計算し、組み合わせます。

**時間計算量:** O(n)  
**空間計算量:** O(1) - 出力配列を除く

### 擬似コード

```text
関数 product_except_self(配列):
    n = 配列の長さ
    結果 = サイズnの配列
    
    # 左からの累積積
    左積 = 1
    各インデックスiについて:
        結果[i] = 左積
        左積 *= 配列[i]
    
    # 右からの累積積を掛ける
    右積 = 1
    各インデックスi（逆順）について:
        結果[i] *= 右積
        右積 *= 配列[i]
    
    結果を返す
```

### 解答

```ruby
# 解法1: 2パス（O(1)空間）
def product_except_self(nums)
  n = nums.length
  result = Array.new(n)
  
  # 左からの累積積
  left_product = 1
  n.times do |i|
    result[i] = left_product
    left_product *= nums[i]
  end
  
  # 右からの累積積を掛ける
  right_product = 1
  (n - 1).downto(0) do |i|
    result[i] *= right_product
    right_product *= nums[i]
  end
  
  result
end

# 解法2: 左右の配列を明示的に作成（理解しやすい）
def product_except_self_explicit(nums)
  n = nums.length
  left = Array.new(n, 1)
  right = Array.new(n, 1)
  
  # 左からの累積積
  (1...n).each do |i|
    left[i] = left[i - 1] * nums[i - 1]
  end
  
  # 右からの累積積
  (n - 2).downto(0) do |i|
    right[i] = right[i + 1] * nums[i + 1]
  end
  
  # 組み合わせ
  n.times.map { |i| left[i] * right[i] }
end

# 解法3: 除算を使用（0がある場合に注意）
def product_except_self_division(nums)
  total_product = nums.reduce(1, :*)
  zero_count = nums.count(0)
  
  if zero_count > 1
    return Array.new(nums.length, 0)
  elsif zero_count == 1
    return nums.map { |num| num.zero? ? total_product : 0 }
  end
  
  nums.map { |num| total_product / num }
end

# テストケース
p product_except_self([1, 2, 3, 4])
# => [24, 12, 8, 6]

p product_except_self([0, 0])
# => [0, 0]

p product_except_self([0, 4, 0])
# => [0, 0, 0]

p product_except_self([1, 0])
# => [0, 1]
```

---

## まとめ

このセクションでは、累積和（Prefix Sum）テクニックとその応用を学びました。

重要なポイントは以下の通りです。

1. 累積和を事前計算することで範囲クエリをO(1)で処理できます
2. 2D累積和は矩形領域のクエリに有効です
3. 累積和とハッシュマップを組み合わせると部分配列の合計問題を効率的に解けます
4. 0を-1に変換することで等しい要素の問題を合計問題に変換できます
5. 余りを記録することで倍数の問題を解けます
6. 累積積も同様のテクニックで使用できます

累積和は非常に汎用的なテクニックで、多くの配列・文字列問題で使用されます。このパターンを理解することで、多くの問題を効率的に解決できるようになります。
