require 'rspec'
require_relative 'game'

describe Cell do
  let(:cell) { Cell.new }

  it 'can live and die' do
    cell.live!
    expect(cell.alive?).to be_true
    cell.die!
    expect(cell.alive?).to be_false
  end

  it 'takes an optional status' do
    dead_cell = Cell.new(:dead)
    expect(dead_cell.alive?).to be_false
  end
end

describe Grid do
  let(:grid) { Grid.new(3) }

  it 'accepts a dimension as an argument' do
    expect(grid.state.length).to eq 9
  end

  it 'can retrieve cells from the grid' do
    grid = Grid.new(3, state: [:dead, :dead, :dead,
                               :dead, :alive, :dead,
                               :dead, :dead, :dead])
    expect(grid[1,1].alive?).to be_true

    grid = Grid.new(3, state: [:dead, :alive, :dead,
                               :dead, :dead, :dead,
                               :dead, :dead, :dead])
    expect(grid[1,0].alive?).to be_true

    grid = Grid.new(3, state: [:dead, :dead, :dead,
                               :dead, :dead, :dead,
                               :dead, :alive, :dead])
    expect(grid[1,2].alive?).to be_true
  end

  context 'specifying an initial state' do
    it 'accepts an initial state' do
      grid = Grid.new(2, state: [:dead, :alive, :dead, :alive])
      expect(grid[0, 0].alive?).to be_false
      expect(grid[1, 1].alive?).to be_true
    end

    it 'raises an error when passed mismatching dimensions and state' do
      expect {
        Grid.new(2, state: [:dead])
      }.to raise_error(BadInitialState)

      expect {
        Grid.new(2, state: [:dead, :alive, :dead])
      }.to raise_error(BadInitialState)
    end
  end

  context 'retrieving neighboring cells' do
    it 'finds neighbors of cells away from edges' do
      expect(grid.get_neighbors_from_index(4).size).to eq 8
    end

    it 'finds neighbors of the corner cells' do
      expect(grid.get_neighbors_from_index(0).size).to eq 3
      expect(grid.get_neighbors_from_index(2).size).to eq 3
      expect(grid.get_neighbors_from_index(6).size).to eq 3
      expect(grid.get_neighbors_from_index(8).size).to eq 3
    end

    it 'finds neighbors of the edge cells' do
      expect(grid.get_neighbors_from_index(1).size).to eq 5
      expect(grid.get_neighbors_from_index(3).size).to eq 5
      expect(grid.get_neighbors_from_index(5).size).to eq 5
      expect(grid.get_neighbors_from_index(7).size).to eq 5
    end
  end

  context 'printing the grid' do
    it 'renders the live and dead cells' do
      grid = Grid.new(2, state: [:dead, :alive, :alive, :dead])
      expected_grid =" . o\n o .\n"
      expect(grid.to_s).to eq expected_grid
    end
  end

  context 'generations' do
    specify 'any live cell with fewer than two live neighbors dies' do
      grid = Grid.new(3, state: [:dead, :dead,  :dead,
                                 :dead, :alive, :dead,
                                 :dead, :dead,  :dead])
      grid.generate!

      expect(grid.state).to eq [:dead, :dead, :dead,
                                :dead, :dead, :dead,
                                :dead, :dead, :dead]
    end

    xspecify 'any live cell with two or three live neighbors lives' do
      grid = Grid.new(3, state: [:dead,  :dead,  :dead,
                                 :alive, :alive, :alive,
                                 :dead,  :dead,  :dead])
      grid.generate!

      expect(grid.state).to eq [:dead, :dead,  :dead,
                                :dead, :alive, :dead,
                                :dead, :dead,  :dead]
    end
  end
end
