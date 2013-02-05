# This migration comes from voting_app (originally 20130205194836)
class AddPromotedAtToSubmissions < ActiveRecord::Migration
  def change
    add_column :voting_app_submissions, :promoted_at, :datetime
    add_column :voting_app_submissions, :rejected_at, :datetime
    add_column :voting_app_submissions, :done_at, :datetime
  end
end
