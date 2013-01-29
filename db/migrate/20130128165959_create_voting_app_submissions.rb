class CreateVotingAppSubmissions < ActiveRecord::Migration
  def change
    create_table :voting_app_submissions do |t|
      t.text :description
      t.datetime :accepted_at

      t.timestamps
    end
  end
end
