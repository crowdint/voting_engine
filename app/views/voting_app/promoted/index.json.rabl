collection @promoted

attributes :id, :description, :created_at, :promoted_at

node(:votes) { |s| s.cached_votes_total }
