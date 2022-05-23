require 'spec_helper'

RSpec.describe do
  let!(:player1) {Player.new("Player 1")}
  let!(:computer) {Player.new("Computer")}

  it "is an instance of" do
    expect(player1).to be_instance_of Player
    expect(computer).to be_instance_of Player
  end

  it "can make a fleet with ships" do
    expect(player1.fleet.length).to eq(2)
    expect(player1.fleet[0].class).to eq(Ship)
  end

  it "can make a board with cells" do
    expect(player1.board.class).to eq(Board)
    expect(player1.board.cells["A1"].class).to eq(Cell)
  end

  it "can track fleet health" do
    expect(player1.fleet_health).to eq(5)
    player1.board.place(player1.fleet[0], ["A1", "A2", "A3"])
    player1.board.cells["A1"].fire_upon
    expect(player1.fleet_health).to eq(4)
  end

end
