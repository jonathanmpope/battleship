require 'spec_helper'

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

    it "has a height" do
      expect(board.height).to eq("D")
    end

    it "has a width" do
      expect(board.width).to eq(4)
    end

    it "has cell objects" do
      expect(board.cells["A1"]).to be_instance_of Cell
    end

    it "has letters and numbers" do
      board.make_horizontal_coordinates
      expect(board.letters[0]).to eq("A")
      expect(board.nums[0]).to eq(1)
    end

    it "can make make horizontal and vertical coordinates" do
      expect(board.make_horizontal_coordinates.class).to eq(Array)
      expect(board.make_vertical_coordinates.class).to eq(Array)
    end

    it "can make make cells" do
      expect(board.make_cells["A1"].class).to eq(Cell)
    end

    it "can validate coordinates" do
      expect(board.valid_coordinate?("A1")).to be true
      expect(board.valid_coordinate?("D4")).to be true
      expect(board.valid_coordinate?("A5")).to be false
      expect(board.valid_coordinate?("E1")).to be false
      expect(board.valid_coordinate?("A22")).to be false
    end

    it "can check ship length against an argument" do
      expect(board.ship_same_length?(cruiser,["A1", "A2"] )).to eq(false)
    end

    it "can check coordinates before placing a ship" do
      expect(board.ship_valid_coordinates?(["A4", "A5", "A6"])).to eq(false)
    end

    it "can check if a placement argument is are all unique cells" do
      expect(board.uniq_cell_placement?(["A1", "A1", "A3"])).to eq false
    end

    it "can check if space is occupied" do
      board.place(cruiser, ["A1", "A2", "A3"])
      expect(board.ship_not_present?(["A1", "A2"])).to eq false
    end

    it "can create a placement map" do
      board.placement_map(["A1", "A2", "A3"])
      expect(board.pl_numbers).to eq([1, 2, 3])
      expect(board.pl_letters).to eq(["A", "A", "A"])
      expect(board.letters_ord).to eq([65, 65, 65])
    end

    it "can check for vertical and horizontal logic" do
      board.placement_map(["A1", "A2", "A3"])
      expect(board.vert_hor_check).to eq(true)
      board.placement_map(["A1", "B1"])
      expect(board.vert_hor_check).to eq(true)
      board.placement_map(["A1", "A2", "A4"])
      expect(board.vert_hor_check).to eq(false)
      board.placement_map(["A1", "C1"])
      expect(board.vert_hor_check).to eq(false)
    end

    it "can check valid placement" do
      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq false
      expect(board.valid_placement?(submarine, ["A1", "A5"])).to eq false
      expect(board.valid_placement?(cruiser, ["A1", "B1", "C1"])).to eq true
      expect(board.valid_placement?(cruiser, ["A1", "A1", "A3"])).to eq false
      expect(board.valid_placement?(cruiser, ["A3", "A4", "B1"])).to eq false
      expect(board.valid_placement?(submarine, ["A1", "B1"])).to eq true
      expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq true
      expect(board.valid_placement?(submarine, ["A1", "B2"])).to eq false
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to eq true
      board.place(cruiser, ["A1", "A2", "A3"])
      expect(board.valid_placement?(submarine, ["A1", "B1"])).to eq false
    end

    it "can clear arrays" do
      board.placement_map(["A1", "A2", "A3"])
      board.clear_arrays
      expect(board.pl_numbers).to eq([])
      expect(board.pl_letters).to eq([])
      expect(board.letters_ord).to eq([])
    end

    it "can place ships" do
      board.place(cruiser, ["A1", "A2", "A3"])
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]
      cell_1.ship == cell_2.ship
      cell_2.ship == cell_3.ship
    end

    it "can render board properly" do
      expect(board.render).to eq("  1 2 3 4\nA . . . .\nB . . . .\nC . . . .\nD . . . .\n")
    end

    it 'can render a board and show ships' do
    board.place(cruiser, ["A1", "A2", "A3"])
    expect(board.render(true)).to eq("  1 2 3 4\nA S S S .\nB . . . .\nC . . . .\nD . . . .\n")
    end

    it "can create different size boards" do
      board_2 = Board.new(10, "P")
      expect(board_2.render).to eq("  1 2 3 4 5 6 7 8 9 10\nA . . . . . . . . . .\nB . . . . . . . . . .\nC . . . . . . . . . .\nD . . . . . . . . . .\nE . . . . . . . . . .\nF . . . . . . . . . .\nG . . . . . . . . . .\nH . . . . . . . . . .\nI . . . . . . . . . .\nJ . . . . . . . . . .\nK . . . . . . . . . .\nL . . . . . . . . . .\nM . . . . . . . . . .\nN . . . . . . . . . .\nO . . . . . . . . . .\nP . . . . . . . . . .\n")
    end

    it "can render a hit" do
      board.place(cruiser, ["A1", "A2", "A3"])
      board.cells["A1"].fire_upon
      expect(board.render(true)).to eq("  1 2 3 4\nA H S S .\nB . . . .\nC . . . .\nD . . . .\n")
    end

    it "can render a miss" do
      board.place(cruiser, ["A1", "A2", "A3"])
      board.cells["A4"].fire_upon
      expect(board.render(true)).to eq("  1 2 3 4\nA S S S M\nB . . . .\nC . . . .\nD . . . .\n")
    end

    it "can render a sunk ship" do
      board.place(cruiser, ["A1", "A2", "A3"])
      board.cells["A1"].fire_upon
      board.cells["A2"].fire_upon
      board.cells["A3"].fire_upon
      expect(board.render(true)).to eq("  1 2 3 4\nA X X X .\nB . . . .\nC . . . .\nD . . . .\n")
    end

end
