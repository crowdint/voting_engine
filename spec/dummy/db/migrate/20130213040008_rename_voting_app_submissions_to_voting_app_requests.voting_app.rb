# This migration comes from voting_app (originally 20130213035841)
class RenameVotingAppSubmissionsToVotingAppRequests < ActiveRecord::Migration
  def change
    rename_table :voting_app_submissions, :voting_app_requests
  end
end
