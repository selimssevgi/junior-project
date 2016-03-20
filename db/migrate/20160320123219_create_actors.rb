class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string :full_name

      t.timestamps null: false
    end
  end
end
