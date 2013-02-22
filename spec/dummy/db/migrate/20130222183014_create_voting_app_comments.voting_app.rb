# This migration comes from voting_app (originally 20130222182630)
class CreateVotingAppComments < ActiveRecord::Migration
  def change
    create_table :voting_app_comments do |t|
      t.text :comment
      t.references :user
      t.references :request

      t.timestamps
    end
  end
end
