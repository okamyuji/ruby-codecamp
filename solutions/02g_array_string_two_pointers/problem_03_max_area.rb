#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================================
# 問題: コンテナに最も多く水を入れる
# ファイル: 02g_array_string_two_pointers.md
# ============================================================================
#
# 各要素が垂直線の高さを表す配列が与えられます。2本の線を選んで、最も多くの水を入れられる
# 面積を返してください。
#
# 入力例: [1, 8, 6, 2, 5, 4, 8, 3, 7]
# 出力例: 49  # インデックス1と8の線（高さ8と7、幅7）
#
# 時間計算量: O(n)
# 空間計算量: O(1)
# ============================================================================

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
    ((i + 1)...height.length).each do |j|
      width = j - i
      h = [height[i], height[j]].min
      area = width * h
      max_area = [max_area, area].max
    end
  end

  max_area
end

# ============================================================================
# テストケース
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== コンテナに最も多く水を入れる テスト ==='
  puts

  # テストケース1: 通常のケース
  result1 = max_area([1, 8, 6, 2, 5, 4, 8, 3, 7])
  puts 'Test 1: max_area([1, 8, 6, 2, 5, 4, 8, 3, 7])'
  puts "結果: #{result1}"
  puts '期待値: 49'
  puts "判定: #{result1 == 49 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース2: 2本の線
  result2 = max_area([1, 1])
  puts 'Test 2: max_area([1, 1])'
  puts "結果: #{result2}"
  puts '期待値: 1'
  puts "判定: #{result2 == 1 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # テストケース3: 別のケース
  result3 = max_area([4, 3, 2, 1, 4])
  puts 'Test 3: max_area([4, 3, 2, 1, 4])'
  puts "結果: #{result3}"
  puts '期待値: 16 (インデックス0と4、高さ4、幅4)'
  puts "判定: #{result3 == 16 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法2のテスト（インデックス付き）
  puts '--- 解法2（インデックス付き）のテスト ---'
  result4 = max_area_with_indices([1, 8, 6, 2, 5, 4, 8, 3, 7])
  puts "max_area_with_indices([1, 8, 6, 2, 5, 4, 8, 3, 7]) = #{result4}"
  puts '期待値: { area: 49, left: 1, right: 8 }'
  puts "判定: #{result4[:area] == 49 ? '✓ PASS' : '✗ FAIL'}"
  puts

  # 解法3のテスト（ブルートフォース）
  puts '--- 解法3（ブルートフォース）のテスト ---'
  result5 = max_area_brute([1, 8, 6, 2, 5, 4, 8, 3, 7])
  puts "max_area_brute([1, 8, 6, 2, 5, 4, 8, 3, 7]) = #{result5}"
  puts "判定: #{result5 == 49 ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
