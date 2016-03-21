class Genre < ActiveRecord::Base
  has_many   :genremovies
  has_many   :movies, through: :genremovies

  validates :genre, presence: true,
                    uniqueness: { case_sensitive: false }
end
