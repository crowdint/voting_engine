object @submission

attributes :id, :description, :created_at, :accepted_at, :promoted_at, :done_at, :rejected_at

node(:votes) { |s| s.cached_votes_total }
