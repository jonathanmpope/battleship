require_relative 'helper'

module Turn
  def take_shot(coordinate)
    if @board.valid_coordinate?(coordinate)
      @board.cells[coordinate].fire_upon
    end
  end

  def play?
    @player.fleet_health == 0
  end
end