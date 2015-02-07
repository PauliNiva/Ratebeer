require 'rails_helper'
describe User do
  it "has the username set correctly" do
    user = User.new username:"Pekka"
    expect(user.username).to eq("Pekka")
  end
  it "is not saved without a password" do
    user = User.create username:"Pekka"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end
  describe "with a proper password" do
    let(:user){ User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1" }
    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end
    it "and with two ratings, has the correct average rating" do
      rating = Rating.new score:10
      rating2 = Rating.new score:20
      user.ratings << rating
      user.ratings << rating2
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
  describe "with invalid password" do
    it "is not saved" do
      user1 = User.create username:"Pekka", password:"sa1", password_confirmation:"sa1"
      user2 = User.create username:"Pekka", password:"salasana", password_confirmation:"salasana"
      expect(user1).to_not be_valid
      expect(user2).to_not be_valid
      expect(User.count).to eq(0)
    end
  end
end
