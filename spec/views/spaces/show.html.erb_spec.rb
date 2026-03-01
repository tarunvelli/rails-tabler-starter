require 'rails_helper'

RSpec.describe "spaces/show", type: :view do
  let(:user) { create(:user) }

  before do
    sign_in user
    @space = Space.create!(name: "Test Space", status: :active)
    assign(:space, @space)
  end

  it "renders the space name in the page title" do
    render
    expect(view.content_for(:page_title)).to include("Test Space")
  end
end
