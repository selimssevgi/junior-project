class CreateWritings < ActiveRecord::Migration
  def change
    create_table :writings do |t|
      t.references :movie, index: true, foreign_key: true
      t.references :writer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
