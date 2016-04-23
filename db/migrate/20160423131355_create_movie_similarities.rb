class CreateMovieSimilarities < ActiveRecord::Migration
  def change
    create_table :movie_similarities do |t|
      t.integer :fmovie
      t.integer :smovie
      t.decimal :similarity, :default => 0.0, :precision => 64, :scale => 12

      t.timestamps null: false
    end
  end
end
