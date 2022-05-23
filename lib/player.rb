require './lib/messages'
require './lib/helper'

class Player
  include Messages
  attr_reader :name,
              :fleet,
              :fleet_health,
              :board

  def initialize(name)
    @name = name
    @fleet = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @fleet_health = fleet_health
    @board = Board.new
  end

  def fleet_health
    @fleet.empty? ? "No ships here..." : @fleet_health = @fleet.sum {|ship| ship.health}
  end

  def player_ships(player)
    ships =  player.fleet
    ships.map do |ship|
      puts "#{ship.type}: #{ship.length} units"
    end
  end

  def player_ship_placement(player)
    ships_placed = []
    until ships_placed.length == player.fleet.length do
      line_break
      place_ship
      @input = gets.chomp
      @input = @input.split(' ')
      ship = player.fleet.first
      if player.board.valid_placement?(ship, @input) == true
        player.board.place(ship, @input)
        ships_placed << ship
        player.fleet.rotate!
      else
        line_break
        invalid_coordinates
      end
    end
  end

  def computer_ship_placement(computer)
    ships_placed = []
    until ships_placed.length == computer.fleet.length do
      hor_places = computer.board.coordinates.each_cons(computer.fleet[0].length).to_a
      vert_places = computer.board.vert_coords.each_cons(computer.fleet[0].length).to_a
      possibles = hor_places.concat(vert_places)
      coordinates = possibles.sample
      ship = computer.fleet[0]
      if computer.board.valid_placement?(ship, coordinates) == true
        computer.board.place(ship, coordinates)
        ships_placed << ship
        computer.fleet.rotate!
      # else
      #   computer_ship_placement(computer)
      end
    end
  end

    # def make_ship(type, length)
    #   @fleet << Ship.new(type, length)
    # end
end
