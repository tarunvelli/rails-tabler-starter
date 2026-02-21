require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'associations' do
    it 'belongs to space' do
      expect(Subscription.reflect_on_association(:space).macro).to eq(:belongs_to)
    end

    it 'belongs to plan' do
      expect(Subscription.reflect_on_association(:plan).macro).to eq(:belongs_to)
    end
  end

  describe 'scopes' do
    describe '.active' do
      let(:space) { create(:space) }
      let(:plan) { create(:plan) }

      context 'when subscription has no end_date' do
        let!(:active_sub) { create(:subscription, space: space, plan: plan, end_date: nil) }

        it 'includes the subscription' do
          expect(Subscription.active).to include(active_sub)
        end
      end

      context 'when subscription has future end_date' do
        let!(:active_sub) { create(:subscription, space: space, plan: plan, end_date: 1.month.from_now) }

        it 'includes the subscription' do
          expect(Subscription.active).to include(active_sub)
        end
      end

      context 'when subscription has past end_date' do
        let!(:expired_sub) { create(:subscription, space: space, plan: plan, end_date: 1.day.ago) }

        it 'excludes the subscription' do
          expect(Subscription.active).not_to include(expired_sub)
        end
      end
    end
  end
end
