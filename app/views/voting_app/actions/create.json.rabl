object @request

node(:votes) { |s| s.cached_votes_total }

child(:comments) { attributes :comment, :user_id, :name, :created_at }
