require_relative 'cell'
require_relative 'board'

class Game
  def call(width, height, cell, cells = [], fps = 0.2)
    system('clear')
    board = Board.new(width, height, cell, cells)
    puts board

    until board.lifeness?
      board.evolve
      board.stagnation?

      sleep fps
      system('clear')
      puts board 
    end
  end
end


