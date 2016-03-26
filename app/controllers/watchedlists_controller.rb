class WatchedlistsController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :destroy]

  def index
    @movies = current_user.watched_movies.paginate(page: params[:page])
  end

  def create
    current_user.watchedlist_items.create(movie_id: params[:movie_id])
    redirect_to request.referrer || root_url
  end

  def destroy
    Watchedlist.find(params[:id]).destroy
    redirect_to request.referrer || root_url
  end
end
