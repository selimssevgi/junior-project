class Actor < ActiveRecord::Base
  has_many :actings
  has_many :movies, through: :actings
end
