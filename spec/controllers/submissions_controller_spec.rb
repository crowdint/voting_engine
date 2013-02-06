require 'spec_helper'

module VotingApp
  describe SubmissionsController do

    render_views

    before do
      JsonSpec.configure do
        exclude_keys 'created_at', 'updated_at', 'accepted_at', 'done_at', 'promoted_at', 'rejected_at'
      end
    end

    describe 'POST :create' do
      let(:user) { User.create }

      before do
        controller.stub current_user: user
        post :create, submission: { description: 'foo bar' }, format: :json
      end

      it 'creates a submission' do

        expected_response = %(
        {
          "id": 1,
          "description": "foo bar",
          "created_at": "",
          "accepted_at": null,
          "votes": 0
        }
      )

        expect(response.body).to be_json_eql expected_response
        expect(response.status).to be 201
      end

      it 'should belong to the current user' do
        expect(Submission.last.user_id).to be user.id
      end
    end

    describe 'GET :index' do
      context 'Without explicit state' do
        before do
          Submission.create(description: 'foo')
          Submission.create(description: 'bar')
        end

        it 'shows submissions list' do
          get :index, format: :json

          expected_response = %(
            [{
              "id": 2,
              "description": "bar",
              "created_at": "",
              "accepted_at": null,
              "votes": 0
            },
            {
              "id": 1,
              "description": "foo",
              "created_at": "",
              "accepted_at": null,
              "votes": 0
            }]
          )

          expect(response.body).to be_json_eql expected_response
        end
      end

      context 'When accepted state' do
        before do
          Submission.create(description: 'foo')
          s = Submission.create(description: 'bar')
          s.promote!
          s.accept!
        end

        it 'shows accepted submissions list' do
          get :index, format: :json, state: 'accepted'

          expected_response = %(
              [{
                "id": 2,
                "description": "bar",
                "created_at": "",
                "votes": 0
              }]
            )
          expect(response.body).to be_json_eql(expected_response)
          response.body['votes'].to_i.should_not < 0
        end
      end

      context 'When done state' do
        before do
          Submission.create(description: 'foo')
          s = Submission.create(description: 'bar')
          s.promote!
          s.accept!
          s.complete!
        end

        it 'shows done submissions list' do
          get :index, format: :json, state: 'done'

          expected_response = %(
              [{
                "id": 2,
                "description": "bar",
                "created_at": "",
                "votes": 0
              }]
            )
          expect(response.body).to be_json_eql(expected_response)
          response.body['votes'].to_i.should_not < 0
        end
      end

      context 'When promoted state' do
        before do
          Submission.create(description: 'foo')
          Submission.create(description: 'bar').promote!
        end

        it 'shows promoted submissions list' do
          get :index, format: :json, state: 'promoted'

          expected_response = %(
              [{
                "id": 2,
                "description": "bar",
                "created_at": "",
                "votes": 0
              }]
            )
          expect(response.body).to be_json_eql(expected_response)
          response.body['votes'].to_i.should_not < 0
        end
      end

      context 'When rejected state' do
        before do
          Submission.create(description: 'foo')
          s = Submission.create(description: 'bar')
          s.promote!
          s.reject!
        end

        it 'shows rejected submissions list' do
          get :index, format: :json, state: 'rejected'

          expected_response = %(
              [{
                "id": 2,
                "description": "bar",
                "created_at": "",
                "votes": 0
              }]
            )
          expect(response.body).to be_json_eql(expected_response)
          response.body['votes'].to_i.should_not < 0
        end
      end
    end

    describe 'PUT :update' do
      let(:submission) { Submission.create(description: 'foo') }

      before do
        Submission.should_receive(:find).and_return submission
      end

      it 'updates a given submission' do
        expect do
          put :update, submission: { description: 'bar' }, id: 1, format: :json
        end.to change{submission.description}.from('foo').to('bar')
      end
    end

    describe 'DELETE :destroy' do
      before do
        Submission.create(description: 'foo')
      end

      it 'destroys a given submission' do
        expect do
          delete :destroy, id: 1, format: :json
        end.to change{Submission.count}.from(1).to(0)
      end
    end

    describe 'GET :show' do

      context 'When submission exists' do
        before do
          Submission.create(description: 'foo')
        end

        it 'shows a given submission in detail' do
          get :show, id: 1, format: :json
          expected_response = %(
            {
              "id": 1,
              "description": "foo",
              "created_at": "",
              "accepted_at": null,
              "votes": 0
            }
          )
          expect(response.body).to be_json_eql expected_response
        end
      end

      context "When submission doesn't exist" do
        it 'should throw ActiveRecord::RecordNotFound Exception' do
          expect{get :show, id: 1, format: :json}.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
