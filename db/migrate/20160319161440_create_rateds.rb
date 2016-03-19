class CreateRateds < ActiveRecord::Migration
  def change
    create_table :rateds do |t|
      t.string :rated

      t.timestamps null: false
    end
  end
end
