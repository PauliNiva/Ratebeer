require 'rails_helper'

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end

    it "when signed up with good credentials, is added to the system" do
      visit signup_path
      fill_in('user_username', with:'Brian')
      fill_in('user_password', with:'Secret55')
      fill_in('user_password_confirmation', with:'Secret55')

      expect{ click_button('Create User') }.to change{User.count}.by(1)
    end
  end

describe "who has made ratings" do
  it "has his ratings on the user page" do
    user = User.first
    create_beers_and_ratings
    visit user_path(user)

    expect(page).to have_content('Has made 2 ratings')
    expect(page).to have_content('iso3')
    expect(page).to have_content('Karhu')
  end

  it "has favorite style" do
    create_beers_and_ratings
    user1 = User.first
    visit user_path(user1)
    expect(page).to have_content('Favorite beer style is Lager')
  end

  it "has favorite brewery" do
    create_beers_and_ratings
    user = User.first
    visit user_path(user)
    expect(page).to have_content('favorite brewery is Koff')
    end
  end
end

def create_beers_and_ratings
  user = User.first
  brewery = FactoryGirl.create :brewery, name:"Koff"
  beer1 = FactoryGirl.create :beer, name:"iso3", brewery:brewery
  beer2 = FactoryGirl.create :beer, name:"Karhu", brewery:brewery
  FactoryGirl.create :rating, beer:beer1, user:user
  FactoryGirl.create :rating, beer:beer2, user:user
end