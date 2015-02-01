class User < ActiveRecord::Base
  include RatingAverage
  validates :username, uniqueness: true,
                      length: { in: 3..15 }
  has_many :ratings   # user has many ratings
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships
  has_many :memberships

  has_secure_password

  validates :password, length: {
                         minimum: 4
                     }
  validates_format_of :password, with: /(?=.*[A-ZÅÄÖ])/, message: "Password must contain at least one capital letter"
  validates_format_of :password, with: /(?=.*[\d])/, message: "Password must contain at least one numerical digit"
end