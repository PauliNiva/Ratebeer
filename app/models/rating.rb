class Rating < ActiveRecord::Base
  belongs_to :beer

  def to_s
    oluen_nimi = self.beer.name
    reittaus = self.score
    "#{oluen_nimi} #{reittaus}"
  end
end
