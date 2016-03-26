class WatchlistsController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :destroy]

  def index
    @movies = current_user.movies_to_watch.paginate(page: params[:page])
  end

  def create
    @movie = Movie.find(params[:movie_id])
    current_user.watchlist_items.create(movie_id: params[:movie_id])
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    watchlist_item = Watchlist.find(params[:id])
    @movie = watchlist_item.movie
    watchlist_item.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

end
