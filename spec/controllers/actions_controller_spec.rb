require 'spec_helper'

module VotingApp
  describe ActionsController do

    render_views

    describe 'voting for your own requests' do
      let(:user) { User.create }
      let(:request) { Request.create description: 'foo', user_id: user.id }

      before do
        controller.stub current_user: user
      end

      it 'should not be able to vote' do
        expect do
          post :create, request_id: request.id, format: :json, request_action: 'vote'
        end.not_to change{ request.reload.cached_votes_total }.from(0).to(1)
      end
    end

    describe 'POST :create as normal user' do
      let(:user) { User.create }
      let(:request) { Request.create(description: 'foo', user_id: user.id) }

      context 'When voting' do
        before do
          Request.should_receive(:find).and_return request
        end

        it 'should increment request votes by one' do
          expect do
            post :create, request_id: 1, format: :json, request_action: 'vote'
          end.to change{ request.count_votes_total }.by(1)
        end
      end

      context 'When accepting' do
        it 'should not modify the request status' do
          Request.should_not_receive(:find)
          post :create, request_id: 1, format: :json, request_action: 'accept'
        end

        it 'should respond with an unauthorized status' do
          post :create, request_id: 1, format: :json, request_action: 'accept'
          expect(response.status).to be 401
        end
      end

      context 'When rejecting' do
        it 'should not modify the request status' do
          Request.should_not_receive(:find)
          post :create, request_id: 1, format: :json, request_action: 'reject'
        end

        it 'should respond with an unauthorized status' do
          post :create, request_id: 1, format: :json, request_action: 'reject'
          expect(response.status).to be 401
        end
      end

      context 'When completing' do
        it 'should not modify the request status' do
          Request.should_not_receive(:find)
          post :create, request_id: 1, format: :json, request_action: 'complete'
        end

        it 'should respond with an unauthorized status' do
          post :create, request_id: 1, format: :json, request_action: 'complete'
          expect(response.status).to be 401
        end
      end

      context 'When commenting a request' do
        before do
          Request.should_receive(:find).and_return request
          controller.should_receive(:current_user).and_return user
          post :create, request_id: 1, format: :json, request_action: 'comment', comment: 'foo'
        end

        it 'Increment the request comments count' do
          expect(request.comments.count).to be 1
        end

        it 'response should contain the new comment' do
          expected_response = %(
            {
              "comments": [
                { "comment": "foo", "user_id": #{user.id} }
              ],
              "votes": 0
            }
          )
          expect(response.body).to be_json_eql expected_response
        end
      end
    end

    describe 'POST :create as admin user' do
      let(:user) { User.create }
      let(:user2) { User.create }
      let(:request) { Request.create(description: 'foo', user_id: user2.id) }

      before do
        user.stub :admin? => true
        controller.stub current_user: user
        Request.should_receive(:find).and_return request
      end

      context 'When voting' do
        it 'should increment request votes by one' do
          expect do
            post :create, request_id: 1, format: :json, request_action: 'vote'
          end.to change{ request.count_votes_total }.by(1)
        end
      end

      context 'When accepting' do
        before do
          request.promote!
        end

        it 'should modify the request status' do
          expect do
            post :create, request_id: 1, format: :json, request_action: 'accept'
          end.to change{ request.state }.from('promoted').to('accepted')
        end
      end

      context 'When rejecting' do
        before do
          request.promote!
        end

        it 'should modify the request status' do
          expect do
            post :create, request_id: 1, format: :json, request_action: 'reject'
          end.to change{ request.state }.from('promoted').to('rejected')
        end
      end

      context 'When completing' do
        before do
          request.promote!
          request.accept!
        end

        it 'should modify the request status' do
          expect do
            post :create, request_id: 1, format: :json, request_action: 'complete'
          end.to change{ request.state }.from('accepted').to('done')
        end
      end
    end
  end
end
