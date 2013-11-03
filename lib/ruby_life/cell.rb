module RubyLife
  class Cell
    attr_reader :status

    def initialize(status = nil)
      @status = status ? status : [:alive, :dead].sample
    end

    def alive?
      @status == :alive
    end

    def dead?
      @status == :dead
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
end

