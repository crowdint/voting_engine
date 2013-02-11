object @submission

attributes :id, :description, :state, :created_at, :accepted_at, :promoted_at, :done_at,
           :rejected_at, :mood

node(:votes) { |s| s.cached_votes_total }
