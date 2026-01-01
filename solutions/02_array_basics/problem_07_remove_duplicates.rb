#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: 配列の重複を除去
# ファイル: 02_array_basics.md
# ============================================================================
#
# 配列が与えられます。重複する要素を除去し、ユニークな要素のみを含む配列を返してください。
# 元の順序は保持してください。
#
# 入力例: [1, 2, 2, 3, 4, 4, 5]
# 出力例: [1, 2, 3, 4, 5]
#
# 時間計算量: O(n) - 各要素を一度処理（ハッシュを使用した場合）
# 空間計算量: O(n) - 見た要素を追跡するためのセット
# ============================================================================

# 解法1: uniqメソッドを使用（推奨）
def remove_duplicates(arr)
  # uniqは重複を除去した新しい配列を返す
  # 元の順序は保持される
  arr.uniq
end

# 解法2: 手動でセットを使用
def remove_duplicates_manual(arr)
  seen = Set.new # 見た要素を追跡するセット
  result = []

  arr.each do |elem|
    unless seen.include?(elem)
      seen.add(elem)
      result << elem
    end
  end

  result
end

# 解法3: ハッシュを使用（Setがない場合）
def remove_duplicates_hash(arr)
  seen = {}
  result = []

  arr.each do |elem|
    unless seen[elem]
      seen[elem] = true
      result << elem
    end
  end

  result
end

# 解法4: each_with_objectを使用
def remove_duplicates_each_with_object(arr)
  arr.each_with_object([]) do |elem, result|
    result << elem unless result.include?(elem)
  end
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== 配列の重複を除去 テスト ==='
  puts

  # テストケース1: 重複あり
  result1 = remove_duplicates([1, 2, 2, 3, 4, 4, 5])
  puts 'Test 1: remove_duplicates([1, 2, 2, 3, 4, 4, 5])'
  puts "結果: #{result1}"
  puts '期待値: [1, 2, 3, 4, 5]'
  puts "判定: #{result1 == [1, 2, 3, 4, 5] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 全て同じ要素
  result2 = remove_duplicates([1, 1, 1, 1])
  puts 'Test 2: remove_duplicates([1, 1, 1, 1])'
  puts "結果: #{result2}"
  puts '期待値: [1]'
  puts "判定: #{result2 == [1] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 文字列の配列
  result3 = remove_duplicates(['a', 'b', 'a', 'c', 'b'])
  puts "Test 3: remove_duplicates(['a', 'b', 'a', 'c', 'b'])"
  puts "結果: #{result3}"
  puts "期待値: ['a', 'b', 'c']"
  puts "判定: #{result3 == ['a', 'b', 'c'] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース4: 空配列
  result4 = remove_duplicates([])
  puts 'Test 4: remove_duplicates([])'
  puts "結果: #{result4}"
  puts '期待値: []'
  puts "判定: #{result4 == [] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース5: 重複なし
  result5 = remove_duplicates([1, 2, 3])
  puts 'Test 5: remove_duplicates([1, 2, 3])'
  puts "結果: #{result5}"
  puts '期待値: [1, 2, 3]'
  puts "判定: #{result5 == [1, 2, 3] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト
  puts '--- 解法2（Set使用）のテスト ---'
  result6 = remove_duplicates_manual([1, 2, 2, 3, 4, 4, 5])
  puts "remove_duplicates_manual([1, 2, 2, 3, 4, 4, 5]) = #{result6}"
  puts "判定: #{result6 == [1, 2, 3, 4, 5] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト
  puts '--- 解法3（Hash使用）のテスト ---'
  result7 = remove_duplicates_hash([1, 2, 2, 3, 4, 4, 5])
  puts "remove_duplicates_hash([1, 2, 2, 3, 4, 4, 5]) = #{result7}"
  puts "判定: #{result7 == [1, 2, 3, 4, 5] ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法4のテスト
  puts '--- 解法4（each_with_object）のテスト ---'
  result8 = remove_duplicates_each_with_object([1, 2, 2, 3, 4, 4, 5])
  puts "remove_duplicates_each_with_object([1, 2, 2, 3, 4, 4, 5]) = #{result8}"
  puts "判定: #{result8 == [1, 2, 3, 4, 5] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
