class CreateVotingAppUsers < ActiveRecord::Migration
  def change
    create_table :voting_app_users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
