class User < ActiveRecord::Base
  include RatingAverage
  validates :username, uniqueness: true,
                      length: { in: 3..15 }
  has_many :ratings   # user has many ratings
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships
  has_many :memberships
end