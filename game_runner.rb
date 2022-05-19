require './helper'

class GameRunner
  include Messages
  include Turn

  attr_reader :player, :board

  def initialize(player = 'Player', board)
    @input = ''
    @player = player
    @board = make_board
  end

  def make_board
    @board = Board.new
    @board.cells
  end

  def welcome
    puts messages[:welcome]
    @input = gets.chomp
    check_input
  end

  def check_input
    abort if @input == 'q'
    return begin_game if @input == 'p'
  end

  def begin_game
    puts messages[:begin]
    puts @board.render(true)
    place_ships
  end

  def place_ship
    @player.fleet[0]
    @player.fleet.each do |ship|
      puts messages[:place_ship]
      coordinates = gets.chomp
      @input = coordinates
      check_placement
    end
  end

  def check_placement(coordinates)
    return invalid_coords(coordinates) if @board.valid_placement?(coordinates) == false
    return messages[:invalid_coord] if @board.valid_placement?(coordinates) == false
  end

  def invalid_coords(coordinates)
    puts messages[:invalid_coord]
    @input = gets.chomp
    check_placement
  end

  def shots_taken

  end

  def fleet_health

  end
end
