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
      @storage = Array.new(@size * @size, Cell.new)
    end
  end

  def cell_count
    @storage.length * @storage.first.length
  end

  def get_neighbors_from_index(index)
    neighbors = []
    neighbors << cells_to_left_and_right(index)
    neighbors << cells_above(index)
    neighbors << cells_below(index)
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
  def beginning_of_row?(index)
    index % size == 0
  end

  def end_of_row?(index)
    (index + 1) % size == 0
  end

  def last_row?(index)
    index >= (size * size - size)
  end

  def size_matches_state?(size, state)
    (size * size) == state.length
  end

  def cells_to_left_and_right(index)
    cells = []
    cells << @storage[index - 1] unless beginning_of_row?(index)
    cells << @storage[index + 1] unless end_of_row?(index)
    cells
  end

  def cells_above(index)
    cells = []
    return cells if index < size

    cells << @storage[above(index - 1)] unless beginning_of_row?(index)
    cells << @storage[above(index)]
    cells << @storage[above(index + 1)] unless end_of_row?(index)
    cells
  end

  def cells_below(index)
    cells = []
    return cells if last_row?(index)

    cells << @storage[below(index) - 1] unless beginning_of_row?(index)
    cells << @storage[below(index)]
    cells << @storage[below(index) + 1] unless end_of_row?(index)
    cells
  end

  def above(index)
    index - 3
  end

  def below(index)
    index + 3
  end
end

