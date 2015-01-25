class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def average_rating
    sum = ratings.map(&:score).inject(:+)
    (sum / ratings.count.to_f).round(2)
  end
end
