object @submission

attributes :id, :description, :created_at, :accepted_at

node(:votes) { |s| s.cached_votes_total }
