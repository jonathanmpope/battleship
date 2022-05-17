require './lib/ship'
require './lib/cell'

RSpec.describe do
  let!(:cell) {Cell.new("B4")}

  it "is an instance of" do
    expect(cell).to be_instance_of Cell
  end

  it "has a coordinate" do
    expect(cell.coordinate).to eq("B4")
  end

  it "has a ship" do
    expect(cell.ship).to eq(nil)
  end

  it "can see ships" do
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    expect(cell.ship).to eq(cruiser)

  end

  it 'is empty unless a ship is there' do
    expect(cell.empty?).to eq(true)
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    expect(cell.empty?).to eq(false)
  end

  it "can be fired upon" do
    expect(cell.fired_upon?).to eq(false)
    cell.fire_upon
    expect(cell.fired_upon?).to eq(true)
  end
end
