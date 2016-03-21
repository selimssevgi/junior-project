class WatchlistsController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :destroy]

  def index
    @movies = current_user.movies_to_watch.paginate(page: params[:page])
  end

  def create
    current_user.watchlist_items.create(movie_id: params[:movie_id])
    redirect_to request.referrer || root_url
  end

  def destroy
    Watchlist.find(params[:id]).destroy
    redirect_to request.referrer || root_url
  end

end
