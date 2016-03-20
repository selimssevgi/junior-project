class CreateWriters < ActiveRecord::Migration
  def change
    create_table :writers do |t|
      t.string :full_name

      t.timestamps null: false
    end
  end
end
