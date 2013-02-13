object @request
cache @request

node(:votes) { |s| s.cached_votes_total }
