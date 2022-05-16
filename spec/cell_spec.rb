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
end
