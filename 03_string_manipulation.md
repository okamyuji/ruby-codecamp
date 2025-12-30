# Ruby 3.4 初級者向け問題集 - Part 2: 文字列操作

## 概要

このセクションでは、文字列の基本的な操作を学びます。文字列処理はテキストデータを扱うあらゆるプログラムで必要不可欠なスキルです。

---

## 問題11: 文字列の反転

### 問題文

文字列が与えられます。文字の順序を反転した新しい文字列を返してください。

**入力例:**

```text
"hello"
```

**出力例:**

```text
"olleh"
```

### アルゴリズム概説

文字列を末尾から先頭に向かって読み取り、新しい文字列を構築します。または両端からスワップする方法もあります。

**時間計算量:** O(n) - 文字列の長さに比例  
**空間計算量:** O(n) - 新しい文字列を作成

### 擬似コード

```text
関数 reverse_string(文字列):
    結果 = 空文字列
    インデックス = 文字列の長さ - 1
    
    インデックス >= 0 の間:
        結果 += 文字列[インデックス]
        インデックス -= 1
    
    結果を返す
```

### 解答

```ruby
# 解法1: reverseメソッドを使用（推奨）
def reverse_string(str)
  str.reverse
end

# 解法2: 手動で逆順に構築
def reverse_string_manual(str)
  result = ""
  
  # 最後の文字から最初の文字まで逆順にイテレート
  (str.length - 1).downto(0) do |i|
    result += str[i]
  end
  
  result
end

# 解法3: 配列に変換して反転
def reverse_string_array(str)
  # 文字列を文字の配列に変換し、反転して結合
  str.chars.reverse.join
end

# 解法4: reduceを使用
def reverse_string_reduce(str)
  # 各文字を逆順に結合
  str.chars.reduce("") { |acc, char| char + acc }
end

# テストケース
puts reverse_string("hello")      # => "olleh"
puts reverse_string("Ruby")       # => "ybuR"
puts reverse_string("a")          # => "a"
puts reverse_string("")           # => ""
puts reverse_string("12345")      # => "54321"
```

---

## 問題12: 回文判定

### 問題文

文字列が与えられます。その文字列が回文（前から読んでも後ろから読んでも同じ）かどうかを判定してください。大文字小文字は区別しないものとします。

**入力例:**

```text
"RaceCar"
```

**出力例:**

```text
true
```

### アルゴリズム概説

文字列を小文字に変換し、反転した文字列と比較します。または、両端から中央に向かって文字を比較する方法もあります。

**時間計算量:** O(n) - 文字列の長さに比例  
**空間計算量:** O(n) - 反転した文字列を作成する場合

### 擬似コード

```text
関数 is_palindrome(文字列):
    正規化 = 文字列を小文字に変換
    反転 = 正規化を反転
    
    正規化 == 反転 を返す
```

### 解答

```ruby
# 解法1: reverseで比較（推奨）
def palindrome?(str)
  # 大文字小文字を統一して比較
  normalized = str.downcase
  normalized == normalized.reverse
end

# 解法2: 2ポインタ法（空間効率が良い）
def palindrome_two_pointer?(str)
  normalized = str.downcase
  left = 0
  right = normalized.length - 1
  
  while left < right
    # 両端の文字が一致しない場合は回文ではない
    return false if normalized[left] != normalized[right]
    
    left += 1
    right -= 1
  end
  
  true
end

# 解法3: 英数字のみを対象（より厳密な実装）
def palindrome_alphanumeric?(str)
  # 英数字以外を除去し、小文字に変換
  cleaned = str.downcase.gsub(/[^a-z0-9]/, '')
  cleaned == cleaned.reverse
end

# 解法4: 再帰的な実装
def palindrome_recursive?(str, left = 0, right = str.length - 1)
  normalized = str.downcase
  
  # ベースケース: ポインタが交差したら回文
  return true if left >= right
  
  # 両端が一致しなければ回文ではない
  return false if normalized[left] != normalized[right]
  
  # 内側に移動して再帰
  palindrome_recursive?(str, left + 1, right - 1)
end

# テストケース
puts palindrome?("RaceCar")      # => true
puts palindrome?("hello")        # => false
puts palindrome?("A")            # => true
puts palindrome?("")             # => true
puts palindrome?("Was it a car or a cat I saw".gsub(' ', ''))  # => true
```

---

## 問題13: 文字の出現回数をカウント

### 問題文

文字列が与えられます。各文字の出現回数をハッシュとして返してください。

**入力例:**

```text
"hello"
```

**出力例:**

```text
{"h"=>1, "e"=>1, "l"=>2, "o"=>1}
```

### アルゴリズム概説

文字列を走査し、各文字をキーとしてハッシュにカウントを記録します。

**時間計算量:** O(n) - 文字列の長さに比例  
**空間計算量:** O(k) - kはユニークな文字数

### 擬似コード

```text
関数 count_chars(文字列):
    カウント = 空ハッシュ
    
    文字列の各文字について:
        もしカウント[文字]が存在するなら:
            カウント[文字] += 1
        そうでなければ:
            カウント[文字] = 1
    
    カウントを返す
```

### 解答

```ruby
# 解法1: tallyメソッドを使用（Ruby 2.7+、推奨）
def count_chars(str)
  # charsで文字配列に変換し、tallyでカウント
  str.chars.tally
end

# 解法2: each_with_objectを使用
def count_chars_each_with_object(str)
  str.chars.each_with_object(Hash.new(0)) do |char, hash|
    hash[char] += 1
  end
end

# 解法3: 手動でカウント
def count_chars_manual(str)
  count = {}
  
  str.each_char do |char|
    if count.key?(char)
      count[char] += 1
    else
      count[char] = 1
    end
  end
  
  count
end

# 解法4: group_byを使用
def count_chars_group_by(str)
  str.chars.group_by(&:itself).transform_values(&:count)
end

# 解法5: デフォルト値を持つハッシュ
def count_chars_default_hash(str)
  count = Hash.new(0)  # デフォルト値を0に設定
  
  str.each_char { |char| count[char] += 1 }
  
  count
end

# テストケース
p count_chars("hello")      # => {"h"=>1, "e"=>1, "l"=>2, "o"=>1}
p count_chars("aaa")        # => {"a"=>3}
p count_chars("abc")        # => {"a"=>1, "b"=>1, "c"=>1}
p count_chars("")           # => {}
p count_chars("AaBb")       # => {"A"=>1, "a"=>1, "B"=>1, "b"=>1}
```

---

## 問題14: アナグラム判定

### 問題文

2つの文字列が与えられます。一方の文字列の文字を並べ替えて他方の文字列を作れるかどうか（アナグラムかどうか）を判定してください。大文字小文字は区別しません。

**入力例:**

```text
"listen", "silent"
```

**出力例:**

```text
true
```

### アルゴリズム概説

両方の文字列をソートして比較するか、各文字の出現回数をカウントして比較します。

**時間計算量:** O(n log n) - ソートの場合、O(n) - カウントの場合  
**空間計算量:** O(n) - ソートした文字列またはハッシュ

### 擬似コード

```text
関数 anagram?(文字列1, 文字列2):
    # 方法1: ソートして比較
    ソート済み1 = 文字列1を小文字にしてソート
    ソート済み2 = 文字列2を小文字にしてソート
    
    ソート済み1 == ソート済み2 を返す
```

### 解答

```ruby
# 解法1: ソートして比較（シンプル）
def anagram?(str1, str2)
  # 大文字小文字を統一し、文字をソートして比較
  str1.downcase.chars.sort == str2.downcase.chars.sort
end

# 解法2: 文字カウントを比較（効率的）
def anagram_count?(str1, str2)
  # 長さが異なれば即座にfalse
  return false if str1.length != str2.length
  
  # 各文字の出現回数を比較
  str1.downcase.chars.tally == str2.downcase.chars.tally
end

# 解法3: 手動で文字カウント
def anagram_manual?(str1, str2)
  return false if str1.length != str2.length
  
  count = Hash.new(0)
  
  # str1の文字をカウントアップ
  str1.downcase.each_char { |char| count[char] += 1 }
  
  # str2の文字をカウントダウン
  str2.downcase.each_char { |char| count[char] -= 1 }
  
  # すべてのカウントが0なら、アナグラム
  count.values.all?(&:zero?)
end

# 解法4: スペースと記号を無視
def anagram_clean?(str1, str2)
  # 英字のみを抽出して比較
  clean1 = str1.downcase.gsub(/[^a-z]/, '').chars.sort
  clean2 = str2.downcase.gsub(/[^a-z]/, '').chars.sort
  
  clean1 == clean2
end

# テストケース
puts anagram?("listen", "silent")      # => true
puts anagram?("hello", "world")        # => false
puts anagram?("Dormitory", "dirty room".delete(' '))  # => true
puts anagram?("a", "a")                # => true
puts anagram?("ab", "ba")              # => true
puts anagram?("abc", "ab")             # => false
```

---

## 問題15: 最初の非重複文字を見つける

### 問題文

文字列が与えられます。最初に1回だけ出現する文字のインデックスを返してください。そのような文字がない場合は-1を返してください。

**入力例:**

```text
"leetcode"
```

**出力例:**

```text
0  # 'l'が最初の非重複文字
```

### アルゴリズム概説

まず各文字の出現回数をカウントし、次に文字列を再度走査して出現回数が1の最初の文字を見つけます。

**時間計算量:** O(n) - 文字列を2回走査  
**空間計算量:** O(k) - kはユニークな文字数

### 擬似コード

```text
関数 first_unique_char(文字列):
    カウント = 各文字の出現回数をカウント
    
    文字列の各文字とインデックスについて:
        もしカウント[文字] == 1なら:
            インデックスを返す
    
    -1を返す
```

### 解答

```ruby
# 解法1: tallyを使用（推奨）
def first_unique_char(str)
  # 文字の出現回数をカウント
  count = str.chars.tally
  
  # 最初の出現回数1の文字のインデックスを返す
  str.chars.each_with_index do |char, index|
    return index if count[char] == 1
  end
  
  -1  # 見つからない場合
end

# 解法2: find_indexを使用
def first_unique_char_find(str)
  count = str.chars.tally
  
  # find_indexは条件を満たす最初の要素のインデックスを返す
  str.chars.find_index { |char| count[char] == 1 } || -1
end

# 解法3: 2回のループで手動実装
def first_unique_char_manual(str)
  count = Hash.new(0)
  
  # 1回目のループ: カウント
  str.each_char { |char| count[char] += 1 }
  
  # 2回目のループ: 最初の非重複文字を探す
  str.each_char.with_index do |char, index|
    return index if count[char] == 1
  end
  
  -1
end

# 解法4: indexとrindexを比較
def first_unique_char_index(str)
  str.chars.each_with_index do |char, index|
    # 最初と最後の出現位置が同じなら、1回だけ出現
    return index if str.index(char) == str.rindex(char)
  end
  
  -1
end

# テストケース
puts first_unique_char("leetcode")     # => 0 ('l')
puts first_unique_char("loveleetcode") # => 2 ('v')
puts first_unique_char("aabb")         # => -1
puts first_unique_char("z")            # => 0
puts first_unique_char("")             # => -1
```

---

## 問題16: 文字列の圧縮

### 問題文

文字列が与えられます。連続する同じ文字をその文字と連続回数で置き換えて圧縮してください。圧縮後の文字列が元の文字列より短くならない場合は、元の文字列を返してください。

**入力例:**

```text
"aabcccccaaa"
```

**出力例:**

```text
"a2b1c5a3"
```

### アルゴリズム概説

文字列を走査しながら、連続する同じ文字のグループをカウントし、文字と回数を結合して新しい文字列を構築します。

**時間計算量:** O(n) - 文字列を一度走査  
**空間計算量:** O(n) - 圧縮後の文字列

### 擬似コード

```text
関数 compress_string(文字列):
    もし文字列が空なら:
        空文字列を返す
    
    結果 = ""
    現在の文字 = 文字列[0]
    カウント = 1
    
    インデックス1から文字列の長さまで:
        もし文字列[インデックス] == 現在の文字なら:
            カウント += 1
        そうでなければ:
            結果 += 現在の文字 + カウントを文字列に変換
            現在の文字 = 文字列[インデックス]
            カウント = 1
    
    結果 += 現在の文字 + カウントを文字列に変換
    
    結果の長さ < 文字列の長さ ? 結果 : 文字列
```

### 解答

```ruby
# 解法1: ループで実装（推奨）
def compress_string(str)
  return str if str.empty?
  
  result = ""
  current_char = str[0]
  count = 1
  
  # 2文字目から走査
  (1...str.length).each do |i|
    if str[i] == current_char
      # 同じ文字が続いている
      count += 1
    else
      # 異なる文字に遭遇
      result += "#{current_char}#{count}"
      current_char = str[i]
      count = 1
    end
  end
  
  # 最後のグループを追加
  result += "#{current_char}#{count}"
  
  # 圧縮が効果的な場合のみ圧縮結果を返す
  result.length < str.length ? result : str
end

# 解法2: chunk_whileを使用
def compress_string_chunk(str)
  return str if str.empty?
  
  # 連続する同じ文字をグループ化
  groups = str.chars.chunk_while { |a, b| a == b }
  
  # 各グループを文字と長さに変換
  result = groups.map { |group| "#{group[0]}#{group.length}" }.join
  
  result.length < str.length ? result : str
end

# 解法3: 正規表現を使用
def compress_string_regex(str)
  return str if str.empty?
  
  # 連続する同じ文字にマッチ
  result = str.gsub(/(.)\1*/) { |match| "#{match[0]}#{match.length}" }
  
  result.length < str.length ? result : str
end

# 解法4: each_cons的アプローチ
def compress_string_functional(str)
  return str if str.empty?
  
  result = []
  char = str[0]
  count = 0
  
  str.each_char do |c|
    if c == char
      count += 1
    else
      result << "#{char}#{count}"
      char = c
      count = 1
    end
  end
  
  result << "#{char}#{count}"
  compressed = result.join
  
  compressed.length < str.length ? compressed : str
end

# テストケース
puts compress_string("aabcccccaaa")  # => "a2b1c5a3"
puts compress_string("abc")          # => "abc" (圧縮しても短くならない)
puts compress_string("aaa")          # => "a3"
puts compress_string("")             # => ""
puts compress_string("a")            # => "a"
```

---

## 問題17: 最長の共通接頭辞

### 問題文

文字列の配列が与えられます。すべての文字列に共通する最長の接頭辞（プレフィックス）を返してください。共通の接頭辞がない場合は空文字列を返してください。

**入力例:**

```text
["flower", "flow", "flight"]
```

**出力例:**

```text
"fl"
```

### アルゴリズム概説

最初の文字列を基準として、各位置の文字がすべての文字列で一致するかを確認します。一致しなくなった時点で、そこまでの文字列が最長共通接頭辞です。

**時間計算量:** O(S) - Sはすべての文字列の合計文字数  
**空間計算量:** O(1) - 追加のメモリは定数量

### 擬似コード

```text
関数 longest_common_prefix(文字列配列):
    もし配列が空なら:
        空文字列を返す
    
    基準 = 配列[0]
    
    基準の各インデックスについて:
        配列の各文字列について:
            もしインデックス >= 文字列の長さ または
               文字列[インデックス] != 基準[インデックス] なら:
                基準の0からインデックス-1までを返す
    
    基準を返す
```

### 解答

```ruby
# 解法1: 垂直走査（推奨）
def longest_common_prefix(strs)
  return "" if strs.empty?
  
  # 最初の文字列を基準にする
  prefix = strs[0]
  
  prefix.chars.each_with_index do |char, index|
    # 他のすべての文字列でこの位置の文字を確認
    strs[1..].each do |str|
      # 文字列が短いか、文字が一致しない場合
      if index >= str.length || str[index] != char
        return prefix[0...index]
      end
    end
  end
  
  prefix
end

# 解法2: ソートを利用
def longest_common_prefix_sort(strs)
  return "" if strs.empty?
  
  # ソートすると、最初と最後の文字列の共通接頭辞が全体の共通接頭辞
  sorted = strs.sort
  first = sorted.first
  last = sorted.last
  
  index = 0
  while index < first.length && index < last.length && first[index] == last[index]
    index += 1
  end
  
  first[0...index]
end

# 解法3: reduceを使用
def longest_common_prefix_reduce(strs)
  return "" if strs.empty?
  
  strs.reduce do |prefix, str|
    # prefixとstrの共通接頭辞を計算
    i = 0
    while i < prefix.length && i < str.length && prefix[i] == str[i]
      i += 1
    end
    prefix[0...i]
  end
end

# 解法4: 分割統治法
def longest_common_prefix_divide(strs)
  return "" if strs.empty?
  
  divide_and_conquer(strs, 0, strs.length - 1)
end

def divide_and_conquer(strs, left, right)
  if left == right
    strs[left]
  else
    mid = (left + right) / 2
    lcp_left = divide_and_conquer(strs, left, mid)
    lcp_right = divide_and_conquer(strs, mid + 1, right)
    common_prefix(lcp_left, lcp_right)
  end
end

def common_prefix(str1, str2)
  min_len = [str1.length, str2.length].min
  i = 0
  while i < min_len && str1[i] == str2[i]
    i += 1
  end
  str1[0...i]
end

# テストケース
puts longest_common_prefix(["flower", "flow", "flight"])  # => "fl"
puts longest_common_prefix(["dog", "racecar", "car"])     # => ""
puts longest_common_prefix(["abc"])                       # => "abc"
puts longest_common_prefix([])                            # => ""
puts longest_common_prefix(["", "abc"])                   # => ""
puts longest_common_prefix(["abc", "abc", "abc"])         # => "abc"
```

---

## 問題18: 単語の反転

### 問題文

文字列が与えられます。文字列内の単語の順序を反転してください。単語間の空白は1つに正規化してください。

**入力例:**

```text
"  hello   world  "
```

**出力例:**

```text
"world hello"
```

### アルゴリズム概説

文字列を空白で分割して単語の配列を作成し、配列を反転して再度結合します。

**時間計算量:** O(n) - 文字列の長さに比例  
**空間計算量:** O(n) - 単語を格納する配列

### 擬似コード

```text
関数 reverse_words(文字列):
    単語配列 = 文字列を空白で分割（空の要素を除外）
    反転配列 = 単語配列を反転
    反転配列を空白1つで結合して返す
```

### 解答

```ruby
# 解法1: split, reverse, joinを使用（推奨）
def reverse_words(str)
  # splitは連続する空白も処理し、空文字列を除外
  str.split.reverse.join(" ")
end

# 解法2: 正規表現で分割
def reverse_words_regex(str)
  # 1つ以上の空白で分割
  words = str.strip.split(/\s+/)
  words.reverse.join(" ")
end

# 解法3: 手動で単語を抽出
def reverse_words_manual(str)
  words = []
  current_word = ""
  
  str.each_char do |char|
    if char == ' '
      # 空白に遭遇したら、現在の単語を保存
      words << current_word unless current_word.empty?
      current_word = ""
    else
      current_word += char
    end
  end
  
  # 最後の単語を追加
  words << current_word unless current_word.empty?
  
  words.reverse.join(" ")
end

# 解法4: scanを使用
def reverse_words_scan(str)
  # 非空白文字の連続にマッチ
  str.scan(/\S+/).reverse.join(" ")
end

# 解法5: in-placeで反転（参考実装）
def reverse_words_inplace(str)
  # まず文字列全体を反転
  reversed = str.strip.reverse
  
  # 次に各単語を個別に反転
  reversed.split.map(&:reverse).join(" ")
end

# テストケース
puts reverse_words("  hello   world  ")    # => "world hello"
puts reverse_words("the sky is blue")      # => "blue is sky the"
puts reverse_words("hello")                # => "hello"
puts reverse_words("   ")                  # => ""
puts reverse_words("a b c")                # => "c b a"
```

---

## まとめ

このセクションでは、文字列操作の基本を8問を通じて学びました。

**学んだ主なメソッド:**

- `reverse` - 文字列の反転
- `downcase`, `upcase` - 大文字小文字変換
- `chars` - 文字配列への変換
- `tally` - 出現回数のカウント
- `split`, `join` - 分割と結合
- `gsub` - 置換
- `strip` - 前後の空白除去
- `index`, `rindex` - 文字の位置検索

**重要なポイント:**

1. 文字列はイミュータブル（変更不可）として扱うのが安全
2. 大文字小文字の正規化を忘れずに
3. 空文字列やエッジケースの処理が重要
4. 正規表現は強力だが、可読性に注意
5. Rubyには多くの便利な文字列メソッドがある
