class CreateGenremovies < ActiveRecord::Migration
  def change
    create_table :genremovies do |t|
      t.references :genre, index: true, foreign_key: true
      t.references :movie, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
