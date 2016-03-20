class CreateLanguageMovies < ActiveRecord::Migration
  def change
    create_table :language_movies do |t|
      t.references :movie, index: true, foreign_key: true
      t.references :language, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
