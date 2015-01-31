class User < ActiveRecord::Base
  has_many :ratings   # user has many ratings
end