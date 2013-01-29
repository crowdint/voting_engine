require 'spec_helper'

module VotingApp
  describe VotesController do
    describe 'POST :create' do
      let(:submission) { Submission.create(description: 'foo') }

      before do
        Submission.should_receive(:find).and_return submission
      end

      it 'increment votes on the submission' do

      end
    end
  end
end
