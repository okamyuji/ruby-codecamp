#!/usr/bin/env ruby
# frozen_string_literal: true

def solve_sudoku(board)
  backtrack_sudoku(board)
end

def backtrack_sudoku(board)
  9.times do |row|
    9.times do |col|
      next unless board[row][col] == '.'

      ('1'..'9').each do |num|
        next unless is_valid_sudoku(board, row, col, num)

        board[row][col] = num

        return true if backtrack_sudoku(board)

        board[row][col] = '.'
      end

      return false
    end
  end

  true
end

def is_valid_sudoku(board, row, col, num)
  return false if board[row].include?(num)

  return false if board.any? { |r| r[col] == num }

  box_row = (row / 3) * 3
  box_col = (col / 3) * 3

  (box_row...(box_row + 3)).each do |r|
    (box_col...(box_col + 3)).each do |c|
      return false if board[r][c] == num
    end
  end

  true
end

def solve_sudoku_optimized(board)
  rows = Array.new(9) { Set.new }
  cols = Array.new(9) { Set.new }
  boxes = Array.new(9) { Set.new }

  9.times do |r|
    9.times do |c|
      next unless board[r][c] != '.'

      num = board[r][c]
      rows[r].add(num)
      cols[c].add(num)
      box_idx = (r / 3) * 3 + c / 3
      boxes[box_idx].add(num)
    end
  end

  backtrack_sudoku_optimized(board, rows, cols, boxes)
end

def backtrack_sudoku_optimized(board, rows, cols, boxes)
  9.times do |row|
    9.times do |col|
      next unless board[row][col] == '.'

      box_idx = (row / 3) * 3 + col / 3

      ('1'..'9').each do |num|
        next unless !rows[row].include?(num) &&
                    !cols[col].include?(num) &&
                    !boxes[box_idx].include?(num)

        board[row][col] = num
        rows[row].add(num)
        cols[col].add(num)
        boxes[box_idx].add(num)

        return true if backtrack_sudoku_optimized(board, rows, cols, boxes)

        board[row][col] = '.'
        rows[row].delete(num)
        cols[col].delete(num)
        boxes[box_idx].delete(num)
      end

      return false
    end
  end

  true
end

if __FILE__ == $PROGRAM_NAME
  puts '=== 数独ソルバー テスト ==='
  puts

  board = [
    ['5', '3', '.', '.', '7', '.', '.', '.', '.'],
    ['6', '.', '.', '1', '9', '5', '.', '.', '.'],
    ['.', '9', '8', '.', '.', '.', '.', '6', '.'],
    ['8', '.', '.', '.', '6', '.', '.', '.', '3'],
    ['4', '.', '.', '8', '.', '3', '.', '.', '1'],
    ['7', '.', '.', '.', '2', '.', '.', '.', '6'],
    ['.', '6', '.', '.', '.', '.', '2', '8', '.'],
    ['.', '.', '.', '4', '1', '9', '.', '.', '5'],
    ['.', '.', '.', '.', '8', '.', '.', '7', '9']
  ]

  result = solve_sudoku(board.map(&:dup))
  puts 'Test 1: solve_sudoku(board)'
  puts "結果: #{result}"
  puts '期待値: true'
  puts "判定: #{result == true ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
