# 配列と文字列 - 応用（Sliding Window）

## 概要

このセクションでは、Sliding Window（スライディングウィンドウ）テクニックを学びます。このテクニックは、連続する部分配列や部分文字列の問題を効率的に解決するために使用されます。ウィンドウを拡張・縮小しながら最適解を見つけます。

---

## 問題1: 固定サイズのウィンドウの最大合計

### 問題文

整数の配列とサイズkが与えられます。サイズkの連続する部分配列の最大合計を返してください。

**入力例:**

```text
nums = [2, 1, 5, 1, 3, 2], k = 3
```

**出力例:**

```text
9  # [5, 1, 3]
```

### アルゴリズム概説

最初のk個の要素の合計を計算し、その後ウィンドウをスライドさせながら左端を引いて右端を足します。

**時間計算量:** O(n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 max_sum_subarray(配列, k):
    # 最初のウィンドウの合計
    ウィンドウ合計 = 配列の最初のk個の合計
    最大合計 = ウィンドウ合計
    
    各インデックスi（kから開始）について:
        # 左端を除き、右端を追加
        ウィンドウ合計 = ウィンドウ合計 - 配列[i - k] + 配列[i]
        最大合計 = max(最大合計, ウィンドウ合計)
    
    最大合計を返す
```

### 解答

```ruby
# 解法1: Sliding Window
def max_sum_subarray(nums, k)
  return 0 if nums.length < k
  
  # 最初のウィンドウの合計
  window_sum = nums[0...k].sum
  max_sum = window_sum
  
  # ウィンドウをスライド
  (k...nums.length).each do |i|
    window_sum = window_sum - nums[i - k] + nums[i]
    max_sum = [max_sum, window_sum].max
  end
  
  max_sum
end

# 解法2: インデックスも返す
def max_sum_subarray_with_index(nums, k)
  return { sum: 0, start: 0, end: 0 } if nums.length < k
  
  window_sum = nums[0...k].sum
  max_sum = window_sum
  max_start = 0
  
  (k...nums.length).each do |i|
    window_sum = window_sum - nums[i - k] + nums[i]
    
    if window_sum > max_sum
      max_sum = window_sum
      max_start = i - k + 1
    end
  end
  
  { sum: max_sum, start: max_start, end: max_start + k - 1 }
end

# 解法3: ブルートフォース（比較用）
def max_sum_subarray_brute(nums, k)
  return 0 if nums.length < k
  
  max_sum = -Float::INFINITY
  
  (nums.length - k + 1).times do |i|
    current_sum = nums[i, k].sum
    max_sum = [max_sum, current_sum].max
  end
  
  max_sum
end

# テストケース
p max_sum_subarray([2, 1, 5, 1, 3, 2], 3)  # => 9
p max_sum_subarray([2, 3, 4, 1, 5], 2)     # => 7
p max_sum_subarray([1, 4, 2, 10, 23, 3, 1, 0, 20], 4)  # => 39

p max_sum_subarray_with_index([2, 1, 5, 1, 3, 2], 3)
# => { sum: 9, start: 2, end: 4 }
```

---

## 問題2: 最長の部分文字列（k個のユニーク文字）

### 問題文

文字列が与えられます。ちょうどk個のユニークな文字を含む最長の部分文字列の長さを返してください。

**入力例:**

```text
s = "eceba", k = 2
```

**出力例:**

```text
3  # "ece"
```

### アルゴリズム概説

可変長Sliding Windowを使用します。ウィンドウ内のユニーク文字数がkより大きくなったら左端を縮小します。

**時間計算量:** O(n)  
**空間計算量:** O(k)

### 擬似コード

```text
関数 longest_substring_k_unique(文字列, k):
    文字カウント = ハッシュ
    最大長 = 0
    左 = 0
    
    各右について:
        # 右端の文字を追加
        文字カウント[文字列[右]] += 1
        
        # ユニーク文字数がkを超えたら左端を縮小
        文字カウントのサイズ > k の間:
            文字カウント[文字列[左]] -= 1
            もし 文字カウント[文字列[左]] == 0 なら:
                文字カウントから削除
            左 += 1
        
        # ユニーク文字数がちょうどkなら長さを更新
        もし 文字カウントのサイズ == k なら:
            最大長 = max(最大長, 右 - 左 + 1)
    
    最大長を返す
```

### 解答

```ruby
# 解法1: Sliding Window with Hash
def longest_substring_k_unique(s, k)
  return 0 if s.empty? || k.zero?
  
  char_count = Hash.new(0)
  max_len = 0
  left = 0
  
  s.each_char.with_index do |char, right|
    char_count[char] += 1
    
    # ユニーク文字数がkを超えたら縮小
    while char_count.size > k
      char_count[s[left]] -= 1
      char_count.delete(s[left]) if char_count[s[left]].zero?
      left += 1
    end
    
    # ちょうどk個のユニーク文字
    max_len = [max_len, right - left + 1].max if char_count.size == k
  end
  
  max_len
end

# 解法2: 部分文字列も返す
def longest_substring_k_unique_with_string(s, k)
  return '' if s.empty? || k.zero?
  
  char_count = Hash.new(0)
  max_len = 0
  max_start = 0
  left = 0
  
  s.each_char.with_index do |char, right|
    char_count[char] += 1
    
    while char_count.size > k
      char_count[s[left]] -= 1
      char_count.delete(s[left]) if char_count[s[left]].zero?
      left += 1
    end
    
    if char_count.size == k && right - left + 1 > max_len
      max_len = right - left + 1
      max_start = left
    end
  end
  
  s[max_start, max_len]
end

# テストケース
p longest_substring_k_unique("eceba", 2)  # => 3 ("ece")
p longest_substring_k_unique("aa", 1)     # => 2 ("aa")
p longest_substring_k_unique("abcba", 2)  # => 3 ("bcb")

p longest_substring_k_unique_with_string("eceba", 2)  # => "ece"
```

---

## 問題3: 繰り返しのない最長部分文字列

### 問題文

文字列が与えられます。繰り返し文字のない最長の部分文字列の長さを返してください。

**入力例:**

```text
"abcabcbb"
```

**出力例:**

```text
3  # "abc"
```

### アルゴリズム概説

ハッシュマップで各文字の最後の出現位置を記録します。重複が見つかったら左端をその位置の次に移動します。

**時間計算量:** O(n)  
**空間計算量:** O(min(n, m)) - mはアルファベットのサイズ

### 擬似コード

```text
関数 length_of_longest_substring(文字列):
    文字位置 = ハッシュ
    最大長 = 0
    左 = 0
    
    各右について:
        文字 = 文字列[右]
        
        # 文字が既にウィンドウ内にあれば左を移動
        もし 文字 が 文字位置 にある かつ 文字位置[文字] >= 左 なら:
            左 = 文字位置[文字] + 1
        
        文字位置[文字] = 右
        最大長 = max(最大長, 右 - 左 + 1)
    
    最大長を返す
```

### 解答

```ruby
# 解法1: ハッシュマップで位置を記録
def length_of_longest_substring(s)
  char_index = {}
  max_len = 0
  left = 0
  
  s.each_char.with_index do |char, right|
    # 文字が既にウィンドウ内にある
    if char_index.key?(char) && char_index[char] >= left
      left = char_index[char] + 1
    end
    
    char_index[char] = right
    max_len = [max_len, right - left + 1].max
  end
  
  max_len
end

# 解法2: セットを使用
def length_of_longest_substring_set(s)
  char_set = Set.new
  max_len = 0
  left = 0
  
  s.each_char.with_index do |char, right|
    # 重複文字を削除
    while char_set.include?(char)
      char_set.delete(s[left])
      left += 1
    end
    
    char_set << char
    max_len = [max_len, right - left + 1].max
  end
  
  max_len
end

# 解法3: 部分文字列も返す
def longest_substring_no_repeat_with_string(s)
  char_index = {}
  max_len = 0
  max_start = 0
  left = 0
  
  s.each_char.with_index do |char, right|
    if char_index.key?(char) && char_index[char] >= left
      left = char_index[char] + 1
    end
    
    char_index[char] = right
    
    if right - left + 1 > max_len
      max_len = right - left + 1
      max_start = left
    end
  end
  
  s[max_start, max_len]
end

# テストケース
p length_of_longest_substring("abcabcbb")  # => 3 ("abc")
p length_of_longest_substring("bbbbb")     # => 1 ("b")
p length_of_longest_substring("pwwkew")    # => 3 ("wke")
p length_of_longest_substring("")          # => 0

p longest_substring_no_repeat_with_string("abcabcbb")  # => "abc"
```

---

## 問題4: 最小ウィンドウ部分文字列

### 問題文

2つの文字列sとtが与えられます。sの中で、tのすべての文字を含む最小のウィンドウ（部分文字列）を返してください。

**入力例:**

```text
s = "ADOBECODEBANC", t = "ABC"
```

**出力例:**

```text
"BANC"
```

### アルゴリズム概説

2つのハッシュマップを使用します。1つはtの文字をカウント、もう1つは現在のウィンドウの文字をカウントします。

**時間計算量:** O(m + n) - mとnはsとtの長さ  
**空間計算量:** O(m + n)

### 擬似コード

```text
関数 min_window(s, t):
    もし s が空 または t が空 なら:
        "" を返す
    
    t_count = tの各文字の出現回数
    window_count = ハッシュ
    必要文字数 = t_countのサイズ
    満たした文字数 = 0
    
    左 = 0
    最小長 = 無限大
    最小開始位置 = 0
    
    各右について:
        文字 = s[右]
        window_count[文字] += 1
        
        もし 文字 が t_count にある かつ window_count[文字] == t_count[文字] なら:
            満たした文字数 += 1
        
        # すべての文字を満たしたらウィンドウを縮小
        満たした文字数 == 必要文字数 の間:
            # ウィンドウを更新
            もし 右 - 左 + 1 < 最小長 なら:
                最小長 = 右 - 左 + 1
                最小開始位置 = 左
            
            # 左端を縮小
            左文字 = s[左]
            window_count[左文字] -= 1
            
            もし 左文字 が t_count にある かつ window_count[左文字] < t_count[左文字] なら:
                満たした文字数 -= 1
            
            左 += 1
    
    最小長 == 無限大 ? "" : s[最小開始位置, 最小長]
```

### 解答

```ruby
# 解法1: Sliding Window with Hash
def min_window(s, t)
  return "" if s.empty? || t.empty?
  
  t_count = Hash.new(0)
  t.each_char { |char| t_count[char] += 1 }
  
  window_count = Hash.new(0)
  required = t_count.size
  formed = 0
  
  left = 0
  min_len = Float::INFINITY
  min_start = 0
  
  s.each_char.with_index do |char, right|
    window_count[char] += 1
    
    if t_count.key?(char) && window_count[char] == t_count[char]
      formed += 1
    end
    
    # すべての文字を満たしたらウィンドウを縮小
    while formed == required && left <= right
      # ウィンドウを更新
      if right - left + 1 < min_len
        min_len = right - left + 1
        min_start = left
      end
      
      # 左端を縮小
      left_char = s[left]
      window_count[left_char] -= 1
      
      if t_count.key?(left_char) && window_count[left_char] < t_count[left_char]
        formed -= 1
      end
      
      left += 1
    end
  end
  
  min_len == Float::INFINITY ? "" : s[min_start, min_len]
end

# 解法2: 最適化版（tに含まれる文字のみを処理）
def min_window_optimized(s, t)
  return "" if s.empty? || t.empty?
  
  t_count = Hash.new(0)
  t.each_char { |char| t_count[char] += 1 }
  
  # tに含まれる文字のインデックスのみを記録
  filtered = []
  s.each_char.with_index do |char, i|
    filtered << [i, char] if t_count.key?(char)
  end
  
  window_count = Hash.new(0)
  required = t_count.size
  formed = 0
  
  left = 0
  min_len = Float::INFINITY
  min_start = 0
  
  filtered.each_with_index do |(right_idx, char), right|
    window_count[char] += 1
    
    formed += 1 if window_count[char] == t_count[char]
    
    while formed == required && left <= right
      left_idx, left_char = filtered[left]
      
      if right_idx - left_idx + 1 < min_len
        min_len = right_idx - left_idx + 1
        min_start = left_idx
      end
      
      window_count[left_char] -= 1
      formed -= 1 if window_count[left_char] < t_count[left_char]
      
      left += 1
    end
  end
  
  min_len == Float::INFINITY ? "" : s[min_start, min_len]
end

# テストケース
p min_window("ADOBECODEBANC", "ABC")  # => "BANC"
p min_window("a", "a")                # => "a"
p min_window("a", "aa")               # => ""
```

---

## 問題5: 最大連続1（k回の反転許可）

### 問題文

0と1のみからなる配列が与えられます。最大k個の0を1に反転できるとき、最も長い連続する1の列の長さを返してください。

**入力例:**

```text
nums = [1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0], k = 2
```

**出力例:**

```text
6  # [1, 1, 1, 0, 0, 1, 1, 1, 1, 1]（0を2つ反転）
```

### アルゴリズム概説

Sliding Windowを使用します。ウィンドウ内の0の数がkを超えたら左端を縮小します。

**時間計算量:** O(n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 longest_ones(配列, k):
    左 = 0
    ゼロカウント = 0
    最大長 = 0
    
    各右について:
        もし 配列[右] == 0 なら:
            ゼロカウント += 1
        
        # ゼロが多すぎたら左を縮小
        ゼロカウント > k の間:
            もし 配列[左] == 0 なら:
                ゼロカウント -= 1
            左 += 1
        
        最大長 = max(最大長, 右 - 左 + 1)
    
    最大長を返す
```

### 解答

```ruby
# 解法1: Sliding Window
def longest_ones(nums, k)
  left = 0
  zero_count = 0
  max_len = 0
  
  nums.each_with_index do |num, right|
    zero_count += 1 if num.zero?
    
    # ゼロが多すぎたら左を縮小
    while zero_count > k
      zero_count -= 1 if nums[left].zero?
      left += 1
    end
    
    max_len = [max_len, right - left + 1].max
  end
  
  max_len
end

# 解法2: インデックスも返す
def longest_ones_with_indices(nums, k)
  left = 0
  zero_count = 0
  max_len = 0
  max_start = 0
  
  nums.each_with_index do |num, right|
    zero_count += 1 if num.zero?
    
    while zero_count > k
      zero_count -= 1 if nums[left].zero?
      left += 1
    end
    
    if right - left + 1 > max_len
      max_len = right - left + 1
      max_start = left
    end
  end
  
  { length: max_len, start: max_start, end: max_start + max_len - 1 }
end

# テストケース
p longest_ones([1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0], 2)  # => 6
p longest_ones([0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1], 3)  # => 10

p longest_ones_with_indices([1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0], 2)
# => { length: 6, start: 3, end: 8 }
```

---

## 問題6: アナグラムの検索

### 問題文

文字列sとpが与えられます。sの中でpのアナグラムである部分文字列のすべての開始インデックスを返してください。

**入力例:**

```text
s = "cbaebabacd", p = "abc"
```

**出力例:**

```text
[0, 6]  # "cba"と"bac"
```

### アルゴリズム概説

固定サイズのSliding Windowとハッシュマップを使用します。ウィンドウ内の文字の出現回数がpと一致するかチェックします。

**時間計算量:** O(n) - nはsの長さ  
**空間計算量:** O(1) - アルファベットのサイズは定数

### 擬似コード

```text
関数 find_anagrams(s, p):
    p_count = pの各文字の出現回数
    window_count = ハッシュ
    結果 = 空配列
    
    各右について:
        # 右端を追加
        window_count[s[右]] += 1
        
        # ウィンドウサイズがpより大きくなったら左端を削除
        もし 右 >= p.length なら:
            左文字 = s[右 - p.length]
            window_count[左文字] -= 1
            もし window_count[左文字] == 0 なら:
                window_countから削除
        
        # アナグラムかチェック
        もし window_count == p_count なら:
            結果に 右 - p.length + 1 を追加
    
    結果を返す
```

### 解答

```ruby
# 解法1: Sliding Window with Hash
def find_anagrams(s, p)
  return [] if s.length < p.length
  
  p_count = Hash.new(0)
  p.each_char { |char| p_count[char] += 1 }
  
  window_count = Hash.new(0)
  result = []
  
  s.each_char.with_index do |char, right|
    window_count[char] += 1
    
    # ウィンドウサイズがpより大きくなったら左端を削除
    if right >= p.length
      left_char = s[right - p.length]
      window_count[left_char] -= 1
      window_count.delete(left_char) if window_count[left_char].zero?
    end
    
    # アナグラムかチェック
    result << right - p.length + 1 if window_count == p_count
  end
  
  result
end

# 解法2: カウンターで効率化
def find_anagrams_counter(s, p)
  return [] if s.length < p.length
  
  p_count = Hash.new(0)
  p.each_char { |char| p_count[char] += 1 }
  
  window_count = Hash.new(0)
  result = []
  matches = 0
  
  s.each_char.with_index do |char, right|
    # 右端を追加
    if p_count.key?(char)
      window_count[char] += 1
      matches += 1 if window_count[char] == p_count[char]
    end
    
    # ウィンドウサイズがpより大きくなったら左端を削除
    if right >= p.length
      left_char = s[right - p.length]
      
      if p_count.key?(left_char)
        matches -= 1 if window_count[left_char] == p_count[left_char]
        window_count[left_char] -= 1
      end
    end
    
    # すべての文字が一致
    result << right - p.length + 1 if matches == p_count.size
  end
  
  result
end

# テストケース
p find_anagrams("cbaebabacd", "abc")  # => [0, 6]
p find_anagrams("abab", "ab")         # => [0, 1, 2]
p find_anagrams("baa", "aa")          # => [1]
```

---

## 問題7: 最長の繰り返し文字置換

### 問題文

文字列sと整数kが与えられます。最大k個の文字を任意の文字に置換できるとき、同じ文字からなる最長の部分文字列の長さを返してください。

**入力例:**

```text
s = "AABABBA", k = 1
```

**出力例:**

```text
4  # "AABA"（Bを1つAに置換）
```

### アルゴリズム概説

Sliding Windowを使用します。ウィンドウ内の最頻出文字以外の文字数がk以下になるようにウィンドウを維持します。

**時間計算量:** O(n)  
**空間計算量:** O(1) - アルファベットのサイズは定数

### 擬似コード

```text
関数 character_replacement(s, k):
    文字カウント = ハッシュ
    左 = 0
    最大カウント = 0
    最大長 = 0
    
    各右について:
        文字カウント[s[右]] += 1
        最大カウント = max(最大カウント, 文字カウント[s[右]])
        
        # ウィンドウ長 - 最頻出文字数 > k なら縮小
        (右 - 左 + 1) - 最大カウント > k の間:
            文字カウント[s[左]] -= 1
            左 += 1
        
        最大長 = max(最大長, 右 - 左 + 1)
    
    最大長を返す
```

### 解答

```ruby
# 解法1: Sliding Window
def character_replacement(s, k)
  char_count = Hash.new(0)
  left = 0
  max_count = 0
  max_len = 0
  
  s.each_char.with_index do |char, right|
    char_count[char] += 1
    max_count = [max_count, char_count[char]].max
    
    # ウィンドウ長 - 最頻出文字数 > k なら縮小
    while (right - left + 1) - max_count > k
      char_count[s[left]] -= 1
      left += 1
    end
    
    max_len = [max_len, right - left + 1].max
  end
  
  max_len
end

# 解法2: 部分文字列も返す
def character_replacement_with_string(s, k)
  char_count = Hash.new(0)
  left = 0
  max_count = 0
  max_len = 0
  max_start = 0
  
  s.each_char.with_index do |char, right|
    char_count[char] += 1
    max_count = [max_count, char_count[char]].max
    
    while (right - left + 1) - max_count > k
      char_count[s[left]] -= 1
      left += 1
    end
    
    if right - left + 1 > max_len
      max_len = right - left + 1
      max_start = left
    end
  end
  
  s[max_start, max_len]
end

# テストケース
p character_replacement("ABAB", 2)      # => 4
p character_replacement("AABABBA", 1)   # => 4
p character_replacement("AAAA", 2)      # => 4

p character_replacement_with_string("AABABBA", 1)  # => "AABA"
```

---

## 問題8: 果物をバスケットに入れる

### 問題文

各要素が果物の種類を表す配列が与えられます。2種類の果物のみを収集できるとき、連続して収集できる最大の果物の数を返してください。

**入力例:**

```text
[1, 2, 1, 2, 3, 2, 2]
```

**出力例:**

```text
5  # [2, 1, 2, 3] または [3, 2, 2, 2]（ただし3, 2, 2, 2が正解）
```

### アルゴリズム概説

最大2種類のユニークな要素を持つ最長部分配列を見つけます。これは「k個のユニーク要素」問題でk=2の場合です。

**時間計算量:** O(n)  
**空間計算量:** O(1)

### 擬似コード

```text
関数 total_fruit(果物配列):
    果物カウント = ハッシュ
    左 = 0
    最大果物数 = 0
    
    各右について:
        果物カウント[果物配列[右]] += 1
        
        # 果物の種類が2を超えたら左を縮小
        果物カウントのサイズ > 2 の間:
            果物カウント[果物配列[左]] -= 1
            もし 果物カウント[果物配列[左]] == 0 なら:
                果物カウントから削除
            左 += 1
        
        最大果物数 = max(最大果物数, 右 - 左 + 1)
    
    最大果物数を返す
```

### 解答

```ruby
# 解法1: Sliding Window
def total_fruit(fruits)
  fruit_count = Hash.new(0)
  left = 0
  max_fruits = 0
  
  fruits.each_with_index do |fruit, right|
    fruit_count[fruit] += 1
    
    # 果物の種類が2を超えたら左を縮小
    while fruit_count.size > 2
      fruit_count[fruits[left]] -= 1
      fruit_count.delete(fruits[left]) if fruit_count[fruits[left]].zero?
      left += 1
    end
    
    max_fruits = [max_fruits, right - left + 1].max
  end
  
  max_fruits
end

# 解法2: インデックスも返す
def total_fruit_with_range(fruits)
  fruit_count = Hash.new(0)
  left = 0
  max_fruits = 0
  max_start = 0
  
  fruits.each_with_index do |fruit, right|
    fruit_count[fruit] += 1
    
    while fruit_count.size > 2
      fruit_count[fruits[left]] -= 1
      fruit_count.delete(fruits[left]) if fruit_count[fruits[left]].zero?
      left += 1
    end
    
    if right - left + 1 > max_fruits
      max_fruits = right - left + 1
      max_start = left
    end
  end
  
  { count: max_fruits, start: max_start, end: max_start + max_fruits - 1 }
end

# テストケース
p total_fruit([1, 2, 1])            # => 3
p total_fruit([0, 1, 2, 2])         # => 3
p total_fruit([1, 2, 3, 2, 2])      # => 4
p total_fruit([3, 3, 3, 1, 2, 1, 1, 2, 3, 3, 4])  # => 5

p total_fruit_with_range([1, 2, 3, 2, 2])
# => { count: 4, start: 1, end: 4 }
```

---

## まとめ

このセクションでは、Sliding Window テクニックとその応用を学びました。

重要なポイントは以下の通りです。

1. 固定サイズのウィンドウは単純で効率的です
2. 可変サイズのウィンドウは条件を満たすまで拡張・縮小します
3. ハッシュマップで文字や要素の出現回数を追跡します
4. 多くの部分配列・部分文字列問題をO(n)で解けます
5. ウィンドウの縮小条件を正しく設定することが重要です

Sliding Windowは連続する要素の問題で非常に強力なテクニックです。このパターンを理解することで、多くの実践的な問題を効率的に解決できるようになります。
