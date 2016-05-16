require "rails_helper"

RSpec.describe OperationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/operations").to route_to("operations#index")
    end

    it "routes to #new" do
      expect(:get => "/operations/new").to route_to("operations#new")
    end

    it "routes to #show" do
      expect(:get => "/operations/1").to route_to("operations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/operations/1/edit").to route_to("operations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/operations").to route_to("operations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/operations/1").to route_to("operations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/operations/1").to route_to("operations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/operations/1").to route_to("operations#destroy", :id => "1")
    end

  end
end
