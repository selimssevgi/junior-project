class SearchesController < ApplicationController
  def new
    @search ||= Search.new 
  end

  def create
    @search = Search.create!(search_params)
    redirect_to @search
  end

  def show
    @search = Search.find(params[:id])
  end
  
  # There are too many attributes for get method
  # Form wouldnt keep the previous search without updating the db entry
  def update
    @search = Search.find(params[:id])
    if @search.update_attributes(search_params)
      #handle a successful update
      # flash[:success] = "Profile updated"
      redirect_to @search
    else
      render 'show'
    end
  end

  private

  def search_params
    params.require(:search).permit(:title, :min_year, :max_year, :min_runtime,
                                   :max_runtime, :keywords, :awards, 
                                   :min_metascore, :max_metascore, 
                                   :min_irating, :max_irating, :min_ivotes, 
                                   :max_ivotes, :imdb_id, :rated_id, :genre_id, 
                                   :language_id, :director_id, :writer_id, 
                                   :country_id)
  end
end
