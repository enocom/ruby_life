module RubyLife
  class Game
    def initialize
      @grid = Grid.new(40)
    end

    def run
      clear_screen

      i = 0
      loop do
        puts "generation #{i}"
        puts @grid
        @grid.generate!
        animate_transition
        i += 1
      end
    end

    private
    def clear_screen
      print "\e[H\e[2J"
    end

    def animate_transition
      sleep 1
      clear_screen
    end
  end
end

