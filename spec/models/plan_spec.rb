require 'rails_helper'

RSpec.describe Plan, type: :model do
  describe 'associations' do
    it 'has many subscriptions' do
      expect(Plan.reflect_on_association(:subscriptions).macro).to eq(:has_many)
    end

    it 'has many spaces through subscriptions' do
      expect(Plan.reflect_on_association(:spaces).macro).to eq(:has_many)
    end
  end

  describe '.free_plan' do
    let!(:free_plan) { create(:plan, name: "Free") }

    it 'returns the plan with name Free' do
      expect(Plan.free_plan).to eq(free_plan)
    end

    context 'when no free plan exists' do
      before do
        Plan.delete_all
      end

      it 'returns nil' do
        expect(Plan.free_plan).to be_nil
      end
    end
  end
end
