# puts 'Please choose your board width (a number from 1-20):'
# width = gets.chomp.to_i
# puts 'Please choose your board height (a number from 1-20):'
# height = gets.chomp.to_i
# height = (height += 65).chr
#
# #inputs would go into the board creation as arguments
# board = Board.new(width, height)


# The Board object has default values for width and height,
# so, if you create a Board.new object, it will create a
# normal 4 x 4 board.

def ship_build
  ship_build?
  ship_request = gets.chomp.to_s.downcase
    if ship_request == 'y'
      ship_size
    elsif ship_request == 's'
      @player.fleet_build
    else
      ship_build
    end
end

def ship_size
  ship_size_q
  @ship_size = gets.chomp.to_i
    if @ship_size > @player.board.width ||  ship_size > @player.board.width
      ship_size_reject
      ship_size
    else
      ship_name
    end
end

def ship_name
  puts "What is the name of your ship?"
  name = gets.chomp.to_s
  name = @player.make_ship(name, @ship_size)
  another_ship?
  ship_request = gets.chomp.to_s.downcase
    if ship_request == 'y'
      ship_size
    else
      ship_ending
      setup_game
    end
end
