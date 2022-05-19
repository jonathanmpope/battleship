module Turn
  def ship_health
    @ships.sum do |ship|
      ship.health
    end
  end

  def take_shot(coordinate)
    if @board.valid_coordinate?(coordinate)
      @board.cells[coordinate].fire_upon
    end
  end

  def take_shot(coordinate)
    coordinate.fire_upon
  end
end
