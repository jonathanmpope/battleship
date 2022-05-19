require './spec_helper'
require_relative 'game_runner'

RSpec.describe do
  let!(:board) {Board.new}
  let!(:makes_cells) {board.cells}
  let!(:cruiser) {Ship.new("Cruiser", 3)}
  let!(:submarine) {Ship.new("Submarine", 2)}
  let!(:player1) {Player.new("Player 1")}
  let!(:computer) {Player.new("Computer")}
  let!(:new_game) {GameRunner.new(board)}

  it "is an instance of" do
    expect(board).to be_instance_of Game
  end

  it "has a fleet of ships" do
    player1.make_ship("Submarine", 2)
    player1.make_ship("Cruiser", 3)
    require "pry"; binding.pry
    expect(player1.fleet.length).to eq(2)
  end
end
