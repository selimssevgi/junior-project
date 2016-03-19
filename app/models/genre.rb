class Genre < ActiveRecord::Base
  has_many   :genremovies
  has_many   :movies, through: :genremovies
end
