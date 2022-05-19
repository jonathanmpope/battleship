puts 'Please choose your board width (a number from 1-20):'
width = gets.chomp.to_i
puts 'Please choose your board height (a number from 1-20):'
height = gets.chomp.to_i
height = (height += 65).chr

#inputs would go into the board creation as arguments
board = Board.new(width, height)


# The Board object has default values for width and height,
# so, if you create a Board.new object, it will create a
# normal 4 x 4 board. 
