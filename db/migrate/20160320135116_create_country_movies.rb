class CreateCountryMovies < ActiveRecord::Migration
  def change
    create_table :country_movies do |t|
      t.references :movie, index: true, foreign_key: true
      t.references :country, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
