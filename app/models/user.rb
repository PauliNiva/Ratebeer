class User < ActiveRecord::Base
  include RatingAverage
  validates :username, uniqueness: true,
                      length: { in: 3..15 }
  has_many :ratings, dependent: :destroy   # user has many ratings
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships
  has_many :memberships, dependent: :destroy

  has_secure_password

  validates :password, length: {
                         minimum: 4
                     }
  validates_format_of :password, with: /(?=.*[A-ZÅÄÖ])/, message: "Password must contain at least one capital letter"
  validates_format_of :password, with: /(?=.*[\d])/, message: "Password must contain at least one numerical digit"

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    beers.group(:style).average(:score).max_by { |name, score| score }.first
  end

  def favorite_brewery
    return nil if ratings.empty?
    beers.group(:brewery).average(:score).max_by { |name, score| score }.first
  end

end