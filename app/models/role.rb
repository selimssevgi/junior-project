class Role < ActiveRecord::Base
  has_many :casts
  has_many :people, through: :casts
end
