module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    sum = ratings.map(&:score).inject(:+)
    (sum / ratings.count.to_f).round(2)
  end
end