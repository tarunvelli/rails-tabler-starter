require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'validations' do
    describe 'type inclusion' do
      it 'accepts valid type "common"' do
        role = Role.new(type: "common")
        role.valid?
        expect(role.errors[:type]).not_to be_present
      end

      it 'accepts valid type "custom"' do
        role = Role.new(type: "custom")
        role.valid?
        expect(role.errors[:type]).not_to be_present
      end

      it 'has space_id column' do
        expect(Role.column_names).to include('space_id')
      end
    end

    describe 'permissions validation' do
      context 'with valid permission key and value' do
        let(:role) { build(:role, permissions: { "create_user" => "true" }) }

        it 'is valid' do
          expect(role).to be_valid
        end
      end

      context 'with invalid permission key' do
        let(:role) { build(:role, permissions: { "invalid_permission" => "true" }) }

        it 'is invalid' do
          expect(role).not_to be_valid
          expect(role.errors[:permissions]).to include("Invalid permission key 'invalid_permission'")
        end
      end

      context 'with invalid permission value' do
        let(:role) { build(:role, permissions: { "create_user" => "invalid" }) }

        it 'is invalid' do
          expect(role).not_to be_valid
          expect(role.errors[:permissions]).to include("Invalid permission value 'invalid'")
        end
      end
    end
  end

  describe 'constants' do
    it 'defines COMMON_TYPE' do
      expect(Role::COMMON_TYPE).to eq("common")
    end

    it 'defines CUSTOM_TYPE' do
      expect(Role::CUSTOM_TYPE).to eq("custom")
    end

    it 'defines AVAILABLE_PERMISSIONS' do
      expect(Role::AVAILABLE_PERMISSIONS).to include("create_user", "read_user", "update_user", "delete_user")
    end
  end

  describe 'dynamic permission methods' do
    let(:role) { build(:role, permissions: { "create_user" => "true", "read_user" => "false" }) }

    it 'responds to can_create_user?' do
      expect(role).to respond_to(:can_create_user?)
    end

    it 'returns true for allowed permission' do
      expect(role.can_create_user?).to be true
    end

    it 'returns false for disallowed permission' do
      expect(role.can_read_user?).to be false
    end
  end

  describe '#common?' do
    context 'when type is common' do
      let(:role) { build(:role, type: "common") }

      it 'returns true' do
        expect(role.common?).to be true
      end
    end

    context 'when type is custom' do
      let(:role) { build(:role, type: "custom") }

      it 'returns false' do
        expect(role.common?).to be false
      end
    end
  end

  describe '#custom?' do
    context 'when type is custom' do
      let(:role) { build(:role, type: "custom") }

      it 'returns true' do
        expect(role.custom?).to be true
      end
    end

    context 'when type is common' do
      let(:role) { build(:role, type: "common") }

      it 'returns false' do
        expect(role.custom?).to be false
      end
    end
  end

  describe 'STI' do
    describe '.find_sti_class' do
      it 'returns Roles::Common for "common" type' do
        expect(Role.find_sti_class("common")).to eq(Roles::Common)
      end

      it 'returns Roles::Custom for "custom" type' do
        expect(Role.find_sti_class("custom")).to eq(Roles::Custom)
      end
    end
  end
end
