class CreateDirectings < ActiveRecord::Migration
  def change
    create_table :directings do |t|
      t.references :director, index: true, foreign_key: true
      t.references :movie, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
