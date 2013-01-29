class AddStateToSubmission < ActiveRecord::Migration
  def change
    add_column :voting_app_submissions, :state, :string
  end
end
