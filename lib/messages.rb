module Messages
  def welcome
    puts "================================================"
    puts "Welcome to BATTLESHIP\n Enter p to play. Enter q to quit."
  end

  def begin_message
    puts "================================================"
    puts "********* UPDATE *********"
    puts "I get the same ships as you and I have laid my ships on the grid."
  end

  def ships_to_be_placed
    puts "================================================"
    puts "Your fleet includes the ships below:\n"
  end

  def ship_placement_rules
      puts "======== SHIP PLACEMENT RULES ========"
    puts "1 - Ships coordinates must match ship length."
    puts "2 - Ships coordinates must be horizontal and ascend in order (A1 A2 A3), or"
    puts "3 - Ships coordinates must be vertical and descend in order (B2 C2 D2)"
  end

  def place_ship
    puts "================================================"
    puts "Enter the coordinates for the #{fleet[0].type} (#{fleet[0].length} coordinates).\nFor example: A1 A2 A3"
    print "> "
  end

  def invalid_coordinates
    puts "================================================"
    puts "❗️You entered #{@input}.\n❗️Those are invalid coordinates.\n❗️Please try again..."
    print "> "
  end

  def your_shot
    puts "Enter the coordinate for your shot:\n"
    print "> "
  end

  def invalid_shot
    puts "Please enter a valid coordinate:\n"
    print "> "
  end

  def shoot_used_cell
    puts "You already shot there, choose again:"
    print "> "
  end

  def line_break
    puts "================================================"
  end

  def computer_board_header
    puts "=============COMPUTER BOARD============="
  end

  def player_board_header
    puts "=============PLAYER BOARD============="
  end

  def board_builder_overview
    puts "First, we need to build a board."
  end

  def board_builder_width
    puts 'Please choose your board width (a number from 4-10):'
    print "> "
  end

  def board_builder_mistake
    puts "Your board height and width cannot be less than 4 units or greater than 20.\n Start over!"
  end

  def board_builder_height
    puts 'Please choose your board height (a number from 4-10):'
    print "> "
  end

  def ship_build?
    puts "Would you like to make your own custom ships?"
    puts "Press Y to build some, or S to skip and receive the default (2) ships:"
    print "> "
  end

  def ship_size_q
    puts "How long of a ship do you want to make?"
    print "> "
  end

  def ship_size_reject
    puts "That's too big. Your ship cannot be bigger than your board. Choose again"
  end

  def another_ship?
    puts "Would you like to build another ship?"
    puts "Press Y to build another one, or S to skip:"
    print "> "
  end

  def ship_ending
    puts "I hope you had fun building ships!"
  end

  def ship_naming
    puts "What is the name of your ship?"
    print "> "
  end

  def ship_too_small
    puts "Your ship can't be zero units long, type in a number (e.g. 3)"
  end

  def i_won
    puts "HAHAHAHAHAHAHA!!!!!!!!!!!!!!!!\nI WON!\nBetter luck next time."
  end

  def you_won
    puts "Fortune must have been smiling upon you today,\nyou somehow beat the mighty computer."
  end

end
