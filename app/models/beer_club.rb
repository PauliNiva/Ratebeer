class BeerClub < ActiveRecord::Base
  has_many :users, through: :memberships
  has_many :memberships

  def to_s
    "#{self.name}, #{self.city}"
  end

  def members
    memberships.is_confirmed.collect {|m| m.user}
  end

  def is_member?(user)
    members.include? user
  end
end
