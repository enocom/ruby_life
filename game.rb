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

  def get_neighbors_from_index(index)
    indices_to_retrieve = []
    indices_to_retrieve << (index - 1) unless beginning_of_row?(index)
    indices_to_retrieve << (index + 1) unless end_of_row?(index)

    unless first_row?(index)
      indices_to_retrieve << (above(index - 1)) unless beginning_of_row?(index)
      indices_to_retrieve << (above(index + 1)) unless end_of_row?(index)
      indices_to_retrieve << (above(index))
    end

    unless last_row?(index)
      indices_to_retrieve << (below(index) - 1) unless beginning_of_row?(index)
      indices_to_retrieve << (below(index) + 1) unless end_of_row?(index)
      indices_to_retrieve << (below(index))
    end

    indices_to_retrieve.map { |i| @storage[i] }
  end

  def [](x, y)
    @storage[x + (y * size)]
  end

  def generate!
    next_generation = {}

    @storage.each_with_index do |cell, index|
      neighbors = get_neighbors_from_index(index)
      living_neighbor_count = neighbors.select(&:alive?).count
      if cell.alive? && [2, 3].include?(living_neighbor_count)
        next_generation[index] = :alive
      else
        next_generation[index] = :dead
      end
    end

    next_generation.each do |index, status|
      if status == :alive
        @storage[index].live!
      else
        @storage[index].die!
      end
    end
  end

  def state
    @storage.map(&:status)
  end

  def to_s
    grid_string = ""

    @storage.each_with_index do |cell, index|
      grid_string += " #{cell}"
      grid_string += "\n" if end_of_row?(index)
    end

    grid_string
  end

  private
  def beginning_of_row?(index)
    index % size == 0
  end

  def end_of_row?(index)
    (index + 1) % size == 0
  end

  def first_row?(index)
    index < size
  end

  def last_row?(index)
    index >= (size * size - size)
  end

  def size_matches_state?(size, state)
    (size * size) == state.length
  end

  def above(index)
    index - 3
  end

  def below(index)
    index + 3
  end
end

