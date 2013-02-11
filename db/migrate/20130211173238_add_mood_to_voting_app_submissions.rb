class AddMoodToVotingAppSubmissions < ActiveRecord::Migration
  def change
    add_column :voting_app_submissions, :mood, :string
  end
end
