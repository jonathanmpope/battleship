require './lib/helper'
require './lib/messages'

class Game
  include Messages
  attr_reader :player, :computer, :ship_length, :width, :height

  def initialize
    @player = Player.new('Player 1')
    @computer = Player.new('Computer')
    @ship_length = ship_length
    @width = width
    @height = height
  end

  def start_game
    welcome
    input = gets.chomp
    if input == 'p'
      board_creator_1
    else
      abort
    end
  end

  def board_creator_1
    board_builder_overview
    board_builder_width
    @width = gets.chomp.to_i
      if @width > 20 || @width < 4
        board_builder_mistake
        board_creator_1
      end
    board_creator_2
  end

  def board_creator_2
    board_builder_height
    @height = gets.chomp.to_i
      if @height > 20 || @height < 4
        board_builder_mistake
        board_creator_1
      end
    @height = (@height += 64).chr
    board_creator_3
  end

  def board_creator_3
    @player.board_creation(@width, @height)
    @computer.board_creation(@width, @height)
    player_board
  end

  def player_board
    @player.board.render
    ship_build
  end

  def ship_build
    ship_build?
    ship_request = gets.chomp.to_s.downcase
      if ship_request == 'y'
        ship_size
      elsif ship_request == 's'
        @player.fleet_build
        @computer.fleet_build
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
    name = @computer.make_ship(name, @ship_length)
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
    ship_placement_rules
    ships_to_be_placed
    @player.player_ships
    puts @player.board.render
    @player.player_ship_placement
    computer_setup
  end

  def computer_setup
    @computer.computer_ship_placement
    begin_message
    player_turn
  end

  def player_turn
    computer_board_header
    puts @computer.board.render(true)
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
    @computer.player_shot_output
    you_won
    game = Game.new
    game.start_game
  end

  def end_game_c
    i_won
    game = Game.new
    game.start_game
  end

end
