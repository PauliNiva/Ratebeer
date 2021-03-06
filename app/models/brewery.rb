class Brewery < ActiveRecord::Base
  include RatingAverage
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :year, numericality: {
                     only_integer: true,
                     greater_than_or_equal_to: 1042
                 }

  validate :year_not_in_future

  validates :name, presence: true, allow_blank: false

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil,false] }

  def self.top(n)
    all.sort_by{ |b| -(b.average_rating||0) }.take(n)
  end

  def year_not_in_future
    if year.present? && year > Time.now.year
      errors.add(:year, "year cannot be in the future")
    end
  end
end
