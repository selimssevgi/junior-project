class MoviesController < ApplicationController
  def index
    @movies = Movie.paginate(page: params[:page], per_page: 20)
  end

  def show
    @movie = Movie.find(params[:id])
    @comments = Comment.where(movie_id: @movie.id).order("created_at DESC").paginate(page: params[:page], per_page: 5)
  end
end
