module Messages
  def welcome
    puts "Welcome to BATTLESHIP\n Enter p to play. Enter q to quit."
  end

  def begin_message
    puts "I have laid out my ships on the grid.\nYou now need to lay out your two ships.\nThe Cruiser is 3 units long and the Submarine is 2 units long."
  end

  def ships_to_be_placed
    puts "Your fleet includes the ships below:\n"
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

end
