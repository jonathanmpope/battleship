require 'helper'

class Player
  attr_reader :name, :fleet

  def initialize(name)
    @name = name
    @fleet = []
  end

  def make_ship(type, length)
    @fleet << Ship.new(type, length)
  end

  def fleet_health
    @fleet.each {|ship| ship.health}.sum
  end

end
