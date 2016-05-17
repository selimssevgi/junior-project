class Movie < ActiveRecord::Base
  belongs_to :rated

  has_many   :casts, dependent: :destroy
  has_many   :directors, -> { where "role_id = 1" }, through: :casts,
                                                     source: :person

  has_many   :writers,   -> { where "role_id = 2" }, through: :casts,
                                                     source: :person

  has_many   :actors,    -> { where "role_id = 3" }, through: :casts,
                                                     source: :person
  
  has_many   :genremovies
  has_many   :genres, through: :genremovies

  has_many   :comments

  has_many   :language_movies
  has_many   :languages, through: :language_movies 

  has_many   :country_movies
  has_many   :countries, through: :country_movies 

  has_many   :watchlists
  has_many   :users, through: :watchlists

  has_many   :watchedlists
  has_many   :watched_list_users, through: :watchedlists

  has_many   :ratings

  def averate_rating
    '%.01f' % (ratings.sum(:rate) / ratings.size)
  end

  def in_watchlist_count
    Watchlist.where("movie_id = ?", id).count
  end

  def in_watchedlist_count
    Watchedlist.where("movie_id = ?", id).count
  end

  def get_similar_movies
    movies_pair = MovieSimilarity.where("fmovie = ? OR smovie = ?", id, id)
    movies_pair = movies_pair.order("similarity DESC").take(4)

    similar_movies = []
    movies_pair.each do |pair|
      if pair.fmovie != id
        similar_movies << Movie.find(pair.fmovie)
      else
        similar_movies << Movie.find(pair.smovie)
      end
    end
    return similar_movies 
  end

  def get_guessed_rate(current_user)
    recommendation = Recommendation.where("user_id = ? and movie_id = ?", current_user.id, id).take
    return 0.0 if recommendation.nil?
    return '%.04f' % recommendation.guessed_rate.to_f
  end
end
