class BeerClub < ActiveRecord::Base
  has many :users, through: :memberships
  has_many :memberships

  def to_s
    "#{self.name}, #{self.city}"
    end
end
