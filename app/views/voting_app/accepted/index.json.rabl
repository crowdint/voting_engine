collection @accepted

attributes :id, :description, :created_at, :accepted_at

node(:votes) { |s| s.votes.size }
