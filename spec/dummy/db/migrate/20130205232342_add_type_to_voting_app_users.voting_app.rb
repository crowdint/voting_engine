# This migration comes from voting_app (originally 20130205232323)
class AddTypeToVotingAppUsers < ActiveRecord::Migration
  def change
    add_column :voting_app_users, :type, :string
  end
end
