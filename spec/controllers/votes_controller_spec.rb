require 'spec_helper'

module VotingApp
  describe VotesController do

    render_views

    describe 'POST :create' do
      let(:submission) { Submission.create(description: 'foo') }

      before do
        Submission.should_receive(:find).and_return submission
      end

      it 'should increment submission votes by one' do
        expect do
          post :create, submission_id: 1, format: :json
        end.to change{ submission.count_votes_total }.by(1)
      end
    end
  end
end
