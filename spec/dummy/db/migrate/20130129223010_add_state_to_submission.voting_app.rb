# This migration comes from voting_app (originally 20130129222646)
class AddStateToSubmission < ActiveRecord::Migration
  def change
    add_column :voting_app_submissions, :state, :string
  end
end
