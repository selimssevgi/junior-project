class AddRatedToMovies < ActiveRecord::Migration
  def change
    add_reference :movies, :rated, index: true, foreign_key: true
  end
end
