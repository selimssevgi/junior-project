class Director < ActiveRecord::Base
  has_many  :directings
  has_many  :movies, through: :directings
end
