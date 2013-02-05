# This migration comes from voting_app (originally 20130204174615)
class AddUserIdToVotingAppSubmissions < ActiveRecord::Migration
  def change
    add_column :voting_app_submissions, :user_id, :integer
  end
end
