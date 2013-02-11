# This migration comes from voting_app (originally 20130211173238)
class AddMoodToVotingAppSubmissions < ActiveRecord::Migration
  def change
    add_column :voting_app_submissions, :mood, :string
  end
end
