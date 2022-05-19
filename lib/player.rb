require 'helper'

class Player
  include Turn
  attr_reader :name,
              :fleet,
              :fleet_health,
              :board

  def initialize(name)
    @name = name
    @fleet = []
    @fleet_health = fleet_health
    @board = Board.new
  end

  def make_ship(type, length)
    @fleet << Ship.new(type, length)
  end

  def fleet_health
    @fleet.empty? ? return : @fleet_health = @fleet.sum {|ship| ship.health}
  end

end
