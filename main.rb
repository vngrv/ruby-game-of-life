require_relative 'lib/cell'
require_relative 'lib/board'


if true

  board = Board.new(4, 4)
  board.create_board(Cell)

  tick = 0
  incr = 1

  loop do

    p board.is_exist_in_archive?(incr)

    sleep(0.3)

    puts "tick - #{tick += incr}"
    board.show_board
   
    board.update_board 
    board.show_board
    #board.show_matrix
  end
end
