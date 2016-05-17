class RecommendationsController < ApplicationController
  before_action :logged_in_user, only: [:index, :destroy]

  def index
    @movies = current_user.recommended_movies
    @movies = @movies.order('guessed_rate DESC')
    @movies = @movies.paginate(page: params[:page]) 
  end

  def destroy
    recommended_movie = Recommendation.find(params[:id])
    @movie_id = recommended_movie.movie_id
    recommended_movie.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
