require 'rails_helper'

RSpec.describe "Assignments", type: :request do
  describe "POST /assignments" do
    it "creates a new assignment" do
      time_slot = FactoryGirl.create(:time_slot)
      boat = FactoryGirl.create(:boat)

      post assignments_path, params: { assignment: { time_slot_id: time_slot.id, boat_id: boat.id } }

      expect(response).to have_http_status(201)
    end
  end
end
