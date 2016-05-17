class RecommendationsController < ApplicationController
  before_action :logged_in_user, only: [:index, :destroy]

  def index
    @movies = current_user.recommended_movies
    @movies = @movies.where(:show, 1).order('guessed_rate DESC')
    @movies = @movies.paginate(page: params[:page]) 
  end
end
