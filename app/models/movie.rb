class Movie < ActiveRecord::Base
  belongs_to :rated

  has_many   :casts, dependent: :destroy
  has_many   :directors, -> { where "role_id = 1" }, through: :casts,
                                                     source: :person

  has_many   :writers,   -> { where "role_id = 2" }, through: :casts,
                                                     source: :person

  has_many   :actors,    -> { where "role_id = 3" }, through: :casts,
                                                     source: :person

  # has_many   :directings
  # has_many   :directors, through: :directings
  #
  # has_many   :writings
  # has_many   :writers, through: :writings
  #
  # has_many   :actings
  # has_many   :actors, through: :actings
  
  has_many   :genremovies
  has_many   :genres, through: :genremovies

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
end
