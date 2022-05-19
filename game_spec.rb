require './spec_helper'

RSpec.describe do
  let!(:board) {Board.new}
  let!(:makes_cells) {board.cells}
  let!(:cruiser) {Ship.new("Cruiser", 3)}
  let!(:submarine) {Ship.new("Submarine", 2)}
  let!(:player1) {Player.new("Player 1")}
  let!(:computer) {Player.new("Computer")}
  let!(:new_game) {GameRunner.new}

  it "is an instance of" do
    expect(board).to be_instance_of Game
  end
end
