class User < ActiveRecord::Base
  include RatingAverage
  has_many :ratings   # user has many ratings
end