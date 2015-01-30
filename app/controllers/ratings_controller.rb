class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    render :index    # render view template index.html.erb from directory views/ratings
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    Rating.create params.require(:rating).permit(:score, :beer_id)

    # save created rating to session
    session[:last_rating] = "#{rating.beer.name} #{rating.score} points"

    redirect_to ratings_path
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete
    redirect_to ratings_path
  end
end