class Board
  attr_reader :cells, :coordinates, :vert_coords, :letters, :nums, :pl_letters, :pl_numbers, :letters_ord, :final_board

  attr_accessor :height, :width

  def initialize (width = 4, height = "D")
    @height = height
    @width = width
    @letters = letters
    @nums = nums
    @coordinates = make_horizontal_coordinates
    @vert_coords = make_vertical_coordinates
    @cells = make_cells
    @pl_numbers = []
    @pl_letters = []
    @letters_ord = []
    @final_board = ""
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

  def ship_same_length?(ship, placement)
    return false if ship.length != placement.length
  end

  def ship_valid_coordinates?(placement)
    placement.each do |cell|
      if valid_coordinate?(cell) == false
        return false
      end
    end
  end

  def ship_present?(placement)
    placement.each do |coord|
      if @cells[coord].ship != nil
        return false
      end
    end
  end

  def placement_map(placement)
    placement.each do |coordinate|
      @pl_letters << coordinate[0]
      @pl_numbers << coordinate[1].to_i
    end
    @pl_letters.each do |letter|
      @letters_ord << letter.ord
    end
  end

  def vert_hor_check
    if @pl_letters.uniq.size == 1 && @pl_numbers[-1] == (@pl_numbers[0] + (@pl_numbers.count - 1))
      clear_arrays
      return true
    elsif @pl_numbers.uniq.size == 1 && @letters_ord[-1] == (@letters_ord[0] + (@pl_letters.count - 1))
      clear_arrays
      return true
    else
      clear_arrays
      return false
    end
  end

  def clear_arrays
    @pl_numbers.clear
    @pl_letters.clear
    @letters_ord.clear
  end

  def valid_placement?(ship, placement)
    if ship_same_length?(ship, placement) == false || ship_valid_coordinates?(placement) == false || ship_present?(placement) == false
      return false
    end
    placement_map(placement)
    vert_hor_check
  end

  def place(ship, coordinates)
    coordinates.map {|coord| @cells[coord].place_ship(ship)}
  end

  def render(boolean = false)
      index = 0
      index_2 = 0
      index_3 = 0
      array = []
      final_board = ""
      final_board.concat("  #{nums * " "}\n")
      (letters.length).times do
        while index_2 < (index_3 + (@nums.length))
          array << @cells[@coordinates[index_2]].render(boolean)
          index_2 += 1
        end
      final_board.concat("#{@letters[index]} #{array * " "}\n")
      index_3 += @nums.length
      array.clear
      index += 1
      end
    final_board
  end

end
