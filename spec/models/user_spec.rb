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
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

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

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only one rated if only one rating exists" do
      beer = create_beer_with_rating(10, user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several are rated" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      best = create_beer_with_rating(25, user)
      create_beer_with_rating(7, user)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite_style" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to :favorite_style
    end

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only style if only one beer is rated" do
      beer = create_beer_with_rating(10, user)
      expect(user.favorite_style).to eq(beer.style)
    end

    it "is the one with highest rating if several are rated" do
      create_beers_with_ratings_and_style(11, 7, 9, user, 'IPA')
      create_beers_with_ratings_and_style(7, 8, user, 'Lager')
      expect(user.favorite_style).to eq('IPA')
    end
  end

  describe "favorite_brewery" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to :favorite_brewery
    end

    it "without ratings does not have one" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the only brewery if only one beer is rated" do
      brewery = FactoryGirl.create(:brewery, name:"koff")
      beer = create_beer_with_rating_and_brewery(10, user, brewery)
      expect(user.favorite_brewery).to eq(beer.brewery)
    end

    it "is the brewery tha has the best average rating" do
      b1 = FactoryGirl.create(:brewery, name:"Koff")
      b2 = FactoryGirl.create(:brewery, name:"BreDog")
      create_beers_with_ratings_and_brewery(10, 20, user, b1)
      create_beers_with_ratings_and_brewery(15, 30, user, b2)
      expect(user.favorite_brewery).to eq(b2)
    end
  end

end

def create_beers_with_ratings(*scores, user)
  scores.each do |score|
    create_beer_with_rating score, user
  end
end

def create_beer_with_rating(score, user)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

def create_beers_with_ratings_and_brewery(*scores, user, brewery)
  scores.each do |score|
    create_beer_with_rating_and_brewery score, user, brewery
  end
end

def create_beer_with_rating_and_brewery(score, user, brewery)
  beer = FactoryGirl.create(:beer, brewery: brewery)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

def create_beers_with_ratings_and_style(*scores, user, style)
  scores.each do |score|
    create_beer_with_rating_and_style score, user, style
  end
end

def create_beer_with_rating_and_style(score, user, style)
  beer = FactoryGirl.create(:beer, style: style)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end
