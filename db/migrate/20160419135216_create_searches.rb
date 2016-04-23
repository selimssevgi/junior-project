class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :title
      t.integer :min_year
      t.integer :max_year
      t.integer :min_runtime
      t.integer :max_runtime
      t.string :keywords
      t.string :awards
      t.integer :min_metascore
      t.integer :max_metascore
      t.decimal :min_irating
      t.decimal :max_irating
      t.integer :min_ivotes
      t.integer :max_ivotes
      t.string :imdb_id
      t.integer :rated_id
      t.integer :genre_id
      t.integer :language_id
      t.integer :director_id
      t.integer :writer_id
      t.integer :country_id

      t.timestamps null: false
    end
  end
end
