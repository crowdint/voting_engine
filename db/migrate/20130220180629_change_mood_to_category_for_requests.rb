class ChangeMoodToCategoryForRequests < ActiveRecord::Migration
  def up
    rename_column :voting_app_requests, :mood, :category
  end

  def down
    rename_column :voting_app_requests, :category, :mood
  end
end
