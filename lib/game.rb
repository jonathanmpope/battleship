require './lib/helper'
require './lib/messages'

class Game
  include Messages
  attr_reader :state,
              :player,
              :computer,
              :input,
              :ships_placed,
              :c_ships,
              :c_board,
              :p_shot_result,
              :p_shot

  def initialize
    @state = 'new'
    @player = Player.new('Player 1')
    @computer = Player.new('Computer')
    @input = ''
    @ships_placed = []
    @c_board = @computer.board
    @c_ships = @computer.fleet
  end

  def p1_ships
    ships =  @player.fleet
    ships.map do |ship|
      puts "#{ship.type}: #{ship.length} units"
    end
  end

  def p1_ship_name(which)
    @player.fleet[which].type
  end

  def p1_board
    @player.board
  end

  def computer_ship_name(index)
    @computer.fleet[index].type
  end

  def computer_board
    @computer.board
  end

  def start_game
    line_break
    welcome
    @input = gets.chomp
    if @input == 'p'
      line_break
      begin_message
      p1_board.render(true)
      setup_game
    else
      abort
    end
  end

  def setup_game
    line_break
    ships_to_be_placed
    p1_ships
    ships_placed = []
    until ships_placed.length == @player.fleet.length do
      line_break
      place_ship
      @input = gets.chomp
      @input = @input.split(' ')
      ship = @player.fleet.first
      if p1_board.valid_placement?(ship, @input) == true
        p1_board.place(ship, @input)
        ships_placed << ship
        @player.fleet.rotate!
      else
        line_break
        invalid_coordinates
      end
    end
    computer_setup
  end

  def computer_setup
    until @ships_placed.length == @computer.fleet.length do
      hor_places = computer_board.coordinates.each_cons(@c_ships[0].length).to_a
      vert_places = computer_board.vert_coords.each_cons(@c_ships[0].length).to_a
      possibles = hor_places.concat(vert_places)
      coordinates = possibles.sample
      ship = @c_ships[0]
      if computer_board.valid_placement?(ship, coordinates) == true
        computer_board.place(ship, coordinates)
        @ships_placed << ship
        coordinates = []
        @c_ships.rotate!
      else
        computer_setup
      end
    end
    player_turn
  end

  def player_turn
    puts '=============COMPUTER BOARD============='
    puts @computer.board.render
    puts '=============PLAYER BOARD============='
    puts @player.board.render(true)
    your_shot
    player_shot
  end

  def player_shot
    @p_shot = gets.chomp
    if @computer.board.take_shot(@p_shot) == false
        invalid_shot
        player_shot
    elsif @computer.board.cells[@p_shot].render == "M" || @computer.board.cells[@p_shot].render == "H" || @computer.board.cells[@p_shot].render == "X"
      puts "You already shot there, choose again:"
      player_shot
    else
      @computer.board.cells[@p_shot].fire_upon
    end
    @p_shot_result = @computer.board.cells[@p_shot].render
      if @p_shot_result == "M"
        @p_shot_result = "was a miss!"
      elsif @p_shot_result == "H"
        @p_shot_result = "was a direct hit!"
      elsif @p_shot_result == "X"
        @p_shot_result = "sunk a ship!"
      end
    @computer.fleet_health == 0 ? end_game_p : computer_turn
    computer_turn
  end

  def computer_turn
    shots_available = @player.board.cells.keys
    c_shot = shots_available.sample
    if @player.board.cells[c_shot].render == "M" || @player.board.cells[c_shot].render == "H" || @player.board.cells[c_shot].render == "X"
      computer_turn
    else
      @player.board.cells[c_shot].fire_upon
    end
    c_shot_result = @player.board.cells[c_shot].render
      if c_shot_result == "M"
        c_shot_result = "was a miss!"
      elsif c_shot_result == "H"
        c_shot_result = "was a direct hit!"
      elsif c_shot_result == "X"
        c_shot_result = "sunk a ship!"
      end
    puts "Your shot at #{@p_shot} #{@p_shot_result}"
    puts "My shot on #{c_shot} #{c_shot_result}"
    if @player.fleet_health == 0
      end_game_c
    else
      player_turn
    end
  end

  def end_game_p
    puts "You won!"
    game = Game.new
    game.start_game
  end

  def end_game_c
    puts "I won!"
    game = Game.new
    game.start_game
  end

end
