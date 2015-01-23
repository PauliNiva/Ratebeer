class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    sum = self.ratings.sum :score
    ratings_count = self.ratings.count
    average = sum / ratings_count
    return "#{average}"
  end
end
