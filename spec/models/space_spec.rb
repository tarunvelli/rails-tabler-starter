require 'rails_helper'

RSpec.describe Space, type: :model do
  describe 'associations' do
    it 'has many user_roles' do
      expect(Space.reflect_on_association(:user_roles).macro).to eq(:has_many)
    end

    it 'has many users through user_roles' do
      expect(Space.reflect_on_association(:users).macro).to eq(:has_many)
    end

    it 'has many subscriptions' do
      expect(Space.reflect_on_association(:subscriptions).macro).to eq(:has_many)
    end

    it 'has many plans through subscriptions' do
      expect(Space.reflect_on_association(:plans).macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    it 'validates presence of name' do
      space = Space.new(name: nil)
      space.valid?
      expect(space.errors[:name]).to include("can't be blank")
    end
  end

  describe 'enums' do
    it 'defines status enum' do
      expect(Space.statuses).to include('active' => 0, 'archived' => 1)
    end
  end

  describe '#all_roles' do
    let(:space) { create(:space) }
    let(:common_role) { create(:role, :common) }
    let(:custom_role) { create(:role, :custom, space_id: space.id) }

    before do
      common_role
      custom_role
    end

    it 'returns both common and space-specific roles' do
      expect(space.all_roles).to include(common_role)
      expect(space.all_roles).to include(custom_role)
    end
  end

  describe '#active_subscription' do
    let(:space) { create(:space) }
    let(:plan) { create(:plan) }

    context 'when there is an active subscription' do
      let!(:subscription) { create(:subscription, space: space, plan: plan, end_date: nil) }

      it 'returns the active subscription' do
        expect(space.active_subscription).to eq(subscription)
      end
    end

    context 'when there is no active subscription' do
      it 'returns a new subscription with free plan' do
        allow(Plan).to receive(:free_plan).and_return(plan)
        expect(space.active_subscription.plan).to eq(plan)
      end
    end

    context 'when subscription has expired' do
      let!(:expired_subscription) { create(:subscription, space: space, plan: plan, end_date: 1.day.ago) }

      it 'returns a new subscription with free plan' do
        allow(Plan).to receive(:free_plan).and_return(plan)
        expect(space.active_subscription.plan).to eq(plan)
      end
    end
  end
end
