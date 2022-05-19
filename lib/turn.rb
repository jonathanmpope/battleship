module Turn
  def take_shot(coordinate)
    if @board.valid_coordinate?(coordinate)
      @board.cells[coordinate].fire_upon
    end
  end

  def loser?
    @player.fleet_health == 0
  end
end
