require "rails_helper"

RSpec.describe TimeSlotsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/time_slots").to route_to("time_slots#index")
    end


    it "routes to #show" do
      expect(:get => "/time_slots/1").to route_to("time_slots#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/time_slots").to route_to("time_slots#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/time_slots/1").to route_to("time_slots#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/time_slots/1").to route_to("time_slots#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/time_slots/1").to route_to("time_slots#destroy", :id => "1")
    end

  end
end
