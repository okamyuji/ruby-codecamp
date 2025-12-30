# Ruby 3.4 初級者向け問題集 - Part 3: ハッシュ・集合

## 概要

このセクションでは、ハッシュ（連想配列）と集合（Set）の操作を学びます。これらのデータ構造は、データの高速な検索、重複の排除、データの関連付けなど、多くの場面で活用されます。

---

## 問題19: 2つの配列の共通要素

### 問題文

2つの整数配列が与えられます。両方の配列に含まれる共通の要素を返してください。結果には重複がないようにしてください。

**入力例:**

```text
nums1 = [1, 2, 2, 1]
nums2 = [2, 2]
```

**出力例:**

```text
[2]
```

### アルゴリズム概説

一方の配列をセットに変換し、もう一方の配列の各要素がセットに含まれるかを確認します。セットを使用することで、検索がO(1)で行えます。

**時間計算量:** O(n + m) - 両配列の長さの合計  
**空間計算量:** O(min(n, m)) - 小さい方の配列をセットにする

### 擬似コード

```text
関数 intersection(配列1, 配列2):
    セット1 = 配列1をセットに変換
    結果 = 空セット
    
    配列2の各要素について:
        もし要素がセット1に含まれるなら:
            結果に要素を追加
    
    結果を配列として返す
```

### 解答

```ruby
require 'set'

# 解法1: 集合演算を使用（推奨）
def intersection(nums1, nums2)
  # 配列をSetに変換して共通部分を計算
  set1 = nums1.to_set
  set2 = nums2.to_set
  
  # &演算子で共通部分を取得
  (set1 & set2).to_a
end

# 解法2: 配列の&演算子を使用
def intersection_array(nums1, nums2)
  # 配列の&演算子は共通要素を返す（重複なし）
  nums1 & nums2
end

# 解法3: selectとinclude?を使用
def intersection_select(nums1, nums2)
  set2 = nums2.to_set
  
  # nums1の要素でset2に含まれるものを選択
  nums1.uniq.select { |num| set2.include?(num) }
end

# 解法4: 手動でセットを構築
def intersection_manual(nums1, nums2)
  set1 = {}
  result = []
  
  # nums1の要素をハッシュに登録
  nums1.each { |num| set1[num] = true }
  
  # nums2の要素をチェック
  seen = {}
  nums2.each do |num|
    if set1[num] && !seen[num]
      result << num
      seen[num] = true
    end
  end
  
  result
end

# テストケース
p intersection([1, 2, 2, 1], [2, 2])           # => [2]
p intersection([4, 9, 5], [9, 4, 9, 8, 4])     # => [4, 9] または [9, 4]
p intersection([1, 2, 3], [4, 5, 6])           # => []
p intersection([], [1, 2])                      # => []
p intersection([1, 1, 1], [1, 1, 1])           # => [1]
```

---

## 問題20: 2つの数の合計（Two Sum）

### 問題文

整数の配列と目標値が与えられます。配列内の2つの数の合計が目標値になるインデックスのペアを返してください。同じ要素を2回使用することはできません。

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

ハッシュを使用して、各要素を走査しながら「目標値 - 現在の要素」がハッシュに存在するかを確認します。これにより、O(n)の時間計算量で解決できます。

**時間計算量:** O(n) - 配列を一度走査  
**空間計算量:** O(n) - ハッシュマップのサイズ

### 擬似コード

```text
関数 two_sum(配列, 目標値):
    マップ = 空ハッシュ  # 値 -> インデックス
    
    配列の各要素とインデックスについて:
        補数 = 目標値 - 要素
        
        もし補数がマップに存在するなら:
            [マップ[補数], インデックス]を返す
        
        マップ[要素] = インデックス
    
    nilを返す  # 見つからない場合
```

### 解答

```ruby
# 解法1: ハッシュマップを使用（推奨）
def two_sum(nums, target)
  # 値をキー、インデックスを値とするハッシュ
  num_to_index = {}
  
  nums.each_with_index do |num, index|
    # 目標値を達成するために必要な数（補数）
    complement = target - num
    
    # 補数が既にハッシュに存在すれば、答えを見つけた
    if num_to_index.key?(complement)
      return [num_to_index[complement], index]
    end
    
    # 現在の数とそのインデックスをハッシュに追加
    num_to_index[num] = index
  end
  
  nil  # 解が見つからない場合
end

# 解法2: ブルートフォース（参考）
def two_sum_brute_force(nums, target)
  # O(n^2)の時間計算量だが、シンプル
  (0...nums.length).each do |i|
    (i + 1...nums.length).each do |j|
      return [i, j] if nums[i] + nums[j] == target
    end
  end
  
  nil
end

# 解法3: 2パス方式
def two_sum_two_pass(nums, target)
  num_to_index = {}
  
  # 第1パス: ハッシュを構築
  nums.each_with_index { |num, index| num_to_index[num] = index }
  
  # 第2パス: 補数を探す
  nums.each_with_index do |num, index|
    complement = target - num
    
    # 補数が存在し、自分自身でない場合
    if num_to_index.key?(complement) && num_to_index[complement] != index
      return [index, num_to_index[complement]]
    end
  end
  
  nil
end

# テストケース
p two_sum([2, 7, 11, 15], 9)   # => [0, 1]
p two_sum([3, 2, 4], 6)        # => [1, 2]
p two_sum([3, 3], 6)           # => [0, 1]
p two_sum([1, 2, 3, 4], 10)    # => nil
```

---

## 問題21: 単語の出現頻度

### 問題文

単語の配列が与えられます。各単語の出現頻度をカウントし、頻度の高い順にk個の単語を返してください。同じ頻度の場合はアルファベット順に並べてください。

**入力例:**

```text
words = ["i", "love", "leetcode", "i", "love", "coding"]
k = 2
```

**出力例:**

```text
["i", "love"]
```

### アルゴリズム概説

まず各単語の出現回数をカウントし、次に頻度でソートします。同じ頻度の場合はアルファベット順にソートします。

**時間計算量:** O(n log n) - ソートのため  
**空間計算量:** O(n) - カウント用のハッシュ

### 擬似コード

```text
関数 top_k_frequent(単語配列, k):
    カウント = 各単語の出現回数をカウント
    
    ソート済み = カウントを以下の基準でソート:
        1. 頻度の降順
        2. 同じ頻度ならアルファベット順
    
    ソート済みの最初のk個を返す
```

### 解答

```ruby
# 解法1: tallyとsort_byを使用（推奨）
def top_k_frequent(words, k)
  # 各単語の出現回数をカウント
  count = words.tally
  
  # 頻度の降順、同頻度ならアルファベット順でソート
  sorted = count.sort_by { |word, freq| [-freq, word] }
  
  # 最初のk個の単語を返す
  sorted.first(k).map(&:first)
end

# 解法2: group_byを使用
def top_k_frequent_group_by(words, k)
  # 単語をグループ化してカウント
  count = words.group_by(&:itself).transform_values(&:count)
  
  # ソートして最初のk個を取得
  count.sort { |a, b|
    # 頻度が同じ場合はアルファベット順、そうでなければ頻度の降順
    if a[1] == b[1]
      a[0] <=> b[0]
    else
      b[1] <=> a[1]
    end
  }.first(k).map(&:first)
end

# 解法3: 手動でカウント
def top_k_frequent_manual(words, k)
  count = Hash.new(0)
  
  # 各単語をカウント
  words.each { |word| count[word] += 1 }
  
  # カスタムソート
  sorted = count.keys.sort do |a, b|
    if count[a] == count[b]
      a <=> b  # 同頻度ならアルファベット順
    else
      count[b] <=> count[a]  # 頻度の降順
    end
  end
  
  sorted.first(k)
end

# 解法4: max_byを使用
def top_k_frequent_max_by(words, k)
  count = words.tally
  
  result = []
  k.times do
    # 最大頻度の単語を見つける（同頻度ならアルファベット順で最小）
    max_word = count.keys.max_by { |word| [count[word], word.reverse] }
    result << max_word
    count.delete(max_word)
  end
  
  result
end

# テストケース
p top_k_frequent(["i", "love", "leetcode", "i", "love", "coding"], 2)
# => ["i", "love"]

p top_k_frequent(["the", "day", "is", "sunny", "the", "the", "the", "sunny", "is", "is"], 4)
# => ["the", "is", "sunny", "day"]

p top_k_frequent(["a", "b", "c"], 3)
# => ["a", "b", "c"]
```

---

## 問題22: 重複する要素の検出

### 問題文

整数の配列が与えられます。配列内に重複する要素があるかどうかを判定してください。

**入力例:**

```text
[1, 2, 3, 1]
```

**出力例:**

```text
true
```

### アルゴリズム概説

セットを使用して各要素を追跡し、既に見た要素に遭遇したら重複があると判定します。

**時間計算量:** O(n) - 配列を一度走査  
**空間計算量:** O(n) - セットのサイズ

### 擬似コード

```text
関数 contains_duplicate(配列):
    見た要素 = 空セット
    
    配列の各要素について:
        もし要素が見た要素に含まれるなら:
            trueを返す
        見た要素に要素を追加
    
    falseを返す
```

### 解答

```ruby
require 'set'

# 解法1: uniqで長さを比較（推奨）
def contains_duplicate(nums)
  # 重複がなければuniq後の長さは同じ
  nums.length != nums.uniq.length
end

# 解法2: セットを使用
def contains_duplicate_set(nums)
  seen = Set.new
  
  nums.each do |num|
    # 既に見た要素なら重複あり
    return true if seen.include?(num)
    
    seen.add(num)
  end
  
  false
end

# 解法3: ハッシュを使用
def contains_duplicate_hash(nums)
  seen = {}
  
  nums.each do |num|
    return true if seen[num]
    seen[num] = true
  end
  
  false
end

# 解法4: any?を使用
def contains_duplicate_any(nums)
  seen = Set.new
  
  nums.any? { |num| !seen.add?(num) }
end

# 解法5: tallyを使用
def contains_duplicate_tally(nums)
  nums.tally.values.any? { |count| count > 1 }
end

# テストケース
puts contains_duplicate([1, 2, 3, 1])    # => true
puts contains_duplicate([1, 2, 3, 4])    # => false
puts contains_duplicate([1, 1, 1, 3, 3]) # => true
puts contains_duplicate([])              # => false
puts contains_duplicate([1])             # => false
```

---

## 問題23: 同構造の文字列（Isomorphic Strings）

### 問題文

2つの文字列sとtが与えられます。sの各文字を一貫したルールで別の文字に置き換えてtを作れるかどうかを判定してください。2つの文字が同じ文字にマッピングされることはありません。

**入力例:**

```text
s = "egg"
t = "add"
```

**出力例:**

```text
true  # e -> a, g -> d
```

### アルゴリズム概説

2つのハッシュマップを使用して、sからtへのマッピングとtからsへのマッピングを追跡します。矛盾が発生したらfalseを返します。

**時間計算量:** O(n) - 文字列の長さ  
**空間計算量:** O(k) - kはユニークな文字数

### 擬似コード

```text
関数 isomorphic?(s, t):
    もしsの長さ != tの長さなら:
        falseを返す
    
    マップ_s_to_t = 空ハッシュ
    マップ_t_to_s = 空ハッシュ
    
    各インデックスについて:
        char_s = s[インデックス]
        char_t = t[インデックス]
        
        もしマップ_s_to_tにchar_sが存在するなら:
            もしマップ_s_to_t[char_s] != char_t なら:
                falseを返す
        そうでなければ:
            もしマップ_t_to_sにchar_tが存在するなら:
                falseを返す
            マップ_s_to_t[char_s] = char_t
            マップ_t_to_s[char_t] = char_s
    
    trueを返す
```

### 解答

```ruby
# 解法1: 双方向マッピングを使用（推奨）
def isomorphic?(s, t)
  return false if s.length != t.length
  
  # sからtへのマッピング
  s_to_t = {}
  # tからsへのマッピング
  t_to_s = {}
  
  s.chars.each_with_index do |char_s, i|
    char_t = t[i]
    
    if s_to_t.key?(char_s)
      # 既存のマッピングと矛盾がないかチェック
      return false if s_to_t[char_s] != char_t
    else
      # 新しいマッピングを作成する前に、tの文字が既に使われていないかチェック
      return false if t_to_s.key?(char_t)
      
      s_to_t[char_s] = char_t
      t_to_s[char_t] = char_s
    end
  end
  
  true
end

# 解法2: パターンを比較
def isomorphic_pattern?(s, t)
  return false if s.length != t.length
  
  # 各文字列のパターンを生成
  # 例: "egg" -> [0, 1, 1], "add" -> [0, 1, 1]
  pattern_s = generate_pattern(s)
  pattern_t = generate_pattern(t)
  
  pattern_s == pattern_t
end

def generate_pattern(str)
  char_to_index = {}
  pattern = []
  
  str.each_char do |char|
    unless char_to_index.key?(char)
      char_to_index[char] = char_to_index.size
    end
    pattern << char_to_index[char]
  end
  
  pattern
end

# 解法3: zipを使用
def isomorphic_zip?(s, t)
  return false if s.length != t.length
  
  s_to_t = {}
  t_to_s = {}
  
  s.chars.zip(t.chars).each do |char_s, char_t|
    s_to_t[char_s] ||= char_t
    t_to_s[char_t] ||= char_s
    
    return false if s_to_t[char_s] != char_t || t_to_s[char_t] != char_s
  end
  
  true
end

# テストケース
puts isomorphic?("egg", "add")      # => true
puts isomorphic?("foo", "bar")      # => false
puts isomorphic?("paper", "title")  # => true
puts isomorphic?("ab", "aa")        # => false
puts isomorphic?("", "")            # => true
```

---

## 問題24: グループアナグラム

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

各文字列をソートしたものをキーとしてハッシュにグループ化します。アナグラムはソートすると同じ文字列になるため、この方法で効率的にグループ化できます。

**時間計算量:** O(n × k log k) - nは文字列数、kは最長文字列の長さ  
**空間計算量:** O(n × k) - 結果を格納するため

### 擬似コード

```text
関数 group_anagrams(文字列配列):
    グループ = 空ハッシュ（デフォルト値は空配列）
    
    文字列配列の各文字列について:
        キー = 文字列をソートしたもの
        グループ[キー]に文字列を追加
    
    グループの値を返す
```

### 解答

```ruby
# 解法1: ソートをキーとして使用（推奨）
def group_anagrams(strs)
  # デフォルト値として空配列を持つハッシュ
  groups = Hash.new { |hash, key| hash[key] = [] }
  
  strs.each do |str|
    # ソートした文字列をキーとして使用
    key = str.chars.sort.join
    groups[key] << str
  end
  
  groups.values
end

# 解法2: group_byを使用
def group_anagrams_group_by(strs)
  strs.group_by { |str| str.chars.sort.join }.values
end

# 解法3: 文字カウントをキーとして使用
def group_anagrams_count(strs)
  groups = Hash.new { |hash, key| hash[key] = [] }
  
  strs.each do |str|
    # 文字カウントをキーとして使用（ソートより効率的な場合あり）
    count = Array.new(26, 0)
    str.each_char { |char| count[char.ord - 'a'.ord] += 1 }
    key = count.join(',')
    groups[key] << str
  end
  
  groups.values
end

# 解法4: tallyをキーとして使用
def group_anagrams_tally(strs)
  groups = Hash.new { |hash, key| hash[key] = [] }
  
  strs.each do |str|
    # tallyの結果をソートしてキーにする
    key = str.chars.tally.sort.to_s
    groups[key] << str
  end
  
  groups.values
end

# テストケース
p group_anagrams(["eat", "tea", "tan", "ate", "nat", "bat"])
# => [["eat", "tea", "ate"], ["tan", "nat"], ["bat"]] （順序は異なる可能性あり）

p group_anagrams([""])
# => [[""]]

p group_anagrams(["a"])
# => [["a"]]
```

---

## 問題25: 近くの重複要素（Contains Nearby Duplicate）

### 問題文

整数の配列とkが与えられます。配列内で、異なるインデックスi, jについてnums[i] == nums[j]かつ|i - j| <= kを満たすペアが存在するかを判定してください。

**入力例:**

```text
nums = [1, 2, 3, 1]
k = 3
```

**出力例:**

```text
true  # nums[0] == nums[3] かつ |0 - 3| = 3 <= 3
```

### アルゴリズム概説

ハッシュを使用して、各値の最後に出現したインデックスを追跡します。同じ値に再び遭遇したら、インデックスの差がk以下かを確認します。

**時間計算量:** O(n) - 配列を一度走査  
**空間計算量:** O(min(n, k)) - ハッシュのサイズ

### 擬似コード

```text
関数 contains_nearby_duplicate(配列, k):
    最後のインデックス = 空ハッシュ  # 値 -> 最後に出現したインデックス
    
    配列の各要素とインデックスについて:
        もし最後のインデックスに要素が存在するなら:
            差 = インデックス - 最後のインデックス[要素]
            もし差 <= k なら:
                trueを返す
        
        最後のインデックス[要素] = インデックス
    
    falseを返す
```

### 解答

```ruby
require 'set'

# 解法1: ハッシュで最後のインデックスを追跡（推奨）
def contains_nearby_duplicate(nums, k)
  # 値をキー、最後に出現したインデックスを値とするハッシュ
  last_index = {}
  
  nums.each_with_index do |num, index|
    if last_index.key?(num)
      # 同じ値が見つかったら、インデックスの差を確認
      return true if index - last_index[num] <= k
    end
    
    # 最後に出現したインデックスを更新
    last_index[num] = index
  end
  
  false
end

# 解法2: スライディングウィンドウとセットを使用
def contains_nearby_duplicate_window(nums, k)
  # サイズkのウィンドウ内の要素を追跡
  window = Set.new
  
  nums.each_with_index do |num, index|
    # ウィンドウがkを超えたら、最も古い要素を削除
    window.delete(nums[index - k - 1]) if index > k
    
    # 既にウィンドウ内に存在すれば重複
    return true unless window.add?(num)
  end
  
  false
end

# 解法3: すべてのインデックスを記録
def contains_nearby_duplicate_all_indices(nums, k)
  indices = Hash.new { |h, k| h[k] = [] }
  
  nums.each_with_index { |num, i| indices[num] << i }
  
  indices.values.any? do |idx_list|
    idx_list.each_cons(2).any? { |i, j| j - i <= k }
  end
end

# テストケース
puts contains_nearby_duplicate([1, 2, 3, 1], 3)         # => true
puts contains_nearby_duplicate([1, 0, 1, 1], 1)         # => true
puts contains_nearby_duplicate([1, 2, 3, 1, 2, 3], 2)   # => false
puts contains_nearby_duplicate([], 0)                   # => false
puts contains_nearby_duplicate([1], 1)                  # => false
```

---

## 問題26: 配列の差分

### 問題文

2つの整数配列nums1とnums2が与えられます。以下の2つの配列を返してください。

1. nums1には含まれるがnums2には含まれない要素
2. nums2には含まれるがnums1には含まれない要素

**入力例:**

```text
nums1 = [1, 2, 3]
nums2 = [2, 4, 6]
```

**出力例:**

```text
[[1, 3], [4, 6]]
```

### アルゴリズム概説

各配列をセットに変換し、差集合演算を使用して差分を求めます。

**時間計算量:** O(n + m) - 両配列の長さの合計  
**空間計算量:** O(n + m) - セットのサイズ

### 擬似コード

```text
関数 find_difference(配列1, 配列2):
    セット1 = 配列1をセットに変換
    セット2 = 配列2をセットに変換
    
    差分1 = セット1 - セット2  # 配列1のみに含まれる
    差分2 = セット2 - セット1  # 配列2のみに含まれる
    
    [差分1の配列, 差分2の配列]を返す
```

### 解答

```ruby
require 'set'

# 解法1: セットの差集合演算を使用（推奨）
def find_difference(nums1, nums2)
  set1 = nums1.to_set
  set2 = nums2.to_set
  
  # -演算子で差集合を計算
  [
    (set1 - set2).to_a,
    (set2 - set1).to_a
  ]
end

# 解法2: 配列の-演算子を使用
def find_difference_array(nums1, nums2)
  # 配列の-演算子も差集合を計算（重複は除去される）
  [
    (nums1 - nums2).uniq,
    (nums2 - nums1).uniq
  ]
end

# 解法3: selectを使用
def find_difference_select(nums1, nums2)
  set1 = nums1.to_set
  set2 = nums2.to_set
  
  [
    nums1.uniq.select { |n| !set2.include?(n) },
    nums2.uniq.select { |n| !set1.include?(n) }
  ]
end

# 解法4: 手動で実装
def find_difference_manual(nums1, nums2)
  in_nums1 = {}
  in_nums2 = {}
  
  nums1.each { |n| in_nums1[n] = true }
  nums2.each { |n| in_nums2[n] = true }
  
  diff1 = []
  diff2 = []
  
  in_nums1.each_key { |n| diff1 << n unless in_nums2[n] }
  in_nums2.each_key { |n| diff2 << n unless in_nums1[n] }
  
  [diff1, diff2]
end

# テストケース
p find_difference([1, 2, 3], [2, 4, 6])
# => [[1, 3], [4, 6]] または [[3, 1], [6, 4]]

p find_difference([1, 2, 3, 3], [1, 1, 2, 2])
# => [[3], []]

p find_difference([], [1, 2])
# => [[], [1, 2]]
```

---

## まとめ

このセクションでは、ハッシュと集合の操作を8問を通じて学びました。

**学んだ主なメソッド:**

- `to_set` - 配列をセットに変換
- `&`, `-` - 集合演算（共通部分、差集合）
- `tally` - 出現回数のカウント
- `group_by` - グループ化
- `transform_values` - ハッシュの値を変換
- `Hash.new(0)` - デフォルト値を持つハッシュ
- `include?`, `key?` - 存在確認

**重要なポイント:**

1. ハッシュはO(1)の平均検索時間を提供
2. セットは重複を自動的に排除
3. 適切なデータ構造の選択で計算量を大幅に改善できる
4. 双方向のマッピングが必要な場合は2つのハッシュを使用
5. `tally`と`group_by`はカウントやグループ化に非常に便利
