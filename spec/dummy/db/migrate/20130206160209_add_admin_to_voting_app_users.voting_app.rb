# This migration comes from voting_app (originally 20130206160142)
class AddAdminToVotingAppUsers < ActiveRecord::Migration
  def change
    add_column :voting_app_users, :admin, :boolean
  end
end
