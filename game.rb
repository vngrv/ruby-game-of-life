class CellGame
  def initialize(size)
    @size = size; 
    @archive = []
    @grid = Array.new(size) { Array.new(size) { rand(3).zero? } }
  end

  def lives_on?(row, col)
    neighborhood = (-1..1).map { |r| (-1..1).map { |c| @grid[row + r] && @grid[row + r][col + c] } }
    its_alive = neighborhood[1].delete_at(1)
    neighbors = neighborhood.flatten.count(true)
    neighbors == 3 || neighbors == 2 && its_alive
  end

  def next_gen
    (0...@size).map { |row| (0...@size).map { |col| lives_on?(row, col) } }
  end

  def play
    tick = 0; incr = 1
    loop do
      @archive.include?(@grid) ? incr = 0 : @archive << @grid
      sleep(0.3)
      system "clear"
      @grid = next_gen
      puts "tick - #{tick += incr}"
      show_matrix
    end
  end

  def show_board
     puts @grid.map { |row| row.map { |cell| cell ? '*' : ' ' }.inspect }
  end

  def show_matrix(type='dotted')
    for i in 0..@size-1 do
      for j in 0..@size do
        if type === 'dotted'
          print "#{@grid[i][j] ? "*" : " "}"
        else
          print "#{@grid[i][j] ? "█" : "▒"}"
        end
      end
      puts ""
    end

  end

end

cg = CellGame.new 45
cg.play
