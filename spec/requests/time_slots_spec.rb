require 'rails_helper'

RSpec.describe "TimeSlots", type: :request do
  describe "GET /time_slots" do
    it "works! (now write some real specs)" do
      get time_slots_path
      expect(response).to have_http_status(200)
    end
  end
end
