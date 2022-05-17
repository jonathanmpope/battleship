require_relative 'ship'

class Cell
  attr_reader :coordinate, :ship, :fired
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

end
