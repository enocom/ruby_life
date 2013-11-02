class Cell
  attr_reader :status

  def initialize(status = nil)
    @status = status ? status : [:alive, :dead].sample
  end

  def alive?
    @status == :alive
  end

  def die!
    @status = :dead
  end

  def live!
    @status = :alive
  end

  def to_s
    alive? ? "o" : "."
  end
end

class BadInitialState < StandardError; end

class Grid
  attr_reader :size

  def initialize(size, state: nil)
    @size = size
    if state
      raise BadInitialState unless size_matches_state?(size, state)

      @storage = state.map { |status| Cell.new(status) }
    else
      @storage = Array.new(@size, Cell.new)
    end
  end

  def cell_count
    @storage.length * @storage.first.length
  end

  def get_neighbors(x, y)
    neighbors = []
    neighbors << cells_to_left_and_right(x, y)
    neighbors << cells_above(x, y) unless y.zero?
    neighbors << cells_below(x, y) unless y == (size - 1)
    neighbors.flatten
  end

  def [](x, y)
    @storage[x + (y * size)]
  end

  def to_s
    grid_string = ""

    @storage.each_with_index do |cell, index|
      grid_string += " #{cell}"
      grid_string += "\n" if end_of_row?(index)
    end

    grid_string
  end

  def generate!
    @storage.each(&:die!)
  end

  def state
    @storage.map(&:status)
  end

  private
    def end_of_row?(index)
      (index + 1) % size == 0
    end

    def size_matches_state?(size, state)
      (size * size) == state.length
    end

    def cells_to_left_and_right(x, y)
      cells = []
      cells << self[x - 1, y] unless x.zero?
      cells << self[x + 1, y] unless x == (size - 1)
      cells
    end

    def cells_above(x, y)
      cells = []
      cells << self[x - 1, y - 1] unless x.zero?
      cells << self[x, y - 1]
      cells << self[x + 1, y - 1] unless x == (size - 1)
      cells
    end

    def cells_below(x, y)
      cells = []
      cells << self[x -1, y + 1] unless x.zero?
      cells << self[x, y + 1]
      cells << self[x + 1, y + 1] unless x == (size - 1)
      cells
    end
end

