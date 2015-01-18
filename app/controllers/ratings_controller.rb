class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    render :index    # renderöi hakemistosta views/ratings olevan näkymätemplaten index.html.erb
  end
end