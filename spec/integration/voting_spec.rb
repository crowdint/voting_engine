require 'spec_helper'

module VotingApp
  describe 'Voting a request' do
    let(:user1) { User.create }
    let(:user2) { User.create }
    let(:user3) { User.create }
    let(:request) { Request.create description: 'foo' }

    context 'A request about to be promoted' do
      before do
        Engine.config.votes_limit = 3
        request.liked_by user1
        request.liked_by user2
      end

      it 'should be promoted when reaches the specified limit of votes' do
        expect do
          request.liked_by user3
        end.to change{ request.state }.from('submitted').to('promoted')
      end
    end
  end
end
