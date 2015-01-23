class Rating < ActiveRecord::Base
  belongs_to :beer

  def to_s
    beer_name = self.beer.name
    rating = self.score
    "#{beer_name} #{rating}"
  end
end
