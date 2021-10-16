require 'pry'

class Board  
  def initialize(width, height)
    @width = width
    @height = height
    @archive = []
  end

  def create_board(cell)
    @board = Array.new(@width) { Array.new(@height) { cell.new(rand(3).zero?) }   } 
  end

  def lives_on?(row, col)
    neighborhood = (-1..1).map { |r| (-1..1).map { |c| @board[row + r] && @board[row + r][col + c] } }
    its_alive = neighborhood[1].delete_at(1)
    neighbors = neighborhood.flatten.count(true)
    neighbors == 3 || neighbors == 2 && its_alive
  end

  def next_gen
    (0...@width).map { |row| (0...@height).map { |col| p lives_on?(row, col) } }
  end

  def is_exist_in_archive?(increment)
   @archive.include?(@board) ? increment = 0 : @archive << @board
  end

  def update_board
    @board = next_gen
  end

  def show_board
     puts @board.map { |row| row.map { |cell| cell ? '*' : ' ' }.inspect }
  end

  def show_matrix(type='dotted')
    for i in 0..@width-1 do
      for j in 0..@height do
        if type === 'dotted'
          print "#{@board[i][j] ? "*" : " "}"
        else
          print "#{@board[i][j] ? "█" : "▒"}"
        end
      end
      puts ""
    end
  end
end

