# 配列と文字列 - 応用（Two Pointers）

## 概要

このセクションでは、Two Pointers（2つのポインタ）テクニックを学びます。このテクニックは、配列やリストの両端または異なる位置から2つのポインタを動かして問題を解く手法です。多くの場合、O(n²)の問題をO(n)に改善できます。

---

## 問題1: ソート済み配列の2つの数の合計

### 問題文

ソート済みの整数配列と目標値が与えられます。合計が目標値になる2つの数のインデックスを返してください（1-indexed）。

**入力例:**

```text
numbers = [2, 7, 11, 15], target = 9
```

**出力例:**

```text
[1, 2]  # numbers[0] + numbers[1] = 2 + 7 = 9
```

### アルゴリズム概説

左端と右端から2つのポインタを開始します。合計が目標より小さければ左ポインタを進め、大きければ右ポインタを戻します。

**時間計算量:** O(n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 two_sum(配列, target):
    左 = 0
    右 = 配列の長さ - 1
    
    左 < 右 の間:
        合計 = 配列[左] + 配列[右]
        
        もし 合計 == target なら:
            [左 + 1, 右 + 1] を返す
        もし 合計 < target なら:
            左 += 1
        そうでなければ:
            右 -= 1
    
    [] を返す
```

### 解答

```ruby
# 解法1: Two Pointers
def two_sum(numbers, target)
  left = 0
  right = numbers.length - 1
  
  while left < right
    sum = numbers[left] + numbers[right]
    
    return [left + 1, right + 1] if sum == target
    
    if sum < target
      left += 1
    else
      right -= 1
    end
  end
  
  []
end

# 解法2: すべてのペアを見つける
def find_all_two_sum(numbers, target)
  result = []
  left = 0
  right = numbers.length - 1
  
  while left < right
    sum = numbers[left] + numbers[right]
    
    if sum == target
      result << [left + 1, right + 1]
      left += 1
      right -= 1
    elsif sum < target
      left += 1
    else
      right -= 1
    end
  end
  
  result
end

# 解法3: ハッシュを使用（ソート不要）
def two_sum_hash(numbers, target)
  seen = {}
  
  numbers.each_with_index do |num, i|
    complement = target - num
    
    return [seen[complement] + 1, i + 1] if seen.key?(complement)
    
    seen[num] = i
  end
  
  []
end

# テストケース
p two_sum([2, 7, 11, 15], 9)    # => [1, 2]
p two_sum([2, 3, 4], 6)         # => [1, 3]
p two_sum([-1, 0], -1)          # => [1, 2]

p find_all_two_sum([1, 2, 3, 4, 5], 6)
# => [[1, 5], [2, 4]]
```

---

## 問題2: 回文の判定

### 問題文

文字列が与えられます。英数字のみを考慮し、大文字小文字を区別せずに、回文かどうかを判定してください。

**入力例:**

```text
"A man, a plan, a canal: Panama"
```

**出力例:**

```text
true
```

### アルゴリズム概説

両端から2つのポインタを開始し、中央に向かって進みます。英数字以外はスキップします。

**時間計算量:** O(n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 is_palindrome(文字列):
    左 = 0
    右 = 文字列の長さ - 1
    
    左 < 右 の間:
        # 英数字でない文字をスキップ
        左 < 右 かつ 文字列[左]が英数字でない の間:
            左 += 1
        
        左 < 右 かつ 文字列[右]が英数字でない の間:
            右 -= 1
        
        # 大文字小文字を無視して比較
        もし 文字列[左].小文字 != 文字列[右].小文字 なら:
            false を返す
        
        左 += 1
        右 -= 1
    
    true を返す
```

### 解答

```ruby
# 解法1: Two Pointers
def is_palindrome(s)
  left = 0
  right = s.length - 1
  
  while left < right
    # 英数字でない文字をスキップ
    left += 1 while left < right && !alphanumeric?(s[left])
    right -= 1 while left < right && !alphanumeric?(s[right])
    
    # 大文字小文字を無視して比較
    return false if s[left].downcase != s[right].downcase
    
    left += 1
    right -= 1
  end
  
  true
end

def alphanumeric?(char)
  char =~ /[a-zA-Z0-9]/
end

# 解法2: 文字列を整形してから比較
def is_palindrome_clean(s)
  cleaned = s.downcase.gsub(/[^a-z0-9]/, '')
  cleaned == cleaned.reverse
end

# 解法3: each_charとreduceを使用
def is_palindrome_functional(s)
  chars = s.downcase.chars.select { |c| c =~ /[a-z0-9]/ }
  chars == chars.reverse
end

# テストケース
p is_palindrome("A man, a plan, a canal: Panama")  # => true
p is_palindrome("race a car")                      # => false
p is_palindrome(" ")                               # => true
p is_palindrome("0P")                              # => false
```

---

## 問題3: コンテナに最も多く水を入れる

### 問題文

各要素が垂直線の高さを表す配列が与えられます。2本の線を選んで、最も多くの水を入れられる面積を返してください。

**入力例:**

```text
[1, 8, 6, 2, 5, 4, 8, 3, 7]
```

**出力例:**

```text
49  # インデックス1と8の線（高さ8と7、幅7）
```

### アルゴリズム概説

両端から開始し、高さの低い方のポインタを内側に移動させます。

**時間計算量:** O(n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 max_area(高さ配列):
    最大面積 = 0
    左 = 0
    右 = 配列の長さ - 1
    
    左 < 右 の間:
        幅 = 右 - 左
        高さ = min(高さ配列[左], 高さ配列[右])
        面積 = 幅 * 高さ
        最大面積 = max(最大面積, 面積)
        
        # 低い方を移動
        もし 高さ配列[左] < 高さ配列[右] なら:
            左 += 1
        そうでなければ:
            右 -= 1
    
    最大面積を返す
```

### 解答

```ruby
# 解法1: Two Pointers
def max_area(height)
  max_area = 0
  left = 0
  right = height.length - 1
  
  while left < right
    width = right - left
    h = [height[left], height[right]].min
    area = width * h
    max_area = [max_area, area].max
    
    # 低い方を移動
    if height[left] < height[right]
      left += 1
    else
      right -= 1
    end
  end
  
  max_area
end

# 解法2: インデックスも返す
def max_area_with_indices(height)
  max_area = 0
  best_left = 0
  best_right = 0
  left = 0
  right = height.length - 1
  
  while left < right
    width = right - left
    h = [height[left], height[right]].min
    area = width * h
    
    if area > max_area
      max_area = area
      best_left = left
      best_right = right
    end
    
    if height[left] < height[right]
      left += 1
    else
      right -= 1
    end
  end
  
  { area: max_area, left: best_left, right: best_right }
end

# 解法3: ブルートフォース（比較用）
def max_area_brute(height)
  max_area = 0
  
  height.length.times do |i|
    (i + 1...height.length).each do |j|
      width = j - i
      h = [height[i], height[j]].min
      area = width * h
      max_area = [max_area, area].max
    end
  end
  
  max_area
end

# テストケース
p max_area([1, 8, 6, 2, 5, 4, 8, 3, 7])  # => 49
p max_area([1, 1])                       # => 1
p max_area([4, 3, 2, 1, 4])              # => 16

p max_area_with_indices([1, 8, 6, 2, 5, 4, 8, 3, 7])
# => { area: 49, left: 1, right: 8 }
```

---

## 問題4: 3つの数の合計

### 問題文

整数の配列が与えられます。合計が0になる3つの数の組み合わせをすべて返してください。重複する組み合わせは含めません。

**入力例:**

```text
[-1, 0, 1, 2, -1, -4]
```

**出力例:**

```text
[[-1, -1, 2], [-1, 0, 1]]
```

### アルゴリズム概説

配列をソートし、1つの要素を固定して、残りの2つをTwo Pointersで探します。

**時間計算量:** O(n²)  
**空間計算量:** O(1) - 出力配列を除く

### 擬似コード

```text
関数 three_sum(配列):
    配列をソート
    結果 = 空配列
    
    各インデックスiについて（n-2まで）:
        # 重複をスキップ
        もし i > 0 かつ 配列[i] == 配列[i-1] なら:
            continue
        
        # Two Pointers で残り2つを探す
        左 = i + 1
        右 = n - 1
        
        左 < 右 の間:
            合計 = 配列[i] + 配列[左] + 配列[右]
            
            もし 合計 == 0 なら:
                結果に [配列[i], 配列[左], 配列[右]] を追加
                
                # 重複をスキップ
                左 += 1 while 左 < 右 かつ 配列[左] == 配列[左-1]
                右 -= 1 while 左 < 右 かつ 配列[右] == 配列[右+1]
            もし 合計 < 0 なら:
                左 += 1
            そうでなければ:
                右 -= 1
    
    結果を返す
```

### 解答

```ruby
# 解法1: ソート + Two Pointers
def three_sum(nums)
  nums.sort!
  result = []
  
  (nums.length - 2).times do |i|
    # 重複をスキップ
    next if i > 0 && nums[i] == nums[i - 1]
    
    left = i + 1
    right = nums.length - 1
    
    while left < right
      sum = nums[i] + nums[left] + nums[right]
      
      if sum.zero?
        result << [nums[i], nums[left], nums[right]]
        
        # 重複をスキップ
        left += 1 while left < right && nums[left] == nums[left - 1]
        right -= 1 while left < right && nums[right] == nums[right + 1]
        
        left += 1
        right -= 1
      elsif sum < 0
        left += 1
      else
        right -= 1
      end
    end
  end
  
  result
end

# 解法2: ハッシュを使用
def three_sum_hash(nums)
  result = Set.new
  
  nums.length.times do |i|
    seen = Set.new
    
    (i + 1...nums.length).each do |j|
      complement = -(nums[i] + nums[j])
      
      if seen.include?(complement)
        triplet = [nums[i], nums[j], complement].sort
        result << triplet
      end
      
      seen << nums[j]
    end
  end
  
  result.to_a
end

# テストケース
p three_sum([-1, 0, 1, 2, -1, -4])
# => [[-1, -1, 2], [-1, 0, 1]]

p three_sum([0, 0, 0])
# => [[0, 0, 0]]

p three_sum([])
# => []
```

---

## 問題5: 重複を削除（ソート済み配列）

### 問題文

ソート済みの配列が与えられます。重複を削除し、各要素が1回だけ現れるようにしてください。in-placeで行い、新しい長さを返してください。

**入力例:**

```text
[1, 1, 2]
```

**出力例:**

```text
2  # 配列は [1, 2, ...] になる
```

### アルゴリズム概説

書き込み位置を示すポインタと読み込み位置を示すポインタの2つを使用します。

**時間計算量:** O(n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 remove_duplicates(配列):
    もし 配列が空 なら:
        0 を返す
    
    書き込み位置 = 1
    
    各インデックスi（1から開始）について:
        もし 配列[i] != 配列[i-1] なら:
            配列[書き込み位置] = 配列[i]
            書き込み位置 += 1
    
    書き込み位置を返す
```

### 解答

```ruby
# 解法1: Two Pointers
def remove_duplicates(nums)
  return 0 if nums.empty?
  
  write_pos = 1
  
  (1...nums.length).each do |i|
    if nums[i] != nums[i - 1]
      nums[write_pos] = nums[i]
      write_pos += 1
    end
  end
  
  write_pos
end

# 解法2: 各要素が最大2回まで出現を許可
def remove_duplicates_allow_twice(nums)
  return nums.length if nums.length <= 2
  
  write_pos = 2
  
  (2...nums.length).each do |i|
    if nums[i] != nums[write_pos - 2]
      nums[write_pos] = nums[i]
      write_pos += 1
    end
  end
  
  write_pos
end

# 解法3: 新しい配列を作成（in-placeではない）
def remove_duplicates_new_array(nums)
  nums.uniq
end

# テストケース
nums1 = [1, 1, 2]
k1 = remove_duplicates(nums1)
p [k1, nums1[0...k1]]  # => [2, [1, 2]]

nums2 = [0, 0, 1, 1, 1, 2, 2, 3, 3, 4]
k2 = remove_duplicates(nums2)
p [k2, nums2[0...k2]]  # => [5, [0, 1, 2, 3, 4]]

nums3 = [1, 1, 1, 2, 2, 3]
k3 = remove_duplicates_allow_twice(nums3)
p [k3, nums3[0...k3]]  # => [5, [1, 1, 2, 2, 3]]
```

---

## 問題6: 配列のパーティション

### 問題文

整数の配列とピボット値が与えられます。ピボットより小さい要素を左に、ピボット以上の要素を右に配置してください。

**入力例:**

```text
nums = [3, 5, 2, 1, 6, 4], pivot = 3
```

**出力例:**

```text
[2, 1, 3, 5, 6, 4]  # または他の有効な配置
```

### アルゴリズム概説

2つのポインタを使用して、ピボットより小さい要素と大きい要素を交換します。

**時間計算量:** O(n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 partition(配列, pivot):
    左 = 0
    右 = 配列の長さ - 1
    
    左 <= 右 の間:
        # 左から大きい要素を探す
        左 < 右 かつ 配列[左] < pivot の間:
            左 += 1
        
        # 右から小さい要素を探す
        左 < 右 かつ 配列[右] >= pivot の間:
            右 -= 1
        
        # 交換
        もし 左 < 右 なら:
            配列[左] と 配列[右] を交換
            左 += 1
            右 -= 1
    
    配列を返す
```

### 解答

```ruby
# 解法1: Two Pointers
def partition(nums, pivot)
  left = 0
  right = nums.length - 1
  
  while left <= right
    # 左から pivot 以上の要素を探す
    left += 1 while left < right && nums[left] < pivot
    
    # 右から pivot より小さい要素を探す
    right -= 1 while left < right && nums[right] >= pivot
    
    # 交換
    if left < right
      nums[left], nums[right] = nums[right], nums[left]
      left += 1
      right -= 1
    end
  end
  
  nums
end

# 解法2: 3-way partition（pivot未満、等しい、より大きい）
def three_way_partition(nums, pivot)
  less = 0
  equal = 0
  greater = nums.length - 1
  
  while equal <= greater
    if nums[equal] < pivot
      nums[less], nums[equal] = nums[equal], nums[less]
      less += 1
      equal += 1
    elsif nums[equal] == pivot
      equal += 1
    else
      nums[equal], nums[greater] = nums[greater], nums[equal]
      greater -= 1
    end
  end
  
  nums
end

# 解法3: selectで新しい配列を作成
def partition_new_array(nums, pivot)
  less = nums.select { |x| x < pivot }
  equal = nums.select { |x| x == pivot }
  greater = nums.select { |x| x > pivot }
  
  less + equal + greater
end

# テストケース
p partition([3, 5, 2, 1, 6, 4], 3)
# => [2, 1, 3, 5, 6, 4] または類似

p three_way_partition([3, 5, 2, 1, 6, 4, 3], 3)
# => [2, 1, 3, 3, 5, 6, 4] または類似
```

---

## 問題7: 部分配列の積がK未満

### 問題文

正の整数の配列と整数kが与えられます。積がk未満の連続部分配列の数を返してください。

**入力例:**

```text
nums = [10, 5, 2, 6], k = 100
```

**出力例:**

```text
8  # [10], [5], [2], [6], [10,5], [5,2], [2,6], [5,2,6]
```

### アルゴリズム概説

Sliding Window + Two Pointersを使用します。右ポインタを拡張し、積がk以上になったら左ポインタを縮小します。

**時間計算量:** O(n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 num_subarray_product_less_than_k(配列, k):
    もし k <= 1 なら:
        0 を返す
    
    カウント = 0
    積 = 1
    左 = 0
    
    各右について:
        積 *= 配列[右]
        
        積 >= k の間:
            積 /= 配列[左]
            左 += 1
        
        # [左, 右] の範囲で右を終端とする部分配列の数
        カウント += 右 - 左 + 1
    
    カウントを返す
```

### 解答

```ruby
# 解法1: Sliding Window
def num_subarray_product_less_than_k(nums, k)
  return 0 if k <= 1
  
  count = 0
  product = 1
  left = 0
  
  nums.each_with_index do |num, right|
    product *= num
    
    while product >= k
      product /= nums[left]
      left += 1
    end
    
    # [left, right] の範囲で right を終端とする部分配列の数
    count += right - left + 1
  end
  
  count
end

# 解法2: すべての部分配列を列挙
def find_all_subarray_product_less_than_k(nums, k)
  result = []
  
  nums.length.times do |i|
    product = 1
    
    (i...nums.length).each do |j|
      product *= nums[j]
      
      break if product >= k
      
      result << nums[i..j]
    end
  end
  
  result
end

# テストケース
p num_subarray_product_less_than_k([10, 5, 2, 6], 100)
# => 8

p num_subarray_product_less_than_k([1, 2, 3], 0)
# => 0

p find_all_subarray_product_less_than_k([10, 5, 2, 6], 100)
# => [[10], [5], [10, 5], [2], [5, 2], [6], [2, 6], [5, 2, 6]]
```

---

## 問題8: ソート済み配列のマージ

### 問題文

2つのソート済み配列 nums1 と nums2 が与えられます。nums1 の末尾には nums2 を格納するための十分な空きスペースがあります。2つの配列を nums1 にマージしてください。

**入力例:**

```text
nums1 = [1, 2, 3, 0, 0, 0], m = 3
nums2 = [2, 5, 6], n = 3
```

**出力例:**

```text
[1, 2, 2, 3, 5, 6]
```

### アルゴリズム概説

後ろから埋めていきます。2つの配列の末尾から比較し、大きい方を nums1 の末尾に配置します。

**時間計算量:** O(m + n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 merge(nums1, m, nums2, n):
    p1 = m - 1  # nums1の最後の要素
    p2 = n - 1  # nums2の最後の要素
    書き込み位置 = m + n - 1
    
    p2 >= 0 の間:
        もし p1 >= 0 かつ nums1[p1] > nums2[p2] なら:
            nums1[書き込み位置] = nums1[p1]
            p1 -= 1
        そうでなければ:
            nums1[書き込み位置] = nums2[p2]
            p2 -= 1
        
        書き込み位置 -= 1
```

### 解答

```ruby
# 解法1: 後ろから埋める
def merge(nums1, m, nums2, n)
  p1 = m - 1
  p2 = n - 1
  write_pos = m + n - 1
  
  while p2 >= 0
    if p1 >= 0 && nums1[p1] > nums2[p2]
      nums1[write_pos] = nums1[p1]
      p1 -= 1
    else
      nums1[write_pos] = nums2[p2]
      p2 -= 1
    end
    
    write_pos -= 1
  end
  
  nums1
end

# 解法2: 前から埋める（コピーが必要）
def merge_forward(nums1, m, nums2, n)
  nums1_copy = nums1[0...m].dup
  p1 = 0
  p2 = 0
  write_pos = 0
  
  while p1 < m && p2 < n
    if nums1_copy[p1] <= nums2[p2]
      nums1[write_pos] = nums1_copy[p1]
      p1 += 1
    else
      nums1[write_pos] = nums2[p2]
      p2 += 1
    end
    
    write_pos += 1
  end
  
  # 残りをコピー
  nums1[write_pos...(write_pos + m - p1)] = nums1_copy[p1...m] if p1 < m
  nums1[write_pos...(write_pos + n - p2)] = nums2[p2...n] if p2 < n
  
  nums1
end

# 解法3: Rubyの組み込みメソッドを使用
def merge_builtin(nums1, m, nums2, n)
  nums1[0...m].concat(nums2[0...n]).sort!
end

# テストケース
nums1 = [1, 2, 3, 0, 0, 0]
p merge(nums1, 3, [2, 5, 6], 3)
# => [1, 2, 2, 3, 5, 6]

nums2 = [1]
p merge(nums2, 1, [], 0)
# => [1]

nums3 = [0]
p merge(nums3, 0, [1], 1)
# => [1]
```

---

## まとめ

このセクションでは、Two Pointers テクニックとその応用を学びました。

重要なポイントは以下の通りです。

1. ソート済み配列では両端からのTwo Pointersが有効です
2. 回文判定など、対称性のある問題でよく使用されます
3. 配列のパーティションやマージでin-place操作が可能になります
4. Sliding Windowと組み合わせると部分配列の問題を効率的に解けます
5. 多くの場合、O(n²)の問題をO(n)に改善できます

Two Pointersは配列・文字列問題の基本的かつ強力なテクニックです。このパターンを理解することで、多くの問題を効率的に解決できるようになります。
