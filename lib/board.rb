require_relative 'helper'

class Board
  include Turn
  attr_reader :cells,
              :coordinates,
              :vert_coords,
              :letters,
              :nums

  attr_accessor :height, :width

  def initialize (width = 4, height = "D")
    @height = height
    @width = width
    @letters = letters
    @nums = nums
    @coordinates = make_horizontal_coordinates
    @vert_coords = make_vertical_coordinates
    @cells = make_cells
    # @player = current_player
  end

  def make_horizontal_coordinates
    @letters = ("A"..height).to_a
    @nums = (1..width).to_a
    @coordinates = letters.product(nums).map {|coord| coord.join('')}
  end

  def make_vertical_coordinates
    @letters = ("A"..height).to_a
    @nums = (1..width).to_a
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

    placement.each do |cell|
      if valid_coordinate?(cell) == false
        return false
      end
    end

    placement.each do |coord|
      if @cells[coord].ship != nil
        return false
      end
    end

    letters = []
    numbers = []
    letters_ord = []

    placement.each do |coordinate|
      letters << coordinate[0]
      numbers << coordinate[1].to_i
    end

    letters.each do |letter|
      letters_ord << letter.ord
    end

    if letters.uniq.size == 1 && numbers[-1] == (numbers[0] + (numbers.count - 1))
      return true
    elsif numbers.uniq.size == 1 && letters_ord[-1] == (letters_ord[0] + (letters.count - 1))
      return true
    else
      return false
    end
  end

  def place(ship_object, coordinates)
    #place ship class object instead of just ship name
    #so that ship object is linked to cell
    coordinates.map do |coord|
      @cells[coord].place_ship(ship_object)
    end
  end

  def render(boolean = false)
    index = 0
    index_2 = 0
    index_3 = 0
    array = []
    final_board = ""

    final_board.concat("  #{nums * " "}\n")
    while index < (letters.length)
      while index_2 < (index_3 + (@nums.length))
        array << @cells[@coordinates[index_2]].render(boolean)
        index_2 += 1
      end
    final_board.concat("#{@letters[index]} #{array * " "}\n")
    index_2
    index_3 += @nums.length
    array.clear
    index += 1
    end
    final_board
  end

  def track_cells(cell)
      if valid_coordinate?(cell) == false
        return "You can't do that idiot! Choose again!"
      end
      @cells[cell].fire_upon
      puts render
  end
end
