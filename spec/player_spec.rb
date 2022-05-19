require 'spec_helper'

RSpec.describe do
  let!(:player1) {Player.new("Player 1")}
  let!(:computer) {Player.new("Computer")}
  # let!(:cruiser) {('Cruiser', 3)}
  # let!(:sub) {('Sub', 2)}
  # let!(:cruiser) {computer.make_ship('Cruiser', 3)}
  # let!(:sub) {computer.make_ship('Sub', 2)}


  it "is an instance of" do
    expect(player1).to be_instance_of Player
    expect(computer).to be_instance_of Player
  end

  it "can make a fleet" do
    player1.make_ship("Cruiser", 3)
    player1.make_ship("Sub", 2)

    expect(player1.fleet.length).to eq(2)
  end
end
