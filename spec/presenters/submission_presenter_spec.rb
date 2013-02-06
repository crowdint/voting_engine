require 'spec_helper'

module VotingApp
  describe SubmissionPresenter do
    let(:user) { User.create }
    let(:user2) { User.create }
    let(:submission) { Submission.create description: 'foo', user_id: user.id }

    subject { SubmissionPresenter.new submission }

    describe '#can_vote?' do
      context 'When user is the owner' do
        it 'should be false' do
          expect(subject.can_vote?(user)).to be_false
        end
      end

      context 'When user is not the owner' do
        it 'should be true' do
          expect(subject.can_vote?(user2)).to be_true
        end
      end
    end

    describe '#liked_by' do
      context 'When user is the owner' do
        it 'should be false' do
          expect(subject.liked_by(user)).to be_false
        end
      end

      context 'When user is not the owner' do
        it 'should be true' do
          expect(subject.liked_by(user2)).to be_true
        end
      end
    end
  end
end
