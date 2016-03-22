class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :full_name

      t.timestamps null: false
    end
  end
end
