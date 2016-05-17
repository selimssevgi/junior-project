class StaticPagesController < ApplicationController
  def home
    redirect_to movies_path if logged_in?
  end

  def help
  end

  def about
  end

  def contact
  end

  def stats
    @stats_hash = {}
    @stats_hash[:users_count] = User.all.count
    @stats_hash[:movies_count] = Movie.all.count
    @stats_hash[:ratings_count] = Rating.all.count
    @stats_hash[:comments_count] = Comment.all.count
  end

  def engine_rate
    @recommended_rated_entries = Recommended.where("rated = 1").order("updated_at DESC").paginate(page: params[:page])
    @rmse = get_rmse(@recommended_rated_entries)
  end

  private 
    def get_rmse(entries)
      error_squared_sum = 0
      total = entries.count
      entries.each do |entry|
        diff = entry.guessed_rate - entry.real_rate
        squared = diff ** 2
        error_squared_sum += squared
      end

      mean = error_squared_sum / total
      rmse = Math.sqrt(mean)
    end
end
