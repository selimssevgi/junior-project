class Language < ActiveRecord::Base
  has_many   :language_movies
  has_many   :movies, through: :language_movies 
end
