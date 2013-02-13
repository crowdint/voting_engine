class RenameVotingAppSubmissionsToVotingAppRequests < ActiveRecord::Migration
  def change
    rename_table :voting_app_submissions, :voting_app_requests
  end
end
