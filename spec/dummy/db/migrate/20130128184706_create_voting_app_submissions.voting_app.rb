# This migration comes from voting_app (originally 20130128165959)
class CreateVotingAppSubmissions < ActiveRecord::Migration
  def change
    create_table :voting_app_submissions do |t|
      t.text :description
      t.datetime :accepted_at

      t.timestamps
    end
  end
end
