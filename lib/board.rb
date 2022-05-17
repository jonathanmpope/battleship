require_relative 'helper'

class Board
  attr_reader :cells, :coordinates, :vert_coords

  def initialize
    @coordinates = make_horizontal_coordinates
    @vert_coords = make_vertical_coordinates
    @cells = make_cells
  end

  def make_horizontal_coordinates
    letters = ("A".."D").to_a
    nums = (1..4).to_a
    @coordinates = letters.product(nums).map {|coord| coord.join('')}
  end

  def make_vertical_coordinates
    letters = ("A".."D").to_a
    nums = (1..4).to_a
    @vert_coords = nums.product(letters).map {|num| num.join('').reverse}
  end

  def make_cells
    @cells = @coordinates.to_h {|cell| [cell, Cell.new(cell)]}
  end

  def render(*boolean)

  end

  def track_cells

  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end


  def valid_placement?(ship, placement)
    horiz_check = @coordinates.each_cons(placement.length)
    vert_check = @vert_coords.each_cons(placement.length)
    return false if ship.length != placement.length
    horiz_check.any?(placement) || vert_check.any?(placement)
  end
end
