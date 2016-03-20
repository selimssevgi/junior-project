class Movie < ActiveRecord::Base
  belongs_to :rated
  has_many   :genremovies
  has_many   :genres, through: :genremovies

  has_many   :directings
  has_many   :directors, through: :directings

  has_many   :actings
  has_many   :actors, through: :actings

  has_many   :language_movies
  has_many   :languages, through: :language_movies 

  has_many   :country_movies
  has_many   :countries, through: :country_movies 
end
