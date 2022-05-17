require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe do
  let!(:board) {Board.new}
  # let!(:cruiser) {Ship.new("Cruiser", 3}
  # let!(:cruiser) {Ship.new("Cruiser", 3}

    it "is an instance of" do
      expect(board).to be_instance_of Board
    end

    xit "has cells" do

    end
end
