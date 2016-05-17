class CreateUserSimilarities < ActiveRecord::Migration
  def change
    create_table :user_similarities do |t|
      t.integer :fuser
      t.integer :suser
      t.decimal :similarity, :default => 0.0, :precision => 64, :scale => 12

      t.timestamps null: false
    end
  end
end
