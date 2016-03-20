class CreateDirectors < ActiveRecord::Migration
  def change
    create_table :directors do |t|
      t.string :full_name

      t.timestamps null: false
    end
  end
end
