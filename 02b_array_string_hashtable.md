# 配列と文字列 - 基礎（ハッシュテーブル）

## 概要

このセクションでは、ハッシュテーブルを活用した配列と文字列の問題を学びます。ハッシュテーブルはO(1)の平均時間で要素の挿入、削除、検索ができるため、多くのアルゴリズム問題で非常に有用です。

---

## 問題1: 文字の出現回数をカウント

### 問題文

文字列が与えられます。各文字が何回出現するかをカウントして、ハッシュとして返してください。

**入力例:**

```text
"hello"
```

**出力例:**

```text
{"h"=>1, "e"=>1, "l"=>2, "o"=>1}
```

### アルゴリズム概説

文字列を1文字ずつ走査し、ハッシュに各文字の出現回数を記録します。Hash.new(0)を使用すると、デフォルト値が0のハッシュを作成できます。

**時間計算量:** O(n) - 文字列の長さに比例  
**空間計算量:** O(k) - kは一意な文字の数

### 擬似コード

```text
関数 character_frequency(文字列):
    頻度 = 空ハッシュ（デフォルト値0）
    
    文字列の各文字について:
        頻度[文字] += 1
    
    頻度を返す
```

### 解答

```ruby
# 解法1: Hash.new(0)を使用
def character_frequency(str)
  freq = Hash.new(0)
  
  str.each_char do |char|
    freq[char] += 1
  end
  
  freq
end

# 解法2: tallyメソッド（Ruby 2.7+、推奨）
def character_frequency_tally(str)
  str.chars.tally
end

# 解法3: group_byとmapを使用
def character_frequency_group_by(str)
  str.chars.group_by(&:itself).transform_values(&:count)
end

# 解法4: reduceを使用
def character_frequency_reduce(str)
  str.each_char.reduce(Hash.new(0)) do |freq, char|
    freq[char] += 1
    freq
  end
end

# テストケース
p character_frequency("hello")
# => {"h"=>1, "e"=>1, "l"=>2, "o"=>1}

p character_frequency("mississippi")
# => {"m"=>1, "i"=>4, "s"=>4, "p"=>2}

p character_frequency("")
# => {}

p character_frequency("aaa")
# => {"a"=>3}
```

---

## 問題2: 最初の重複しない文字を見つける

### 問題文

文字列が与えられます。最初に出現する重複しない文字を返してください。存在しない場合はnilを返します。

**入力例:**

```text
"leetcode"
```

**出力例:**

```text
"l"
```

### アルゴリズム概説

まず各文字の出現回数をカウントします。その後、文字列を順番に走査して、出現回数が1の最初の文字を返します。

**時間計算量:** O(n) - 文字列を2回走査  
**空間計算量:** O(k) - kは一意な文字の数

### 擬似コード

```text
関数 first_unique_char(文字列):
    頻度 = 各文字の出現回数をカウント
    
    文字列の各文字について:
        もし 頻度[文字] == 1 なら:
            文字を返す
    
    nilを返す
```

### 解答

```ruby
# 解法1: 2パス（頻度カウント + 検索）
def first_unique_char(str)
  freq = Hash.new(0)
  
  # 1パス目: 頻度をカウント
  str.each_char { |char| freq[char] += 1 }
  
  # 2パス目: 最初の一意な文字を見つける
  str.each_char do |char|
    return char if freq[char] == 1
  end
  
  nil
end

# 解法2: インデックスを返す版
def first_unique_char_index(str)
  freq = str.chars.tally
  
  str.each_char.with_index do |char, i|
    return i if freq[char] == 1
  end
  
  -1
end

# 解法3: tallyを使った簡潔版
def first_unique_char_tally(str)
  freq = str.chars.tally
  str.chars.find { |char| freq[char] == 1 }
end

# テストケース
p first_unique_char("leetcode")         # => "l"
p first_unique_char("loveleetcode")     # => "v"
p first_unique_char("aabb")             # => nil
p first_unique_char("z")                # => "z"

p first_unique_char_index("leetcode")   # => 0
p first_unique_char_index("loveleetcode") # => 2
```

---

## 問題3: アナグラムの判定

### 問題文

2つの文字列が与えられます。それらがアナグラム（文字の並び替えで一致する）であるかを判定してください。

**入力例:**

```text
s = "anagram"
t = "nagaram"
```

**出力例:**

```text
true
```

### アルゴリズム概説

両方の文字列の文字頻度をカウントし、それらが一致するかを確認します。または、ソートして比較することもできます。

**時間計算量:** O(n) - ハッシュ版、O(n log n) - ソート版  
**空間計算量:** O(k) - kは一意な文字の数

### 擬似コード

```text
関数 is_anagram(文字列1, 文字列2):
    もし 長さが異なるなら:
        falseを返す
    
    頻度1 = 文字列1の文字頻度
    頻度2 = 文字列2の文字頻度
    
    頻度1 == 頻度2 を返す
```

### 解答

```ruby
# 解法1: 文字頻度を比較（推奨）
def is_anagram(s, t)
  return false if s.length != t.length
  
  freq_s = s.chars.tally
  freq_t = t.chars.tally
  
  freq_s == freq_t
end

# 解法2: ソートして比較
def is_anagram_sort(s, t)
  s.chars.sort == t.chars.sort
end

# 解法3: 1つのハッシュでカウント
def is_anagram_one_hash(s, t)
  return false if s.length != t.length
  
  freq = Hash.new(0)
  
  # sの文字をカウント
  s.each_char { |char| freq[char] += 1 }
  
  # tの文字を減らす
  t.each_char { |char| freq[char] -= 1 }
  
  # すべての値が0なら、アナグラム
  freq.values.all?(&:zero?)
end

# テストケース
p is_anagram("anagram", "nagaram")      # => true
p is_anagram("rat", "car")              # => false
p is_anagram("listen", "silent")        # => true
p is_anagram("hello", "world")          # => false
```

---

## 問題4: アナグラムのグループ化

### 問題文

文字列の配列が与えられます。アナグラム同士をグループ化してください。

**入力例:**

```text
["eat", "tea", "tan", "ate", "nat", "bat"]
```

**出力例:**

```text
[["eat", "tea", "ate"], ["tan", "nat"], ["bat"]]
```

### アルゴリズム概説

各文字列をソート（またはハッシュキーに変換）し、それをキーとしてハッシュにグループ化します。同じキーを持つ文字列はアナグラムです。

**時間計算量:** O(n × k log k) - nは文字列の数、kは文字列の平均長  
**空間計算量:** O(n × k)

### 擬似コード

```text
関数 group_anagrams(文字列配列):
    グループ = 空ハッシュ
    
    各文字列について:
        キー = 文字列をソート（または文字頻度のハッシュ）
        グループ[キー]に文字列を追加
    
    グループの値を配列として返す
```

### 解答

```ruby
# 解法1: ソートをキーにする（推奨）
def group_anagrams(strs)
  groups = Hash.new { |h, k| h[k] = [] }
  
  strs.each do |str|
    # ソートした文字列をキーとする
    key = str.chars.sort.join
    groups[key] << str
  end
  
  groups.values
end

# 解法2: 文字頻度をキーにする
def group_anagrams_frequency(strs)
  groups = Hash.new { |h, k| h[k] = [] }
  
  strs.each do |str|
    # 文字頻度の配列をキーとする（a-zの26文字）
    freq = Array.new(26, 0)
    str.each_char { |char| freq[char.ord - 'a'.ord] += 1 }
    groups[freq] << str
  end
  
  groups.values
end

# 解法3: group_byを使用
def group_anagrams_group_by(strs)
  strs.group_by { |str| str.chars.sort }.values
end

# テストケース
p group_anagrams(["eat", "tea", "tan", "ate", "nat", "bat"])
# => [["eat", "tea", "ate"], ["tan", "nat"], ["bat"]]

p group_anagrams([""])
# => [[""]]

p group_anagrams(["a"])
# => [["a"]]
```

---

## 問題5: 部分配列の和が目標値と一致

### 問題文

整数の配列と目標値が与えられます。連続する部分配列の和が目標値と一致する部分配列が存在するかを判定してください。

**入力例:**

```text
nums = [1, 2, 3, 7, 5]
target = 12
```

**出力例:**

```text
true  # [3, 7] の和が10、[7, 5]の和が12
```

### アルゴリズム概説

累積和とハッシュテーブルを使用します。各位置での累積和を計算し、「現在の累積和 - 目標値」がハッシュに存在すれば、その間の部分配列の和が目標値になります。

**時間計算量:** O(n)  
**空間計算量:** O(n)

### 擬似コード

```text
関数 subarray_sum(配列, 目標値):
    累積和 = 0
    seen = {0}  # 累積和0を初期状態として追加
    
    配列の各要素について:
        累積和 += 要素
        
        もし (累積和 - 目標値) が seen に存在するなら:
            trueを返す
        
        seen に累積和を追加
    
    falseを返す
```

### 解答

```ruby
# 解法1: 累積和とハッシュセット
def subarray_sum_exists(nums, target)
  sum = 0
  seen = Set.new([0])  # 累積和0を初期状態
  
  nums.each do |num|
    sum += num
    
    # sum - target が存在すれば、その間の和がtarget
    return true if seen.include?(sum - target)
    
    seen.add(sum)
  end
  
  false
end

# 解法2: インデックスを返す版
def subarray_sum_indices(nums, target)
  sum = 0
  sum_indices = { 0 => -1 }  # 累積和 => インデックス
  
  nums.each_with_index do |num, i|
    sum += num
    
    if sum_indices.key?(sum - target)
      # 部分配列のインデックス範囲を返す
      start_idx = sum_indices[sum - target] + 1
      return [start_idx, i]
    end
    
    sum_indices[sum] = i
  end
  
  nil
end

# 解法3: 二重ループ（O(n²)、効率悪い）
def subarray_sum_brute_force(nums, target)
  (0...nums.length).each do |i|
    sum = 0
    (i...nums.length).each do |j|
      sum += nums[j]
      return true if sum == target
    end
  end
  
  false
end

# テストケース
p subarray_sum_exists([1, 2, 3, 7, 5], 12)   # => true ([7, 5])
p subarray_sum_exists([1, 2, 3, 4], 100)     # => false
p subarray_sum_exists([1, -1, 0], 0)         # => true (多くの組み合わせ)

p subarray_sum_indices([1, 2, 3, 7, 5], 12)  # => [3, 4] ([7, 5])
p subarray_sum_indices([1, 2, 3, 4], 6)      # => [1, 2] ([2, 3])
```

---

## 問題6: 2つの配列の積集合

### 問題文

2つの整数配列が与えられます。両方の配列に含まれる要素（積集合）を重複を含めて返してください。

**入力例:**

```text
nums1 = [1, 2, 2, 1]
nums2 = [2, 2]
```

**出力例:**

```text
[2, 2]
```

### アルゴリズム概説

一方の配列の要素とその出現回数をハッシュに記録し、もう一方の配列を走査してハッシュから要素を取り出します。

**時間計算量:** O(n + m)  
**空間計算量:** O(min(n, m))

### 擬似コード

```text
関数 intersect(配列1, 配列2):
    頻度 = 配列1の要素の出現回数
    結果 = 空配列
    
    配列2の各要素について:
        もし 頻度[要素] > 0 なら:
            結果に要素を追加
            頻度[要素] -= 1
    
    結果を返す
```

### 解答

```ruby
# 解法1: ハッシュで頻度管理（推奨）
def intersect(nums1, nums2)
  freq = Hash.new(0)
  result = []
  
  # nums1の頻度をカウント
  nums1.each { |num| freq[num] += 1 }
  
  # nums2を走査して共通要素を探す
  nums2.each do |num|
    if freq[num] > 0
      result << num
      freq[num] -= 1
    end
  end
  
  result
end

# 解法2: 両方をソートして2ポインタ
def intersect_sorted(nums1, nums2)
  nums1.sort!
  nums2.sort!
  
  result = []
  i = j = 0
  
  while i < nums1.length && j < nums2.length
    if nums1[i] == nums2[j]
      result << nums1[i]
      i += 1
      j += 1
    elsif nums1[i] < nums2[j]
      i += 1
    else
      j += 1
    end
  end
  
  result
end

# 解法3: tallyを使用
def intersect_tally(nums1, nums2)
  freq1 = nums1.tally
  result = []
  
  nums2.each do |num|
    if freq1[num] && freq1[num] > 0
      result << num
      freq1[num] -= 1
    end
  end
  
  result
end

# テストケース
p intersect([1, 2, 2, 1], [2, 2])           # => [2, 2]
p intersect([4, 9, 5], [9, 4, 9, 8, 4])     # => [4, 9] or [9, 4]
p intersect([1, 2, 3], [4, 5, 6])           # => []
```

---

## 問題7: 最長の連続する数列

### 問題文

ソートされていない整数配列が与えられます。最長の連続する数列の長さを求めてください。

**入力例:**

```text
[100, 4, 200, 1, 3, 2]
```

**出力例:**

```text
4  # [1, 2, 3, 4]
```

### アルゴリズム概説

配列をセットに変換し、各数について、その数が連続数列の開始点かどうかを確認します。開始点の場合、連続する数がいくつあるかをカウントします。

**時間計算量:** O(n)  
**空間計算量:** O(n)

### 擬似コード

```text
関数 longest_consecutive(配列):
    数セット = 配列をセットに変換
    最長 = 0
    
    セットの各数について:
        もし 数-1 がセットに存在しないなら:  # 連続数列の開始点
            現在の数 = 数
            現在の長さ = 1
            
            現在の数+1 がセットに存在する間:
                現在の数 += 1
                現在の長さ += 1
            
            最長 = max(最長, 現在の長さ)
    
    最長を返す
```

### 解答

```ruby
# 解法1: セットを使用（O(n)、推奨）
def longest_consecutive(nums)
  return 0 if nums.empty?
  
  num_set = nums.to_set
  longest = 0
  
  num_set.each do |num|
    # num - 1が存在しない場合のみ、連続数列の開始点
    next if num_set.include?(num - 1)
    
    current_num = num
    current_length = 1
    
    # 連続する数をカウント
    while num_set.include?(current_num + 1)
      current_num += 1
      current_length += 1
    end
    
    longest = [longest, current_length].max
  end
  
  longest
end

# 解法2: ソートして探索（O(n log n)）
def longest_consecutive_sort(nums)
  return 0 if nums.empty?
  
  sorted = nums.uniq.sort
  longest = 1
  current_length = 1
  
  (1...sorted.length).each do |i|
    if sorted[i] == sorted[i - 1] + 1
      current_length += 1
      longest = [longest, current_length].max
    else
      current_length = 1
    end
  end
  
  longest
end

# テストケース
p longest_consecutive([100, 4, 200, 1, 3, 2])  # => 4 ([1,2,3,4])
p longest_consecutive([0, 3, 7, 2, 5, 8, 4, 6, 0, 1])  # => 9 ([0-8])
p longest_consecutive([])                       # => 0
p longest_consecutive([1])                      # => 1
```

---

## 問題8: 同型文字列の判定

### 問題文

2つの文字列が与えられます。それらが同型（各文字が別の文字に1対1で対応する）であるかを判定してください。

**入力例:**

```text
s = "egg"
t = "add"
```

**出力例:**

```text
true  # e->a, g->d
```

### アルゴリズム概説

2つのハッシュマップを使用して、両方向のマッピングを確認します。s[i]がt[i]に対応し、t[i]がs[i]に対応することを確認します。

**時間計算量:** O(n)  
**空間計算量:** O(k) - kは一意な文字の数

### 擬似コード

```text
関数 is_isomorphic(文字列s, 文字列t):
    もし 長さが異なるなら:
        falseを返す
    
    s_to_t = 空ハッシュ
    t_to_s = 空ハッシュ
    
    各インデックスiについて:
        char_s = s[i]
        char_t = t[i]
        
        もし s_to_t[char_s] が存在し、!= char_t なら:
            falseを返す
        もし t_to_s[char_t] が存在し、!= char_s なら:
            falseを返す
        
        s_to_t[char_s] = char_t
        t_to_s[char_t] = char_s
    
    trueを返す
```

### 解答

```ruby
# 解法1: 2つのハッシュマップ（推奨）
def is_isomorphic(s, t)
  return false if s.length != t.length
  
  s_to_t = {}
  t_to_s = {}
  
  s.length.times do |i|
    char_s = s[i]
    char_t = t[i]
    
    # sからtへのマッピングをチェック
    if s_to_t.key?(char_s)
      return false if s_to_t[char_s] != char_t
    else
      s_to_t[char_s] = char_t
    end
    
    # tからsへのマッピングをチェック
    if t_to_s.key?(char_t)
      return false if t_to_s[char_t] != char_s
    else
      t_to_s[char_t] = char_s
    end
  end
  
  true
end

# 解法2: 変換パターンを比較
def is_isomorphic_pattern(s, t)
  return false if s.length != t.length
  
  # 各文字列を数値パターンに変換
  pattern_s = create_pattern(s)
  pattern_t = create_pattern(t)
  
  pattern_s == pattern_t
end

def create_pattern(str)
  char_to_index = {}
  next_index = 0
  pattern = []
  
  str.each_char do |char|
    unless char_to_index.key?(char)
      char_to_index[char] = next_index
      next_index += 1
    end
    pattern << char_to_index[char]
  end
  
  pattern
end

# テストケース
p is_isomorphic("egg", "add")      # => true
p is_isomorphic("foo", "bar")      # => false
p is_isomorphic("paper", "title")  # => true
p is_isomorphic("ab", "aa")        # => false
```

---

## まとめ

このセクションでは、ハッシュテーブルを活用した配列と文字列の問題を学びました。

重要なポイントは以下の通りです。

1. ハッシュテーブルはO(1)の平均時間で要素にアクセスできます
2. 頻度カウント、重複検出、マッピングなど多くの用途があります
3. Hash.new(0)やtallyメソッドを活用すると便利です
4. 累積和とハッシュを組み合わせると強力です
5. セットは要素の存在確認に便利です

ハッシュテーブルは、アルゴリズムの計算量を劇的に改善できる強力なデータ構造です。多くの問題でO(n²)からO(n)に改善できます。
