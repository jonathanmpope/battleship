require_relative 'ship'

class Cell
  attr_reader :coordinate, :fired
  attr_accessor :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired = false
  end

  def ship
    @ship
  end

  def empty?
    @ship == nil ? true : false
  end

  def place_ship(type)
    @ship = type
  end

  def fired_upon?
    @fired
  end

  def fire_upon
    if @ship == nil
      return @fired = true
    else
      @ship.health -= 1
      @fired = true
    end
  end

  def render(show = false)
    if @fired == true && @ship == nil
      "M"
    elsif @fired == true && @ship != nil && @ship.health != 0
      "H"
    elsif show == true && @ship != nil
      "S"
    elsif @fired == true && @ship != nil && @ship.health == 0
      "X"
    else
      "."
    end
  end

  # def sunk?
  #   @ship.health == 0
  # end

end
