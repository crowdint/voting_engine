require 'spec_helper'

module VotingApp
  describe SubmissionsController do

    render_views

    describe 'POST :create' do
      it 'creates a submission' do
        post :create, submission: { description: 'foo bar' }, format: :json

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
    end

    describe 'GET :index' do
      before do
        Submission.create(description: 'foo')
        Submission.create(description: 'bar')
      end

      it 'shows submissions list' do
        get :index, format: :json

        expected_response = %(
          [{
            "id": 1,
            "description": "bar",
            "created_at": "",
            "accepted_at": null,
            "votes": 0
          },
          {
            "id": 2,
            "description": "foo",
            "created_at": "",
            "accepted_at": null,
            "votes": 0
          }]
        )

        expect(response.body).to be_json_eql expected_response
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
        it 'shows a given submission in detail' do
          expect{get :show, id: 1, format: :json}.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
