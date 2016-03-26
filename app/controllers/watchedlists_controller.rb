class WatchedlistsController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :destroy]

  def index
    @movies = current_user.watched_movies.paginate(page: params[:page])
  end

  def create
    @movie = Movie.find(params[:movie_id])
    current_user.watchedlist_items.create(movie_id: params[:movie_id])
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    watchedlist_item = Watchedlist.find(params[:id])
    @movie = watchedlist_item.movie
    watchedlist_item.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
