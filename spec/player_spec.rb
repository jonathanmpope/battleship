require 'spec_helper'

RSpec.describe do
  let!(:player1) {Player.new("Player 1")}
  let!(:computer) {Player.new("Computer")}

  it "is an instance of" do
    expect(player1).to be_instance_of Player
    expect(computer).to be_instance_of Player
  end

  it "has a name" do
    expect(player1.name).to eq('Player 1')
  end


  it "can make a fleet with ships" do
    expect(player1.fleet.length).to eq(2)
    expect(player1.fleet[0].class).to eq(Ship)
  end

  it "can make a board with cells" do
    expect(player1.board.class).to eq(Board)
    expect(player1.board.cells["A1"].class).to eq(Cell)
  end

  it "can report the players ships" do
    expect(player1.player_ships.class).to eq(Array)
  end

  it "can track fleet health" do
    expect(player1.fleet_health).to eq(5)
    player1.board.place(player1.fleet[0], ["A1", "A2", "A3"])
    player1.board.cells["A1"].fire_upon
    expect(player1.fleet_health).to eq(4)
  end

  it "can check for valid ship placement based on player intake" do 
    expect(player1.board.valid_placement?(player1.fleet.first,["A1","A2","A3"])).to eq(true)
    expect(player1.board.place(player1.fleet.first, ["A1","A2","A3"])[0].class).to eq(Ship)
  end

  it "can sample grid locations for random ship placement" do
    expect(computer.computer_ship_grids.class).to eq(Array)
    expect(computer.computer_ship_grids.count).to eq(3)
  end

  it "can place the computers ships" do
    expect(computer.board.valid_placement?(computer.fleet.first,["C2","C3","C4"])).to eq(true)
    expect(computer.board.place(computer.fleet.first,["C2","C3","C4"])[0].class).to eq(Ship)
  end

  it "can check the shots the player takes" do
    expect(computer.board.valid_coordinate?("A1")).to eq(true)
    expect(computer.board.valid_coordinate?("A8")).to eq(false)
    expect(computer.board.cells["A1"].fire_upon).to eq(true)
    expect(computer.board.cells["A1"].render).to eq("M")
  end

  it "can check the shots the computer takes" do
    expect(player1.computer_shot_check("A1")).to eq("A1")
    expect(player1.board.cells["A1"].fire_upon).to eq(true)
  end

  it "can render a shot result for the computer" do
    player1.board.cells["A1"].fire_upon
    expect(player1.board.cells["A1"].render).to eq("M")
    player1.board.place(computer.fleet.first,["B1","C1","D1"])
    player1.board.cells["B1"].fire_upon
    expect(player1.board.cells["B1"].render).to eq("H")
  end

  it "can render a shot result for the player" do
    computer.board.cells["A1"].fire_upon
    expect(computer.board.cells["A1"].render).to eq("M")
    computer.board.place(computer.fleet.first,["C2","C3","C4"])
    computer.board.cells["C2"].fire_upon
    expect(computer.board.cells["C2"].render).to eq("H")
  end

end
