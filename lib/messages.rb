module Messages
  def messages
    {
      welcome: "Welcome to BATTLESHIP\n
              Enter p to play. Enter q to quit.",
      begin: "I have laid out my ships on the grid.\n
              You now need to lay out your two ships.\n
              The Cruiser is three units long and the Submarine is two units long.",
      place_ship: "Enter the squares for the #{ship} (#{ship.length} spaces):\n
              > ",
      invalid_coord: "You entered #{coordinates}.\n
              Those are invalid coordinates.\n
              Please try again:\n
              > ",
      take_shot: "Enter the coordinate for your shot:\n
              > ",
      invalid_shot: "#{coordinate} is not a valid coordinate.\n
              Please enter a valid coordinate:\n
              > ",
      board: "=============#{player.name}'s BOARD=============",
      player_result: "Your shot on #{coordinate} was a miss.",
      comp_result: "My shot on #{coordinate} was a miss.",
      game_result: "#{winner} won!"
    }
  end
