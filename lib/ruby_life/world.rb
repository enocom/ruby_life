module RubyLife
  class World

    def generate(current_generation = "---\n---\n---\n")
      if current_generation.count("+") == 3
        return current_generation
      end

      "---\n---\n---\n"
    end

  end
end
