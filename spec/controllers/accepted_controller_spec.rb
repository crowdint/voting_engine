require 'spec_helper'

module VotingApp
  describe AcceptedController do
    describe 'GET :index' do
      before do
        Submission.create(description: 'foo')
        Submission.create(description: 'bar', accepted_at: 'Mon, 28 Jan 2013 22:12:08 UTC +00:00')
      end

      it 'shows accepted submissions list' do
        get :index, format: :json

        expected_response = %(
              [{
                "id": 2,
                "description": "bar",
                "created_at": "",
                "accepted_at": "2013-01-28T22:12:08Z",
                "votes": 0
              }]
            )
        expect(response.body).to be_json_eql expected_response
      end
    end
  end
end
