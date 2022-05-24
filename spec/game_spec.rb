require 'spec_helper'

RSpec.describe do
  let!(:new_game) {Game.new}
  let!(:player_board) {new_game.player.board_creation(4, "D")}
  let!(:computer_board) {new_game.computer.board_creation(4, "D")}
  let!(:player_fleet) {new_game.player.fleet_build}
  let!(:computer_fleet) {new_game.computer.fleet_build}

  it "is an instance of" do
    expect(new_game).to be_instance_of Game
  end

  # it "can start a game" do
  #   expect(new_game.start_game).to include("Welcome")
  # end

  it "has a computer and a player" do
    expect(new_game.computer.class).to eq(Player)
    expect(new_game.player.class).to eq(Player)
  end

  it "has two boards with cells and ships" do
    expect(new_game.computer.board.class).to eq(Board)
    expect(new_game.player.board.class).to eq(Board)
  end

  it "can render the board before ships are placed for the computer" do
    expect(new_game.computer.board.render).to eq("  1 2 3 4\nA . . . .\nB . . . .\nC . . . .\nD . . . .\n")
  end

  it "can render the board before ships are placed for the player" do
    expect(new_game.player.board.render).to eq("  1 2 3 4\nA . . . .\nB . . . .\nC . . . .\nD . . . .\n")
  end


  it "has the same cell in each board" do
    expect(new_game.computer.board.cells["A1"].class).to eq(Cell)
    expect(new_game.player.board.cells["A1"].class).to eq(Cell)
  end

  it "has can have a ship in a cell" do
    new_game.player.board.place(new_game.player.fleet[0], ["A1", "A2", "A3"])
    expect(new_game.player.board.cells["A1"].ship.class).to eq(Ship)
  end

  it "can render the board for the computer" do
    expect(new_game.computer.board.render).to eq("  1 2 3 4\nA . . . .\nB . . . .\nC . . . .\nD . . . .\n")
  end

  it "can render the board after ships are placed for the player" do
    new_game.player.board.place(new_game.player.fleet[0], ["A1", "A2", "A3"])
    new_game.player.fleet.rotate!
    new_game.player.board.place(new_game.player.fleet[0], ["B1", "B2"])
    expect(new_game.player.board.render(true)).to eq("  1 2 3 4\nA S S S .\nB S S . .\nC . . . .\nD . . . .\n")
  end

  it "can render the board after ships are placed for the computer" do
    new_game.computer.computer_ship_placement
    expect(new_game.computer.board.render(true)).to include("S")
  end

  it "can let the player take shots and adjusts the board based on that shot" do
    expect(new_game.computer.player_shot_check("A1")).to eq("A1")
    expect(new_game.computer.board.render(true)).to include("M" || "H")
  end

  it "lets the computer take a shot and adjusts the board based on that shot" do
    expect(new_game.player.computer_shot_check("A3")).to eq("A3")
    expect(new_game.player.board.render(true)).to include("M" || "H")
  end

  it "renders a ship sunk when playing" do
    new_game.player.board.place(new_game.player.fleet[0], ["A1", "A2", "A3"])
    new_game.player.fleet.rotate!
    new_game.player.board.place(new_game.player.fleet[0], ["B1", "B2"])
    new_game.player.computer_shot_check("A1")
    new_game.player.computer_shot_check("A2")
    new_game.player.computer_shot_check("A3")
    expect(new_game.player.board.render(true)).to include("X")
  end

  it "updates a players fleet health as ships are hit" do
    new_game.player.board.place(new_game.player.fleet[0], ["A1", "A2", "A3"])
    new_game.player.fleet.rotate!
    new_game.player.board.place(new_game.player.fleet[0], ["B1", "B2"])
    new_game.player.computer_shot_check("A1")
    new_game.player.computer_shot_check("A2")
    new_game.player.computer_shot_check("A3")
    new_game.player.computer_shot_check("B1")
    new_game.player.computer_shot_check("B2")
    expect(new_game.player.fleet_health).to eq(0)
  end

end
