require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid without an email" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it "is invalid without a password" do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it "is invalid with a short password" do
      user = build(:user, password: "short", password_confirmation: "short")
      expect(user).not_to be_valid
    end

    it "is invalid with duplicate email" do
      create(:user, email: "test@example.com")
      user = build(:user, email: "test@example.com")
      expect(user).not_to be_valid
    end
  end

  describe "#name" do
    it "returns the full name" do
      user = build(:user, first_name: "John", last_name: "Doe")
      expect(user.name).to eq("John Doe")
    end
  end

  describe "#admin?" do
    it "returns false by default" do
      user = build(:user)
      expect(user.admin?).to be false
    end

    it "returns true for admin users" do
      user = build(:user, :admin)
      expect(user.admin?).to be true
    end
  end

  describe ".from_omniauth" do
    let(:auth) do
      OmniAuth::AuthHash.new(
        provider: "google_oauth2",
        uid: "123456",
        info: {
          email: "oauth@example.com",
          first_name: "Google",
          last_name: "User"
        }
      )
    end

    it "creates a new user from oauth data" do
      expect { described_class.from_omniauth(auth) }.to change(described_class, :count).by(1)
    end

    it "finds existing user by provider and uid" do
      create(:user, provider: "google_oauth2", uid: "123456", email: "oauth@example.com")
      expect { described_class.from_omniauth(auth) }.not_to change(described_class, :count)
    end

    it "sets the user attributes from oauth" do
      user = described_class.from_omniauth(auth)
      expect(user.email).to eq("oauth@example.com")
      expect(user.first_name).to eq("Google")
      expect(user.last_name).to eq("User")
    end
  end

  describe "#invalidate_all_sessions!" do
    it "changes the session token" do
      user = create(:user)
      old_token = user.session_token
      user.invalidate_all_sessions!
      expect(user.reload.session_token).not_to eq(old_token)
    end
  end

  describe "#get_role_in_site" do
    it "returns the role for the given site" do
      user = create(:user)
      site = create(:site)
      role = create(:role, type: Role::COMMON_TYPE)
      create(:user_role, user: user, site: site, role: role)

      expect(user.get_role_in_site(site)&.id).to eq(role.id)
    end
  end

  describe "#get_role_in_space" do
    it "delegates to site-based lookup for backward compatibility" do
      user = create(:user)
      site = create(:site)
      role = create(:role, type: Role::COMMON_TYPE)
      create(:user_role, user: user, site: site, role: role)

      expect(user.get_role_in_space(site)&.id).to eq(role.id)
    end
  end

  describe "devise modules" do
    it "includes expected devise modules" do
      expect(described_class.devise_modules).to include(
        :database_authenticatable,
        :registerable,
        :recoverable,
        :rememberable,
        :validatable,
        :lockable,
        :omniauthable,
        :trackable
      )
    end
  end
end
