class AddAdminToVotingAppUsers < ActiveRecord::Migration
  def change
    add_column :voting_app_users, :admin, :boolean
  end
end
