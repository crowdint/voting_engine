require 'spec_helper'

module VotingApp
  describe RequestsController do

    render_views

    before do
      JsonSpec.configure do
        exclude_keys 'created_at', 'updated_at', 'accepted_at', 'done_at', 'promoted_at', 'rejected_at'
      end
    end

    describe 'POST :create' do
      let(:user) { User.create(name:'test')}

      before do
        controller.stub current_user: user
        post :create, request: { description: 'foo bar' }, format: :json
      end

      it 'creates a request' do

        expected_response = %(
        {
          "id": 1,
          "description": "foo bar",
          "state": "submitted",
          "created_at": "",
          "accepted_at": null,
          "votes": 0,
          "name": "test",
          "category": null
        }
      )

        expect(response.body).to be_json_eql expected_response
        expect(response.status).to be 201
      end

      it 'should belong to the current user' do
        expect(Request.last.user_id).to be user.id
      end
    end

    describe 'GET :index' do
      let(:user) { User.create(name:'test')}
      context 'Without explicit state' do
        before do
          Request.create(description: 'foo', user_id: user.id)
          Request.create(description: 'bar', user_id: user.id)
        end

        it 'shows requests list' do
          get :index, format: :json

          expected_response = %(
            [{
              "id": 2,
              "description": "bar",
              "state": "submitted",
              "created_at": "",
              "accepted_at": null,
              "votes": 0,
              "name": "test",
              "category": null
            },
            {
              "id": 1,
              "description": "foo",
              "state": "submitted",
              "created_at": "",
              "accepted_at": null,
              "votes": 0,
              "name": "test",
              "category": null
            }]
          )

          expect(response.body).to be_json_eql expected_response
        end
      end

      context 'When accepted state' do
        before do
          Request.create(description: 'foo', user_id: user.id)
          s = Request.create(description: 'bar', user_id: user.id)
          s.promote!
          s.accept!
        end

        it 'shows accepted requests list' do
          get :index, format: :json, state: 'accepted'

          expected_response = %(
              [{
                "id": 2,
                "description": "bar",
                "state": "accepted",
                "created_at": "",
                "votes": 0,
                "name": "test",
                "category": null
              }]
            )
          expect(response.body).to be_json_eql(expected_response)
          response.body['votes'].to_i.should_not < 0
        end
      end

      context 'When done state' do
        before do
          Request.create(description: 'foo', user_id: user.id)
          s = Request.create(description: 'bar', user_id: user.id)
          s.promote!
          s.accept!
          s.complete!
        end

        it 'shows done requests list' do
          get :index, format: :json, state: 'done'

          expected_response = %(
              [{
                "id": 2,
                "state": "done",
                "description": "bar",
                "created_at": "",
                "votes": 0,
                "name": "test",
                "category": null
              }]
            )
          expect(response.body).to be_json_eql(expected_response)
          response.body['votes'].to_i.should_not < 0
        end
      end

      context 'When promoted state' do
        before do
          Request.create(description: 'foo', user_id: user.id)
          Request.create(description: 'bar', user_id: user.id).promote!
        end

        it 'shows promoted requests list' do
          get :index, format: :json, state: 'promoted'

          expected_response = %(
              [{
                "id": 2,
                "state": "promoted",
                "description": "bar",
                "created_at": "",
                "votes": 0,
                "name": "test",
                "category": null
              }]
            )
          expect(response.body).to be_json_eql(expected_response)
          response.body['votes'].to_i.should_not < 0
        end
      end

      context 'When rejected state' do
        before do
          Request.create(description: 'foo', user_id: user.id)
          s = Request.create(description: 'bar', user_id: user.id)
          s.promote!
          s.reject!
        end

        it 'shows rejected requests list' do
          get :index, format: :json, state: 'rejected'

          expected_response = %(
              [{
                "id": 2,
                "state": "rejected",
                "description": "bar",
                "created_at": "",
                "votes": 0,
                "name": "test",
                "category": null
              }]
            )
          expect(response.body).to be_json_eql(expected_response)
          response.body['votes'].to_i.should_not < 0
        end
      end
    end

    #describe 'PUT :update' do
    #  let(:submission) { Submission.create(description: 'foo') }
    #
    #  before do
    #    Submission.should_receive(:find).and_return submission
    #  end
    #
    #  it 'updates a given submission' do
    #    expect do
    #      put :update, submission: { description: 'bar' }, id: 1, format: :json
    #    end.to change{submission.description}.from('foo').to('bar')
    #  end
    #end

    #describe 'DELETE :destroy' do
    #  before do
    #    Submission.create(description: 'foo')
    #  end
    #
    #  it 'destroys a given submission' do
    #    expect do
    #      delete :destroy, id: 1, format: :json
    #    end.to change{Submission.count}.from(1).to(0)
    #  end
    #end

    describe 'GET :show' do
      let(:user) { User.create(name:'test') }
      context 'When request exists' do
        before do
          Request.create(description: 'foo', user_id: user.id)
        end

        it 'shows a given request in detail' do
          get :show, id: 1, format: :json
          expected_response = %(
            {
              "id": 1,
              "state": "submitted",
              "description": "foo",
              "created_at": "",
              "accepted_at": null,
              "votes": 0,
              "name": "test",
              "category": null
            }
          )
          expect(response.body).to be_json_eql expected_response
        end
      end

      context "When request doesn't exist" do
        it 'should throw RecordNotFound Exception' do
          get :show, id: 1, format: :json
          expect(response.status).to be 404
        end
      end
    end
  end
end
