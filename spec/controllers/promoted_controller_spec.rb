require 'spec_helper'

module VotingApp
  describe PromotedController do
    render_views
    describe 'GET :index' do
      before do
        Submission.create(description: 'foo')
        Submission.create(description: 'bar').promote!
      end

      it 'shows accepted submissions list' do
        get :index, format: :json

        expected_response = %(
              [{
                "id": 2,
                "description": "bar",
                "created_at": "",
                "votes": 0
              }]
            )
        expect(response.body).to be_json_eql(expected_response).excluding(:promoted_at)
        response.body['votes'].to_i.should_not < 0
      end
    end
  end
end
