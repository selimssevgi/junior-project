class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :movie, index: true, foreign_key: true
      t.decimal :rate, :default => 0.0, :precision => 3, :scale => 1

      t.timestamps null: false
    end
  end
end
