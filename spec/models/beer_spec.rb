require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved with a style and a name" do
    beer = Beer.create name:"beer", style:"IPA"
    expect(beer).to be_valid
  end

  it "is not saved without a name" do
    beer = Beer.create style:"IPA"
    expect(beer).not_to be_valid
  end

  it "is not saved without a style" do
    beer = Beer.create name:"beer"
    expect(beer).not_to be_valid
  end
end