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

    it "has cells" do
      expect(board.cells).to be_a Hash
      expect(board.cells.count).to eq(16)
    end

    it "has cell objects" do
      expect(board["A1"]).to be_instance_of Cell
    end
end
