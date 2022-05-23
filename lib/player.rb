require './lib/messages'
require './lib/helper'

class Player
  include Messages
  attr_reader :name,
              :fleet,
              :fleet_health,
              :board,
              :p_shot,
              :c_shot,
              :coordinates

  def initialize(name)
    @name = name
    @fleet = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @fleet_health = fleet_health
    @board = Board.new
    @p_shot = ''
    @c_shot = ''
    @coordinates = ''
  end

  def fleet_health
    @fleet.empty? ? "No ships here..." : @fleet_health = @fleet.sum {|ship| ship.health}
  end

  def player_ships
    ships =  @fleet
    ships.map do |ship|
      puts "#{ship.type}: #{ship.length} units"
    end
  end

  def player_ship_placement
    ships_placed = []
    until ships_placed.length == @fleet.length do
      line_break
      place_ship
      @input = gets.chomp
      @input = @input.split(' ')
      ship = @fleet.first
      if @board.valid_placement?(ship, @input) == true
        @board.place(ship, @input)
        ships_placed << ship
        @fleet.rotate!
      else
        line_break
        invalid_coordinates
      end
    end
  end

  def computer_ship_grids
    hor_places = @board.coordinates.each_cons(@fleet[0].length).to_a
    vert_places = @board.vert_coords.each_cons(@fleet[0].length).to_a
    possibles = hor_places.concat(vert_places)
    @coordinates = possibles.sample
  end

  def computer_ship_placement
    ships_placed = []
    until ships_placed.length == @fleet.length do
      computer_ship_grids
      ship = @fleet[0]
      if @board.valid_placement?(ship, @coordinates) == true
        @board.place(ship, @coordinates)
        ships_placed << ship
        @fleet.rotate!
      end
    end
  end

  def player_shot_check(shot)
    if @board.valid_coordinate?(shot) == false
      invalid_shot
      p_shot = gets.chomp
      player_shot_check(p_shot)
    elsif @board.cells[shot].render == "M" || @board.cells[shot].render == "H" || @board.cells[shot].render == "X"
      shoot_used_cell
      p_shot = gets.chomp
      player_shot_check(p_shot)
    else
      @board.cells[shot].fire_upon
      @p_shot = shot
    end
  end

  def computer_shot_check(shot)
    if @board.cells[shot].render == "M" || @board.cells[shot].render == "H" || @board.cells[shot].render == "X"
      shots_available = @board.cells.keys
      c_shot = shots_available.sample
      computer_shot_check(c_shot)
    else
      @board.cells[shot].fire_upon
      @c_shot = shot
    end
  end

  def player_shot_output
    p_shot_result = @board.cells[@p_shot].render
      if p_shot_result == "M"
        p_shot_result = "was a miss!"
      elsif p_shot_result == "H"
        p_shot_result = "was a direct hit!"
      elsif p_shot_result == "X"
        p_shot_result = "sunk a ship!"
      end
    puts "Your shot at #{@p_shot} #{p_shot_result}"
  end

  def computer_shot_output
    c_shot_result = @board.cells[@c_shot].render
      if c_shot_result == "M"
        c_shot_result = "was a miss!"
      elsif c_shot_result == "H"
        c_shot_result = "was a direct hit!"
      elsif c_shot_result == "X"
        c_shot_result = "sunk a ship!"
      end
    puts "My shot on #{@c_shot} #{c_shot_result}"
  end

    # def make_ship(type, length)
    #   @fleet << Ship.new(type, length)
    # end
end
