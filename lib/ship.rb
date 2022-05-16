class Ship
  attr_reader :type, :length, :health

  def initialize(type, length)
    @type = type
    @length = length
    @health = length
  end

  def health
    @health
  end

  def sunk?
    @health == 0
  end

  def hit
    @health -= 1
  end
end
