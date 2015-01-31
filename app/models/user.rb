class User < ActiveRecord::Base
  has_many :ratings   # user has many ratings

class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user   # rating belongs also to user

  def to_s
    "#{beer.name} #{score}"
  end
end