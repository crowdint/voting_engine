class AddTypeToVotingAppUsers < ActiveRecord::Migration
  def change
    add_column :voting_app_users, :type, :string
  end
end
