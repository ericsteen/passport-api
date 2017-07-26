require 'rails_helper'

RSpec.describe "TimeSlots", type: :request do
  describe "GET /time_slots" do
    it "sends a list of time_slots for a given day" do
      FactoryGirl.create_list(:time_slot, 1)
      date = '2014-07-22'.to_datetime
      date_range = date.beginning_of_day..date.end_of_day
      get '/api/time_slots', params: { date: date }

      json = JSON.parse(response.body)

      # test for the 200 status-code
      expect(response).to be_success

      # check to make sure the right amount of messages are returned
      expect(json.length).to eq(1)
      time_slot = JSON.parse(json.first).with_indifferent_access
      expect(time_slot[:id]).to be_present
      expect(time_slot[:start_time]).to be_present
      expect(DateTime.strptime(time_slot[:start_time].to_s,'%s')).to be_between(date_range.begin, date_range.end)
      expect(time_slot[:duration]).to be_present
      expect(time_slot[:availability]).to be_present
      expect(time_slot[:customer_count]).to be_present
      expect(time_slot[:boats]).to be_empty
    end
  end

  describe "POST /time_slots" do
    it "stores a new time slot" do
      post time_slots_path, params: { time_slot: { start_time: 3.days.from_now, duration: 120 } }

      expect(response).to have_http_status(201)
    end
  end
end
