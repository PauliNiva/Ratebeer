class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    render :index    # renderöi hakemistosta views/ratings olevan näkymätemplaten index.html.erb
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    Rating.create params.require(:rating).permit(:score, :beer_id)
    redirect_to ratings_path
  end
end