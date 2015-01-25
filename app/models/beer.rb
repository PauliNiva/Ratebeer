class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def average_rating
    sum = ratings.map(&:score).inject(:+)
    (sum / ratings.count.to_f).round(2)
  end

  def to_s
    "#{self.name}, #{self.brewery.name}"
  end
end
