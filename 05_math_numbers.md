# Ruby 3.4 初級者向け問題集 - Part 4: 数学・数値処理

## 概要

このセクションでは、数学的な問題と数値処理を学びます。素数、最大公約数、フィボナッチ数列など、プログラミングの基礎として重要なアルゴリズムを扱います。

---

## 問題27: フィズバズ（FizzBuzz）

### 問題文

1からnまでの数について、以下のルールに従った文字列の配列を返してください。

- 3で割り切れる場合: "Fizz"
- 5で割り切れる場合: "Buzz"
- 3と5の両方で割り切れる場合: "FizzBuzz"
- それ以外: 数字を文字列に変換

**入力例:**

```text
n = 15
```

**出力例:**

```text
["1", "2", "Fizz", "4", "Buzz", "Fizz", "7", "8", "Fizz", "Buzz", "11", "Fizz", "13", "14", "FizzBuzz"]
```

### アルゴリズム概説

1からnまでループし、各数が3で割り切れるか、5で割り切れるかをチェックします。両方で割り切れるケースを先にチェックすることが重要です。

**時間計算量:** O(n) - nまでの数を処理  
**空間計算量:** O(n) - 結果配列

### 擬似コード

```text
関数 fizz_buzz(n):
    結果 = 空配列
    
    1からnまでの各数について:
        もし数 % 15 == 0 なら:
            "FizzBuzz"を追加
        もし数 % 3 == 0 なら:
            "Fizz"を追加
        もし数 % 5 == 0 なら:
            "Buzz"を追加
        そうでなければ:
            数を文字列として追加
    
    結果を返す
```

### 解答

```ruby
# 解法1: 条件分岐を使用（推奨）
def fizz_buzz(n)
  (1..n).map do |num|
    if num % 15 == 0
      "FizzBuzz"
    elsif num % 3 == 0
      "Fizz"
    elsif num % 5 == 0
      "Buzz"
    else
      num.to_s
    end
  end
end

# 解法2: 文字列連結を使用
def fizz_buzz_concat(n)
  (1..n).map do |num|
    result = ""
    result += "Fizz" if num % 3 == 0
    result += "Buzz" if num % 5 == 0
    result.empty? ? num.to_s : result
  end
end

# 解法3: caseを使用
def fizz_buzz_case(n)
  (1..n).map do |num|
    case
    when num % 15 == 0 then "FizzBuzz"
    when num % 3 == 0 then "Fizz"
    when num % 5 == 0 then "Buzz"
    else num.to_s
    end
  end
end

# 解法4: 拡張可能なバージョン
def fizz_buzz_extensible(n, rules = { 3 => "Fizz", 5 => "Buzz" })
  (1..n).map do |num|
    result = rules.select { |divisor, _| num % divisor == 0 }
                  .values
                  .join
    result.empty? ? num.to_s : result
  end
end

# テストケース
p fizz_buzz(15)
# => ["1", "2", "Fizz", "4", "Buzz", "Fizz", "7", "8", "Fizz", "Buzz", "11", "Fizz", "13", "14", "FizzBuzz"]

p fizz_buzz(3)
# => ["1", "2", "Fizz"]

p fizz_buzz(1)
# => ["1"]
```

---

## 問題28: 素数判定

### 問題文

正の整数nが与えられます。nが素数かどうかを判定してください。

**入力例:**

```text
n = 17
```

**出力例:**

```text
true
```

### アルゴリズム概説

素数は1と自分自身でしか割り切れない数です。2からsqrt(n)までの数で割り切れるかをチェックします。sqrt(n)までで十分な理由は、もしn = a * bでa > sqrt(n)ならb < sqrt(n)となるためです。

**時間計算量:** O(√n) - sqrt(n)までチェック  
**空間計算量:** O(1) - 定数量のメモリ

### 擬似コード

```text
関数 prime?(n):
    もし n < 2 なら:
        falseを返す
    もし n == 2 なら:
        trueを返す
    もし n が偶数なら:
        falseを返す
    
    3からsqrt(n)までの奇数について:
        もし n % 数 == 0 なら:
            falseを返す
    
    trueを返す
```

### 解答

```ruby
# 解法1: 効率的な実装（推奨）
def prime?(n)
  # 1以下は素数ではない
  return false if n < 2
  # 2は唯一の偶数の素数
  return true if n == 2
  # 2より大きい偶数は素数ではない
  return false if n.even?
  
  # 3からsqrt(n)までの奇数でチェック
  limit = Math.sqrt(n).to_i
  (3..limit).step(2).none? { |i| n % i == 0 }
end

# 解法2: Rubyの組み込みを使用
require 'prime'

def prime_builtin?(n)
  Prime.prime?(n)
end

# 解法3: シンプルな実装
def prime_simple?(n)
  return false if n < 2
  
  (2...n).none? { |i| n % i == 0 }
end

# 解法4: 6k ± 1 最適化
def prime_optimized?(n)
  return false if n < 2
  return true if n == 2 || n == 3
  return false if n % 2 == 0 || n % 3 == 0
  
  # すべての素数は6k ± 1の形（2と3を除く）
  i = 5
  while i * i <= n
    return false if n % i == 0 || n % (i + 2) == 0
    i += 6
  end
  
  true
end

# テストケース
puts prime?(17)   # => true
puts prime?(4)    # => false
puts prime?(2)    # => true
puts prime?(1)    # => false
puts prime?(97)   # => true
puts prime?(100)  # => false
```

---

## 問題29: フィボナッチ数列

### 問題文

非負整数nが与えられます。n番目のフィボナッチ数を返してください。フィボナッチ数列はF(0) = 0, F(1) = 1, F(n) = F(n-1) + F(n-2)で定義されます。

**入力例:**

```text
n = 10
```

**出力例:**

```text
55  # 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55
```

### アルゴリズム概説

動的計画法を使用して、前の2つの値を保持しながら順次計算します。再帰は指数的な時間計算量になるため避けます。

**時間計算量:** O(n) - n回の計算  
**空間計算量:** O(1) - 2つの変数のみ

### 擬似コード

```text
関数 fibonacci(n):
    もし n == 0 なら:
        0を返す
    もし n == 1 なら:
        1を返す
    
    前々 = 0
    前 = 1
    
    2からnまで:
        現在 = 前 + 前々
        前々 = 前
        前 = 現在
    
    前を返す
```

### 解答

```ruby
# 解法1: 反復法（推奨）
def fibonacci(n)
  return n if n <= 1
  
  # 前の2つの値を保持
  prev_prev = 0
  prev = 1
  
  (2..n).each do
    current = prev + prev_prev
    prev_prev = prev
    prev = current
  end
  
  prev
end

# 解法2: 配列を使用
def fibonacci_array(n)
  return n if n <= 1
  
  fib = [0, 1]
  (2..n).each { |i| fib[i] = fib[i - 1] + fib[i - 2] }
  fib[n]
end

# 解法3: 再帰（メモ化あり）
def fibonacci_memo(n, memo = {})
  return n if n <= 1
  return memo[n] if memo.key?(n)
  
  memo[n] = fibonacci_memo(n - 1, memo) + fibonacci_memo(n - 2, memo)
end

# 解法4: 行列累乗（高速）
def fibonacci_matrix(n)
  return n if n <= 1
  
  matrix_power([[1, 1], [1, 0]], n)[0][1]
end

def matrix_multiply(a, b)
  [
    [a[0][0] * b[0][0] + a[0][1] * b[1][0], a[0][0] * b[0][1] + a[0][1] * b[1][1]],
    [a[1][0] * b[0][0] + a[1][1] * b[1][0], a[1][0] * b[0][1] + a[1][1] * b[1][1]]
  ]
end

def matrix_power(matrix, n)
  result = [[1, 0], [0, 1]]  # 単位行列
  
  while n > 0
    result = matrix_multiply(result, matrix) if n.odd?
    matrix = matrix_multiply(matrix, matrix)
    n /= 2
  end
  
  result
end

# 解法5: Enumeratorを使用
def fibonacci_enumerator(n)
  fib = Enumerator.new do |y|
    a, b = 0, 1
    loop do
      y << a
      a, b = b, a + b
    end
  end
  
  fib.take(n + 1).last
end

# テストケース
puts fibonacci(10)  # => 55
puts fibonacci(0)   # => 0
puts fibonacci(1)   # => 1
puts fibonacci(20)  # => 6765
```

---

## 問題30: 最大公約数と最小公倍数

### 問題文

2つの正の整数が与えられます。最大公約数（GCD）と最小公倍数（LCM）を返してください。

**入力例:**

```text
a = 12, b = 18
```

**出力例:**

```text
GCD: 6, LCM: 36
```

### アルゴリズム概説

ユークリッドの互除法を使用してGCDを計算します。LCMはa * b / GCDで求められます。

**時間計算量:** O(log(min(a, b))) - ユークリッドの互除法  
**空間計算量:** O(1) - 定数量のメモリ

### 擬似コード

```text
関数 gcd(a, b):
    b == 0 の間:
        a, b = b, a % b
    aを返す

関数 lcm(a, b):
    a * b / gcd(a, b) を返す
```

### 解答

```ruby
# 解法1: 組み込みメソッドを使用（推奨）
def gcd_lcm(a, b)
  {
    gcd: a.gcd(b),
    lcm: a.lcm(b)
  }
end

# 解法2: ユークリッドの互除法（反復）
def gcd_iterative(a, b)
  while b != 0
    a, b = b, a % b
  end
  a
end

def lcm_from_gcd(a, b)
  # オーバーフローを避けるため、先に除算
  a / gcd_iterative(a, b) * b
end

# 解法3: ユークリッドの互除法（再帰）
def gcd_recursive(a, b)
  return a if b == 0
  gcd_recursive(b, a % b)
end

# 解法4: 減算法（遅いが理解しやすい）
def gcd_subtraction(a, b)
  while a != b
    if a > b
      a -= b
    else
      b -= a
    end
  end
  a
end

# 解法5: 複数の数のGCD/LCM
def gcd_multiple(*nums)
  nums.reduce { |acc, n| acc.gcd(n) }
end

def lcm_multiple(*nums)
  nums.reduce { |acc, n| acc.lcm(n) }
end

# テストケース
p gcd_lcm(12, 18)  # => {:gcd=>6, :lcm=>36}
p gcd_lcm(7, 13)   # => {:gcd=>1, :lcm=>91}
p gcd_lcm(100, 25) # => {:gcd=>25, :lcm=>100}

puts gcd_iterative(12, 18)      # => 6
puts lcm_from_gcd(12, 18)       # => 36
puts gcd_multiple(12, 18, 24)   # => 6
puts lcm_multiple(4, 6, 8)      # => 24
```

---

## 問題31: 数字の桁の合計

### 問題文

非負整数が与えられます。すべての桁の合計を返してください。

**入力例:**

```text
n = 12345
```

**出力例:**

```text
15  # 1 + 2 + 3 + 4 + 5
```

### アルゴリズム概説

数を10で割った余りで各桁を取得し、10で割ることで次の桁に移動します。または文字列に変換して各文字を数値に変換する方法もあります。

**時間計算量:** O(d) - dは桁数  
**空間計算量:** O(1) - 定数量のメモリ

### 擬似コード

```text
関数 digit_sum(n):
    合計 = 0
    
    n > 0 の間:
        合計 += n % 10  # 最下位桁
        n /= 10         # 次の桁へ
    
    合計を返す
```

### 解答

```ruby
# 解法1: 数学的アプローチ（推奨）
def digit_sum(n)
  sum = 0
  
  while n > 0
    sum += n % 10  # 最下位の桁を取得
    n /= 10        # 次の桁へ移動
  end
  
  sum
end

# 解法2: 文字列に変換
def digit_sum_string(n)
  n.to_s.chars.map(&:to_i).sum
end

# 解法3: digitsメソッドを使用
def digit_sum_digits(n)
  # digitsは各桁を配列として返す（最下位から）
  n.digits.sum
end

# 解法4: reduceを使用
def digit_sum_reduce(n)
  n.digits.reduce(0, :+)
end

# 解法5: 再帰
def digit_sum_recursive(n)
  return n if n < 10
  n % 10 + digit_sum_recursive(n / 10)
end

# 発展: 桁の合計を繰り返して1桁にする
def digital_root(n)
  return 0 if n == 0
  
  # 数学的な公式: 1 + (n - 1) % 9
  1 + (n - 1) % 9
end

# テストケース
puts digit_sum(12345)   # => 15
puts digit_sum(0)       # => 0
puts digit_sum(9999)    # => 36
puts digit_sum(100)     # => 1

puts digital_root(38)   # => 2 (3 + 8 = 11, 1 + 1 = 2)
```

---

## 問題32: 階乗の計算

### 問題文

非負整数nが与えられます。nの階乗(n!)を計算してください。

**入力例:**

```text
n = 5
```

**出力例:**

```text
120  # 5! = 5 * 4 * 3 * 2 * 1
```

### アルゴリズム概説

1からnまでの数を順に乗算します。0! = 1であることに注意してください。

**時間計算量:** O(n) - n回の乗算  
**空間計算量:** O(1) - 定数量のメモリ

### 擬似コード

```text
関数 factorial(n):
    もし n <= 1 なら:
        1を返す
    
    結果 = 1
    2からnまで:
        結果 *= 数
    
    結果を返す
```

### 解答

```ruby
# 解法1: 反復法（推奨）
def factorial(n)
  return 1 if n <= 1
  
  result = 1
  (2..n).each { |i| result *= i }
  result
end

# 解法2: reduceを使用
def factorial_reduce(n)
  return 1 if n <= 1
  
  (1..n).reduce(:*)
end

# 解法3: 再帰
def factorial_recursive(n)
  return 1 if n <= 1
  n * factorial_recursive(n - 1)
end

# 解法4: 末尾再帰（最適化されやすい）
def factorial_tail_recursive(n, acc = 1)
  return acc if n <= 1
  factorial_tail_recursive(n - 1, acc * n)
end

# 解法5: inject
def factorial_inject(n)
  (1..n).inject(1, :*)
end

# 発展: 大きな数の階乗（メモ化）
class Factorial
  def initialize
    @cache = { 0 => 1, 1 => 1 }
  end
  
  def calculate(n)
    return @cache[n] if @cache.key?(n)
    @cache[n] = n * calculate(n - 1)
  end
end

# テストケース
puts factorial(5)    # => 120
puts factorial(0)    # => 1
puts factorial(1)    # => 1
puts factorial(10)   # => 3628800

fact = Factorial.new
puts fact.calculate(20)  # => 2432902008176640000
```

---

## 問題33: べき乗の計算

### 問題文

底xと指数nが与えられます。x^nを計算してください。nは整数（負の値も可）です。

**入力例:**

```text
x = 2.0, n = 10
```

**出力例:**

```text
1024.0
```

### アルゴリズム概説

二分累乗法を使用します。x^n = (x^(n/2))^2を利用することで、O(log n)の時間計算量で計算できます。

**時間計算量:** O(log n) - nを半分にしていく  
**空間計算量:** O(1) - 定数量のメモリ

### 擬似コード

```text
関数 power(x, n):
    もし n < 0 なら:
        x = 1 / x
        n = -n
    
    結果 = 1
    
    n > 0 の間:
        もし n が奇数なら:
            結果 *= x
        x *= x
        n /= 2
    
    結果を返す
```

### 解答

```ruby
# 解法1: 組み込み演算子を使用（推奨）
def power(x, n)
  x ** n
end

# 解法2: 二分累乗法（効率的）
def power_fast(x, n)
  # 負の指数の処理
  if n < 0
    x = 1.0 / x
    n = -n
  end
  
  result = 1.0
  
  while n > 0
    # nが奇数なら、結果にxを掛ける
    result *= x if n.odd?
    # xを2乗
    x *= x
    # nを半分にする
    n /= 2
  end
  
  result
end

# 解法3: 再帰的な二分累乗法
def power_recursive(x, n)
  return 1.0 if n == 0
  
  if n < 0
    x = 1.0 / x
    n = -n
  end
  
  half = power_recursive(x, n / 2)
  
  if n.even?
    half * half
  else
    half * half * x
  end
end

# 解法4: 反復での単純な実装（遅い）
def power_simple(x, n)
  return 1.0 if n == 0
  
  if n < 0
    x = 1.0 / x
    n = -n
  end
  
  result = 1.0
  n.times { result *= x }
  result
end

# テストケース
puts power(2.0, 10)    # => 1024.0
puts power(2.1, 3)     # => 9.261
puts power(2.0, -2)    # => 0.25
puts power(0.0, 1)     # => 0.0
puts power(1.0, 1000)  # => 1.0
```

---

## 問題34: 回文数

### 問題文

整数が与えられます。その整数が回文数（前から読んでも後ろから読んでも同じ）かどうかを判定してください。負の数は回文数ではありません。

**入力例:**

```text
x = 121
```

**出力例:**

```text
true
```

### アルゴリズム概説

数を文字列に変換せずに、数を反転して元の数と比較します。または半分だけ反転して比較する方法もあります。

**時間計算量:** O(log n) - 桁数に比例  
**空間計算量:** O(1) - 定数量のメモリ

### 擬似コード

```text
関数 palindrome_number?(x):
    もし x < 0 なら:
        falseを返す
    
    元の数 = x
    反転した数 = 0
    
    x > 0 の間:
        反転した数 = 反転した数 * 10 + x % 10
        x /= 10
    
    元の数 == 反転した数 を返す
```

### 解答

```ruby
# 解法1: 数値を反転して比較（推奨）
def palindrome_number?(x)
  # 負の数は回文ではない
  return false if x < 0
  
  original = x
  reversed = 0
  
  while x > 0
    reversed = reversed * 10 + x % 10
    x /= 10
  end
  
  original == reversed
end

# 解法2: 文字列に変換
def palindrome_number_string?(x)
  return false if x < 0
  x.to_s == x.to_s.reverse
end

# 解法3: 半分だけ反転（オーバーフロー対策）
def palindrome_number_half?(x)
  # 負の数、または10の倍数（0を除く）は回文ではない
  return false if x < 0 || (x != 0 && x % 10 == 0)
  
  reversed_half = 0
  
  # 半分だけ反転
  while x > reversed_half
    reversed_half = reversed_half * 10 + x % 10
    x /= 10
  end
  
  # 桁数が偶数または奇数の場合を考慮
  x == reversed_half || x == reversed_half / 10
end

# 解法4: 配列を使用
def palindrome_number_array?(x)
  return false if x < 0
  
  digits = []
  temp = x
  
  while temp > 0
    digits << temp % 10
    temp /= 10
  end
  
  digits == digits.reverse
end

# テストケース
puts palindrome_number?(121)    # => true
puts palindrome_number?(-121)   # => false
puts palindrome_number?(10)     # => false
puts palindrome_number?(12321)  # => true
puts palindrome_number?(0)      # => true
```

---

## まとめ

このセクションでは、数学・数値処理を8問を通じて学びました。

**学んだ主なアルゴリズム:**

- **FizzBuzz** - 条件分岐の基本
- **素数判定** - √nまでのチェック、6k ± 1 最適化
- **フィボナッチ数列** - 動的計画法、メモ化
- **ユークリッドの互除法** - GCD/LCMの計算
- **桁の処理** - % 10 と / 10 の活用
- **階乗** - 反復と再帰
- **二分累乗法** - O(log n)のべき乗計算
- **数値の反転** - 回文判定

**学んだ主なメソッド:**

- `gcd`, `lcm` - 最大公約数、最小公倍数
- `digits` - 数を各桁の配列に変換
- `**` - べき乗演算子
- `even?`, `odd?` - 偶奇判定
- `Prime.prime?` - 素数判定（Primeライブラリ）

**重要なポイント:**

1. 数学的な性質を利用して計算量を削減する
2. オーバーフローに注意（Rubyは任意精度整数だが）
3. エッジケース（0, 1, 負の数など）を忘れずに処理
4. メモ化で再帰の効率を改善できる
5. 反復法は再帰法よりスタックオーバーフローのリスクがない
