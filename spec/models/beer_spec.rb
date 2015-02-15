require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved with a style and a name" do
    style = Style.create(name: "Lager", description: "Lager is a type of beer that is fermented and conditioned at low temperatures.")
    beer = Beer.create name:"beer", style: style
    expect(beer).to be_valid
  end

  it "is not saved without a name" do
    style = Style.create(name: "Lager", description: "Lager is a type of beer that is fermented and conditioned at low temperatures.")
    beer = Beer.create style: style
    expect(beer).not_to be_valid
  end

  it "is not saved without a style" do
    beer = Beer.create name:"beer"
    expect(beer).not_to be_valid
  end
end