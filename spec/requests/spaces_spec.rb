require 'rails_helper'

RSpec.describe "/spaces", type: :request do
  let(:user) { create(:user) }

  before do
    login_as user, scope: :user
  end

  describe "GET /index" do
    it "renders a successful response" do
      Space.create!(name: "Test Space")
      get spaces_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      space = Space.create!(name: "Test Space")
      get space_url(space)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_space_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      space = Space.create!(name: "Test Space")
      get edit_space_url(space)
      expect(response).to be_successful
    end
  end
end
