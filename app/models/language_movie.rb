class LanguageMovie < ActiveRecord::Base
  belongs_to :movie
  belongs_to :language
end
