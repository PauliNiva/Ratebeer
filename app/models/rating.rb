class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user   # rating belongs to user

  def to_s
    "#{beer.name} #{score}"
  end
end