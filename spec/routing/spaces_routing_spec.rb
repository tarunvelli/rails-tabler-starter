require "rails_helper"

RSpec.describe SpacesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/spaces").to route_to("spaces#index")
    end

    it "routes to #new" do
      expect(get: "/spaces/new").to route_to("spaces#new")
    end

    it "routes to #show" do
      expect(get: "/spaces/1").to route_to("spaces#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/spaces/1/edit").to route_to("spaces#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/spaces").to route_to("spaces#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/spaces/1").to route_to("spaces#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/spaces/1").to route_to("spaces#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/spaces/1").to route_to("spaces#destroy", id: "1")
    end
  end
end
