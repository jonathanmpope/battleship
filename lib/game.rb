require './lib/helper'
require './lib/messages'

class Game
  include Messages
  attr_reader :player, :computer, :ship_length

  def initialize
    @player = Player.new('Player 1')
    @computer = Player.new('Computer')
    @ship_length = ship_length
  end

  def start_game
    welcome
    input = gets.chomp
    if input == 'p'
      board_creator
    else
      abort
    end
  end

  def board_creator
    board_builder_width
    width = gets.chomp.to_i
    board_builder_height
    height = gets.chomp.to_i
    height = (height += 64).chr
    @player.board_creation(width, height)
    @computer.board_creation(width, height)
    player_board
  end

  def player_board
    begin_message
    @player.board.render
    computer_setup
  end

  def computer_setup
    @computer.computer_ship_placement
    ship_build
  end

  def ship_build
    ship_build?
    ship_request = gets.chomp.to_s.downcase
      if ship_request == 'y'
        ship_size
      elsif ship_request == 's'
        @player.fleet_build
        setup_game
      else
        ship_build
      end
  end

  def ship_size
    ship_size_q
    @ship_length = gets.chomp.to_i
      if @ship_length > @player.board.width ||  @ship_length > @player.board.width
        ship_size_reject
        ship_size
      elsif @ship_length == 0
        ship_too_small
        ship_size
      else
        ship_name
      end
  end

  def ship_name
    ship_naming
    name = gets.chomp.to_s
    name = @player.make_ship(name, @ship_length)
    another_ship?
    ship_request = gets.chomp.to_s.downcase
      if ship_request == 'y'
        ship_size
      else
        ship_ending
        setup_game
      end
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
    p_shot = gets.chomp
    @computer.player_shot_check(p_shot)
    @computer.fleet_health == 0 ? end_game_p : computer_turn
    computer_turn
  end

  def computer_turn
    shots_available = @player.board.cells.keys
    c_shot = shots_available.sample
    @player.computer_shot_check(c_shot)
    @computer.player_shot_output
    @player.computer_shot_output
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
