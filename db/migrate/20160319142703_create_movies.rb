class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string  :title
      t.integer :year
      t.string  :released
      t.integer :runtime
      t.text    :plot
      t.string  :awards
      t.string  :poster
      t.integer :metascore
      t.decimal :imdb_rating, :precision => 3, :scale => 1
      t.integer :imdb_votes
      t.string  :imdb_id

      t.timestamps null: false
    end
  end
end
