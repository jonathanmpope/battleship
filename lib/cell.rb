require_relative 'ship'

class Cell
  attr_reader :coordinate, :ship, :fired

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
    # @ship.health -= 1
    @fired = true
  end

end
