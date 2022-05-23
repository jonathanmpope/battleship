require 'spec_helper'

RSpec.describe do
  let!(:new_game) {Game.new}

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

  it "has two cells in each board" do
    expect(new_game.computer.board.cells["A1"].class).to eq(Cell)
    expect(new_game.player.board.cells["A1"].class).to eq(Cell)
  end

  it "has can have a ship in a cell" do
    new_game.player.board.place(new_game.player.fleet[0], ["A1", "A2", "A3"])
    expect(new_game.player.board.cells["A1"].ship.class).to eq(Ship)
  end

  it "ends the game when a players fleet health is zero(all ships destroyed)" do
    
  end

end
