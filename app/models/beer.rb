class Beer < ActiveRecord::Base
  include RatingAverage
  belongs_to :brewery, touch: true
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user

  validates :name, presence: true, allow_blank: false

  validates :style, presence: true

  def average
    return 0 if ratings.empty?
    ratings.map{ |r| r.score }.sum / ratings.count.to_f
  end

  def to_s
    "#{self.name}, #{self.brewery.name}"
  end

  def self.top(n)
    all.sort_by{ |b| -(b.average_rating||0) }.take(n)
  end
end
