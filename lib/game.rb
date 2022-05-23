require './lib/helper'
require './lib/messages'

class Game
  include Messages
  attr_reader :player, :computer, :p_shot, :p_shot_result

  def initialize
    @player = Player.new('Player 1')
    @computer = Player.new('Computer')
    @p_shot = ''
    @p_shot_result = ''
  end

  def start_game
    line_break
    welcome
    @input = gets.chomp
    if @input == 'p'
      line_break
      begin_message
      @player.board.render(true)
      computer_setup
    else
      abort
    end
  end

  def computer_setup
    @computer.computer_ship_placement(@computer)
    setup_game
  end

  def setup_game
    line_break
    ships_to_be_placed
    @player.player_ships
    puts @player.board.render
    @player.player_ship_placement
    player_turn
  end

  def player_turn
    computer_board_header
    puts @computer.board.render
    player_board_header
    puts @player.board.render(true)
    your_shot
    player_shot
  end

  def player_shot
    @p_shot = gets.chomp
    if @computer.board.valid_coordinate?(@p_shot) == false
      invalid_shot
      player_shot
    elsif @computer.board.cells[@p_shot].render == "M" || @computer.board.cells[@p_shot].render == "H" || @computer.board.cells[@p_shot].render == "X"
      shoot_used_cell
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
    @player.fleet_health == 0 ? end_game_c : player_turn
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

# old methods - saving until game works properly

# def setup_game
#   line_break
#   ships_to_be_placed
#   @player.player_ships(@player)
#   puts @player.board.render
#   @player.player_ship_placement(@player)
#   ships_placed = []
#   until ships_placed.length == @player.fleet.length do
#     line_break
#     place_ship
#     @input = gets.chomp
#     @input = @input.split(' ')
#     ship = @player.fleet.first
#     if p1_board.valid_placement?(ship, @input) == true
#       p1_board.place(ship, @input)
#       ships_placed << ship
#       @player.fleet.rotate!
#     else
#       line_break
#       invalid_coordinates
#     end
#   end
#   computer_setup
# end

# def computer_setup
#   @computer.computer_ship_placement(@computer)
#   until @ships_placed.length == @computer.fleet.length do
#     hor_places = computer_board.coordinates.each_cons(@c_ships[0].length).to_a
#     vert_places = computer_board.vert_coords.each_cons(@c_ships[0].length).to_a
#     possibles = hor_places.concat(vert_places)
#     coordinates = possibles.sample
#     ship = @c_ships[0]
#     if computer_board.valid_placement?(ship, coordinates) == true
#       computer_board.place(ship, coordinates)
#       @ships_placed << ship
#       coordinates = []
#       @c_ships.rotate!
#     else
#       computer_setup
#     end
#   end
#   puts @computer.board.render(true)
#   player_turn
# end
