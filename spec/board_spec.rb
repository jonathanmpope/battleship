require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe do
  let!(:board) {Board.new}
  let!(:cruiser) {Ship.new("Cruiser", 3)}
  let!(:submarine) {Ship.new("Submarine", 2)}

    it "is an instance of" do
      expect(board).to be_instance_of Board
    end

    it "has cells" do
      expect(board.cells).to be_a Hash
      expect(board.cells.count).to eq(16)
    end

    it "has cell objects" do
      expect(board.cells["A1"]).to be_instance_of Cell
    end

    it "can validate coordinates" do
      expect(board.valid_coordinate?("A1")).to be true
      expect(board.valid_coordinate?("D4")).to be true
      expect(board.valid_coordinate?("A5")).to be false
      expect(board.valid_coordinate?("E1")).to be false
      expect(board.valid_coordinate?("A22")).to be false
    end

    it "can check valid placement" do
      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq false
      expect(board.valid_placement?(submarine, ["A1", "A2", "A3"])).to eq false
    end
end
