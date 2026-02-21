require 'rails_helper'

RSpec.describe UserRole, type: :model do
  describe 'associations' do
    it 'belongs to user' do
      expect(UserRole.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it 'belongs to space' do
      expect(UserRole.reflect_on_association(:space).macro).to eq(:belongs_to)
    end

    it 'belongs to role' do
      expect(UserRole.reflect_on_association(:role).macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    describe '#role_belongs_to_space' do
      let(:space) { create(:space) }
      let(:user) { create(:user) }

      context 'when role is common' do
        let(:common_role) { create(:role, :common) }

        it 'is valid' do
          user_role = build(:user_role, user: user, space: space, role: common_role)
          expect(user_role).to be_valid
        end
      end

      context 'when role is custom with matching space_id' do
        let(:custom_role) { create(:role, :custom, space_id: space.id) }

        it 'is valid' do
          user_role = build(:user_role, user: user, space: space, role: custom_role)
          expect(user_role).to be_valid
        end
      end

      context 'when role is custom with different space_id' do
        let(:other_space) { create(:space) }
        let(:custom_role) { create(:role, :custom, space_id: other_space.id) }

        it 'is invalid' do
          user_role = build(:user_role, user: user, space: space, role: custom_role)
          expect(user_role).not_to be_valid
          expect(user_role.errors[:base]).to include("invalid role for space")
        end
      end
    end
  end
end
