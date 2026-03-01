require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has many user_roles' do
      expect(User.reflect_on_association(:user_roles).macro).to eq(:has_many)
    end

    it 'has many spaces through user_roles' do
      expect(User.reflect_on_association(:spaces).macro).to eq(:has_many)
    end
  end

  describe 'devise modules' do
    it 'includes database_authenticatable' do
      expect(User.devise_modules).to include(:database_authenticatable)
    end

    it 'includes registerable' do
      expect(User.devise_modules).to include(:registerable)
    end

    it 'includes recoverable' do
      expect(User.devise_modules).to include(:recoverable)
    end

    it 'includes rememberable' do
      expect(User.devise_modules).to include(:rememberable)
    end

    it 'includes validatable' do
      expect(User.devise_modules).to include(:validatable)
    end

    it 'includes invitable' do
      expect(User.devise_modules).to include(:invitable)
    end
  end

  describe 'enums' do
    it 'defines status enum' do
      expect(User.statuses).to include('active' => 0, 'archived' => 1)
    end
  end

  describe '#name' do
    let(:user) { build(:user, first_name: "John", last_name: "Doe") }

    it 'returns full name' do
      expect(user.name).to eq("John Doe")
    end
  end

  describe '#admin?' do
    context 'when user is admin' do
      let(:admin_user) { build(:user, admin: true) }

      it 'returns true' do
        expect(admin_user.admin?).to be true
      end
    end

    context 'when user is not admin' do
      let(:regular_user) { build(:user, admin: false) }

      it 'returns false' do
        expect(regular_user.admin?).to be false
      end
    end
  end

  describe '#authenticatable_salt' do
    let(:user) { build(:user, session_token: "abc123") }

    it 'returns salt including session token' do
      expect(user.authenticatable_salt).to include("abc123")
    end
  end

  describe '#invalidate_all_sessions!' do
    let(:user) { create(:user) }

    it 'updates session token' do
      old_token = user.session_token
      user.invalidate_all_sessions!
      expect(user.session_token).not_to eq(old_token)
    end
  end

  describe '#get_role_in_space' do
    let(:user) { create(:user) }
    let(:space) { create(:space) }
    let(:role) { create(:role, :common) }
    let!(:user_role) { create(:user_role, user: user, space: space, role: role) }

    it 'returns the role for the given space' do
      returned_role = user.get_role_in_space(space)
      expect(returned_role.id).to eq(role.id)
    end

    context 'when user has no role in space' do
      let(:other_space) { create(:space) }

      it 'returns nil' do
        expect { user.get_role_in_space(other_space) }.not_to raise_error
        expect(user.get_role_in_space(other_space)).to be_nil
      end
    end
  end
end
