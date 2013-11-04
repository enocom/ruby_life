module RubyLife
  class Game
    def initialize
      @grid = Grid.new(3)
    end

    def run
      clear_screen

      loop do
        puts @grid
        animate_transition
        @grid.generate!
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

