class Movie < ActiveRecord::Base
  belongs_to :rated
  has_many   :genremovies
  has_many   :genres, through: :genremovies
end
