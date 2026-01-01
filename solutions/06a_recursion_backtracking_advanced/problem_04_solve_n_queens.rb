#!/usr/bin/env ruby
# frozen_string_literal: true

def solve_n_queens(n)
  result = []
  board = Array.new(n) { '.' * n }
  cols = Set.new
  pos_diag = Set.new
  neg_diag = Set.new

  backtrack_queens(0, n, board, cols, pos_diag, neg_diag, result)
  result
end

def backtrack_queens(row, n, board, cols, pos_diag, neg_diag, result)
  if row == n
    result << board.dup
    return
  end

  n.times do |col|
    next if cols.include?(col)
    next if pos_diag.include?(row - col)
    next if neg_diag.include?(row + col)

    board[row] = "#{board[row][0...col]}Q#{board[row][(col + 1)..]}"
    cols.add(col)
    pos_diag.add(row - col)
    neg_diag.add(row + col)

    backtrack_queens(row + 1, n, board, cols, pos_diag, neg_diag, result)

    board[row] = '.' * n
    cols.delete(col)
    pos_diag.delete(row - col)
    neg_diag.delete(row + col)
  end
end

def solve_n_queens_bit(n)
  result = []
  board = Array.new(n) { '.' * n }

  backtrack_queens_bit(0, n, 0, 0, 0, board, result)
  result
end

def backtrack_queens_bit(row, n, cols, pos_diag, neg_diag, board, result)
  if row == n
    result << board.dup
    return
  end

  available = ((1 << n) - 1) & ~(cols | pos_diag | neg_diag)

  while available > 0
    position = available & -available
    col = Math.log2(position).to_i

    board[row] = "#{'.' * col}Q#{'.' * (n - col - 1)}"

    backtrack_queens_bit(
      row + 1, n,
      cols | position,
      (pos_diag | position) >> 1,
      (neg_diag | position) << 1,
      board, result
    )

    board[row] = '.' * n

    available &= available - 1
  end
end

if __FILE__ == $PROGRAM_NAME
  puts '=== N-Queens問題 テスト ==='
  puts

  result1 = solve_n_queens(4)
  puts 'Test 1: solve_n_queens(4)'
  puts "結果の数: #{result1.length}"
  puts '期待値: 2個の解'
  puts "判定: #{result1.length == 2 ? '✓ PASS' : '✗ FAIL'}"
  puts

  result2 = solve_n_queens(1)
  puts 'Test 2: solve_n_queens(1)'
  puts "結果: #{result2}"
  puts "期待値: [['Q']]"
  puts "判定: #{result2 == [['Q']] ? '✓ PASS' : '✗ FAIL'}"
  puts

  puts '=== 完了 ==='
end
