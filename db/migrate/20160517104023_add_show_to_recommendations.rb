class AddShowToRecommendations < ActiveRecord::Migration
  def change
    add_column :recommendations, :show, :boolean, default: true
  end
end
