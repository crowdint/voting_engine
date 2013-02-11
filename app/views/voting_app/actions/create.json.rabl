object @submission
cache @submission

node(:votes) { |s| s.cached_votes_total }
