require './lib/ship'

RSpec.describe do
  let!(:cruiser) {Ship.new("Cruiser", 3)}
  let!(:submarine) {Ship.new("Submarine", 2)}

  it "is an instance of Ship" do
    expect(cruiser).to be_instance_of Ship
  end

  it "has a length" do
    expect(cruiser.length).to eq(3)
    expect(submarine.length).to eq(2)
  end

  it "has a type" do
    expect(cruiser.type).to eq("Cruiser")
    expect(submarine.type).to eq("Submarine")
  end


  xit "can track its health" do

  end

  xit "take hits" do

  end

  xit "can report if sunk or not" do

  end
end
