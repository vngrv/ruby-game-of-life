class Board  
  RELATIVE_NEIGHBOUR_COORDINATES = { 
    north: [-1, 0].freeze, north_east: [-1, 1].freeze,
    east: [0, 1].freeze, south_east: [1, 1].freeze,
    south: [1, 0].freeze, south_west: [1, -1].freeze,
    west: [0, -1].freeze, north_west: [-1, -1].freeze
  }.freeze

  def initialize(width, height, cell, cells = [])
    @cells = Array.new(width * height).map! { cell.new(rand(3).zero?) }
    @grid = @cells.each_slice(width).to_a

    cells.each { |coordinate| @grid.dig(*coordinate).live!}
  end

  def to_s
    @grid.map { |line| line.map(&:to_s).join }.join("\n")
  end

  def evolve
    @grid.each_with_index do |line, y|
      line.each_with_index do |cell, x|
        if cell.alive?
          cell.will_change = !(2..3).include?(life_neighbours_count(x, y))
        else
          cell.will_change = life_neighbours_count(x, y) == 3
        end
      end
    end
    
    @cells.each(&:change!)

  end

  def life_neighbours_count(x, y)
    neighbours(x, y).count(&:alive?)
  end

  def lifeness?
    false
  end

  def neighbours(x, y)
    RELATIVE_NEIGHBOUR_COORDINATES.map do |position_name, (relative_y, relative_x)|
      next if y + relative_y < 0 || x + relative_x < 0
      @grid.dig(y + relative_y, x + relative_x)
    end.compact
  end

  ### depricated ###

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

