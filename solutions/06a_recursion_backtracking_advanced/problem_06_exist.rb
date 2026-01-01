#!/usr/bin/env ruby
# frozen_string_literal: true

def exist(board, word)
  m = board.length
  n = board[0].length

  m.times do |r|
    n.times do |c|
      return true if dfs_exist(board, word, r, c, 0)
    end
  end

  false
end

def dfs_exist(board, word, row, col, index)
  return true if index == word.length

  return false if row < 0 || row >= board.length ||
                  col < 0 || col >= board[0].length

  return false if board[row][col] != word[index]

  temp = board[row][col]
  board[row][col] = '#'

  result = dfs_exist(board, word, row + 1, col, index + 1) ||
           dfs_exist(board, word, row - 1, col, index + 1) ||
           dfs_exist(board, word, row, col + 1, index + 1) ||
           dfs_exist(board, word, row, col - 1, index + 1)

  board[row][col] = temp

  result
end

def exist_with_set(board, word)
  m = board.length
  n = board[0].length

  m.times do |r|
    n.times do |c|
      visited = Set.new
      return true if dfs_exist_set(board, word, r, c, 0, visited)
    end
  end

  false
end

def dfs_exist_set(board, word, row, col, index, visited)
  return true if index == word.length

  return false if row < 0 || row >= board.length ||
                  col < 0 || col >= board[0].length ||
                  visited.include?([row, col]) ||
                  board[row][col] != word[index]

  visited.add([row, col])

  result = dfs_exist_set(board, word, row + 1, col, index + 1, visited) ||
           dfs_exist_set(board, word, row - 1, col, index + 1, visited) ||
           dfs_exist_set(board, word, row, col + 1, index + 1, visited) ||
           dfs_exist_set(board, word, row, col - 1, index + 1, visited)

  visited.delete([row, col])

  result
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 単語検索 テスト ==='
  puts

  board = [
    ['A', 'B', 'C', 'E'],
    ['S', 'F', 'C', 'S'],
    ['A', 'D', 'E', 'E']
  ]

  result1 = exist(board.map(&:dup), 'ABCCED')
  puts "Test 1: exist(board, 'ABCCED')"
  puts "結果: #{result1}"
  puts '期待値: true'
  puts "判定: #{result1 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = exist(board.map(&:dup), 'SEE')
  puts "Test 2: exist(board, 'SEE')"
  puts "結果: #{result2}"
  puts '期待値: true'
  puts "判定: #{result2 == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  result3 = exist(board.map(&:dup), 'ABCB')
  puts "Test 3: exist(board, 'ABCB')"
  puts "結果: #{result3}"
  puts '期待値: false'
  puts "判定: #{result3 == false ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
