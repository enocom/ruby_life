Ruby Life
=========

A test-driven implementation of Conway's Game of Life in Ruby.

Usage
=====

1) Install with `gem install ruby_life`

2) Run it with `ruby_life`

The Rules
=========

1. Any live cell with fewer than two live neighbours dies,
   as if caused by under-population.

2. Any live cell with two or three live neighbours
   lives on to the next generation.

3. Any live cell with more than three live
   neighbours dies, as if by overcrowding

4. Any dead cell with exactly three live neighbours
   becomes a live cell, as if by reproduction.

