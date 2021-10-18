class Board  
  RELATIVE_NEIGHBOUR_COORDINATES = { 
    north: [-1, 0].freeze, north_east: [-1, 1].freeze,
    east: [0, 1].freeze, south_east: [1, 1].freeze,
    south: [1, 0].freeze, south_west: [1, -1].freeze,
    west: [0, -1].freeze, north_west: [-1, -1].freeze
  }.freeze

  def initialize(width, height, cell, cells = [])
    @width = width
    @height = height

    @cells = Array.new(width * height).map! { cell.new(rand(3).zero?) }
    @grid = @cells.each_slice(width).to_a

    cells.each { |coordinate| @grid.dig(*coordinate).live!}
    @grid_history = Array.new()
  end

  def to_s
    @grid.map { |line| line.map(&:to_s).join }.join("\n")
  end

  def evolve
    @grid.each_with_index do |line, y|
      line.each_with_index do |cell, x|
        cell.check(life_neighbours_count(x, y))
      end
    end

    save_history
    @cells.each(&:change!)
  end

  def life_neighbours_count(x, y)
    neighbours(x, y).count(&:alive?)
  end

  def lifeness?
    return true if @cells.count(&:alive?).zero?
    return true if @cells.map(&:will_change?).all?(false)

    false
  end

  def save_history
    if @grid_history.length  < 4 
      @grid_history << @grid
      @grid_history.delete(@grid_history.first)
    end

    p @grid_history


  end

  def stagnation?
    p @grid_history.length

  end

  def neighbours(x, y)
    RELATIVE_NEIGHBOUR_COORDINATES.map do |position_name, (relative_y, relative_x)|
      new_x = x + relative_x
      new_y = y + relative_y

      new_x = new_x >= @width ? new_x - @width : new_x
      new_y = new_y >= @height ? new_y - @height : new_y

      @grid.dig(new_y, new_x)
    end.compact
  end
end

