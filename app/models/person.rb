class Person < ActiveRecord::Base
  has_many :casts
  has_many :roles, through: :casts
  has_many :movies, through: :casts
end
