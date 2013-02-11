require 'spec_helper'

module VotingApp
  describe ActionsController do

    render_views

    describe 'voting for your own submissions' do
      let(:user) { User.create }
      let(:submission) { Submission.create description: 'foo', user_id: user.id }

      before do
        controller.stub current_user: user
      end

      it 'should not be able to vote' do
        expect do
          post :create, submission_id: submission.id, format: :json, submission_action: 'vote'
        end.not_to change{ submission.reload.cached_votes_total }.from(0).to(1)
      end
    end

    describe 'POST :create as normal user' do
      let(:user) { User.create }
      let(:submission) { Submission.create(description: 'foo', user_id: user.id) }

      context 'When voting' do
        before do
          Submission.should_receive(:find).and_return submission
        end

        it 'should increment submission votes by one' do
          expect do
            post :create, submission_id: 1, format: :json, submission_action: 'vote'
          end.to change{ submission.count_votes_total }.by(1)
        end
      end

      context 'When accepting' do
        it 'should not modify the submission status' do
          Submission.should_not_receive(:find)
          post :create, submission_id: 1, format: :json, submission_action: 'accept'
        end

        it 'should respond with an unauthorized status' do
          post :create, submission_id: 1, format: :json, submission_action: 'accept'
          expect(response.status).to be 401
        end
      end

      context 'When rejecting' do
        it 'should not modify the submission status' do
          Submission.should_not_receive(:find)
          post :create, submission_id: 1, format: :json, submission_action: 'reject'
        end

        it 'should respond with an unauthorized status' do
          post :create, submission_id: 1, format: :json, submission_action: 'reject'
          expect(response.status).to be 401
        end
      end

      context 'When completing' do
        it 'should not modify the submission status' do
          Submission.should_not_receive(:find)
          post :create, submission_id: 1, format: :json, submission_action: 'complete'
        end

        it 'should respond with an unauthorized status' do
          post :create, submission_id: 1, format: :json, submission_action: 'complete'
          expect(response.status).to be 401
        end
      end
    end

    describe 'POST :create as admin user' do
      let(:user) { User.create }
      let(:user2) { User.create }
      let(:submission) { Submission.create(description: 'foo', user_id: user2.id) }

      before do
        user.stub :admin? => true
        controller.stub current_user: user
        Submission.should_receive(:find).and_return submission
      end

      context 'When voting' do
        it 'should increment submission votes by one' do
          expect do
            post :create, submission_id: 1, format: :json, submission_action: 'vote'
          end.to change{ submission.count_votes_total }.by(1)
        end
      end

      context 'When accepting' do
        before do
          submission.promote!
        end

        it 'should modify the submission status' do
          expect do
            post :create, submission_id: 1, format: :json, submission_action: 'accept'
          end.to change{ submission.state }.from('promoted').to('accepted')
        end
      end

      context 'When rejecting' do
        before do
          submission.promote!
        end

        it 'should modify the submission status' do
          expect do
            post :create, submission_id: 1, format: :json, submission_action: 'reject'
          end.to change{ submission.state }.from('promoted').to('rejected')
        end
      end

      context 'When completing' do
        before do
          submission.promote!
          submission.accept!
        end

        it 'should modify the submission status' do
          expect do
            post :create, submission_id: 1, format: :json, submission_action: 'complete'
          end.to change{ submission.state }.from('accepted').to('done')
        end
      end
    end
  end
end
