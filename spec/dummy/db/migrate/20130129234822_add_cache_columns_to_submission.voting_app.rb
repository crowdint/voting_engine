# This migration comes from voting_app (originally 20130129234637)
class AddCacheColumnsToSubmission < ActiveRecord::Migration
  def self.up
    add_column :voting_app_submissions, :cached_votes_total, :integer, :default => 0
    add_column :voting_app_submissions, :cached_votes_score, :integer, :default => 0
    add_column :voting_app_submissions, :cached_votes_up, :integer, :default => 0
    add_column :voting_app_submissions, :cached_votes_down, :integer, :default => 0
    add_index  :voting_app_submissions, :cached_votes_total
    add_index  :voting_app_submissions, :cached_votes_score
    add_index  :voting_app_submissions, :cached_votes_up
    add_index  :voting_app_submissions, :cached_votes_down
  end

  def self.down
    remove_column :voting_app_submissions, :cached_votes_total
    remove_column :voting_app_submissions, :cached_votes_score
    remove_column :voting_app_submissions, :cached_votes_up
    remove_column :voting_app_submissions, :cached_votes_down
  end
end
