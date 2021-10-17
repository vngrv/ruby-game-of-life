require_relative 'lib/cell'
require_relative 'lib/board'

class Game
  def call(width, height, cell, cells = [])
    system('clear')
    grid = Board.new(width, height, cell, cells)
    puts grid

    until grid.lifeness?
      grid.evolve

      sleep 0.5
      system('clear')
      puts grid
    end
  end
end


game = Game.new.call(10, 10, Cell, [])


puts game 
