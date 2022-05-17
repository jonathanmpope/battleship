require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe do
  let!(:board) {Board.new}
  let!(:makes_cells) {board.cells}
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
      expect(board.valid_placement?(submarine, ["A1", "A5"])).to eq false
      expect(board.valid_placement?(submarine, ["A1", "B1"])).to eq true
      expect(board.valid_placement?(submarine, ["A1", "A2", "A3"])).to eq false
      expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq true
      expect(board.valid_placement?(submarine, ["A1", "B2"])).to eq false
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to eq true
    end

    it "can check if space is occupied" do
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to eq true
      board.place(cruiser, ["A1", "A2", "A3"])
      expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq false
    end

    it "can place ships" do
      board.place(cruiser, ["A1", "A2", "A3"])
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]
      cell_1.ship == cell_2.ship
      cell_2.ship == cell_3.ship
    end

    xit "can render board properly" do

    end

    xit "can track cells" do

    end
end