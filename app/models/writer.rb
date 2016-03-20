class Writer < ActiveRecord::Base
  has_many   :writings
  has_many   :movies, through: :writings
end
