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

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def valid_placement?(ship, placement)
    return false if ship.length != placement.length

    letters = []
    numbers = []
    letters_ord = []
    potential_ships = []

    placement.each do |coordinate|
      letters << coordinate[0]
      numbers << coordinate[1].to_i
      potential_ships << @cells[coordinate]
    end

    letters.each do |letter|
      letters_ord << letter.ord
    end

    potential_ships.each do |cell|
      if cell.class == Cell && cell.ship.class == Ship
        return false
      end
    end

    if letters.uniq.size == 1 && numbers[-1] == (numbers[0] + (numbers.count - 1))
      return true
    elsif numbers.uniq.size == 1 && letters_ord[-1] == (letters_ord[0] + (letters.count - 1))
      return true
    else
      return false
    end
  end

  def place(ship, coordinates)
    coordinates.map {|coord| @cells[coord].place_ship(ship)}
  end

  def render(*boolean)

  end

  def track_cells

  end
end
