class AddActorIdToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :actor_id, :integer
  end
end
