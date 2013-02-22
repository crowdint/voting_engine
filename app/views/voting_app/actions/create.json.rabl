object @request
cache @request

node(:votes) { |s| s.cached_votes_total }

child(:comments) { attributes :comment, :user_id }

