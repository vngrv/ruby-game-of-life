require_relative 'cell'
require_relative 'board'

class Game
  def call(width, height, cell, cells = [], fps = 0.1)
    system('clear')
    board = Board.new(width, height, cell, cells)
    puts board

    until board.lifeness?
      board.evolve

      sleep fps
      system('clear')
      puts board
    end
  end
end


