require "spec_helper"

module RubyLife
  describe World do

    it "generates a population" do
      living_or_dead_cells = /(?:[-\+]{3}\n){3}/
      expect(World.new.generate).to match(living_or_dead_cells)
    end

    # Rule 1
    it "kills a single living cell" do
      single_living_cell = "---\n---\n--+\n"
      expect(World.new.generate(single_living_cell)).to eq "---\n---\n---\n"
    end

    # Rule 1
    it "kills two living cells" do
      two_living_cells = "+--\n---\n--+\n"
      expect(World.new.generate(two_living_cells)).to eq "---\n---\n---\n"
    end

    it "lets live a single cell with two neighbors" do
      two_neighbors = "---\n+++\n---\n"
      expect(World.new.generate(two_neighbors)).to eq two_neighbors
    end

  end
end
