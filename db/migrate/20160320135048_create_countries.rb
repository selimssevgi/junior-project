class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :country_name

      t.timestamps null: false
    end
  end
end
