class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :movie, index: true, foreign_key: true
      t.decimal :guessed_rate, :default => 0.0, :precision => 64, :scale => 12

      t.timestamps null: false
    end
  end
end
