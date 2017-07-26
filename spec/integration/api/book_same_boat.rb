require 'rails_helper'

describe "booking same boat in multiple time slots", :integration => true do

  it "should not be allowed to book" do
    post time_slots_path, params: { timeslot: { start_time: '1501138800', duration: 120 } }
    time_slot_id = JSON.parse(response.body)["id"]
    post boats_path, params: {  boat: { capacity: 8, name: "Amazon Express" } }
    boat1_id = JSON.parse(response.body)["id"]

    post assignments_path, params: { assignment: { timeslot_id: time_slot_id, boat_id: boat1_id } }
    post assignments_path, params: { assignment: { timeslot_id: time_slot_id, boat_id: boat1_id } }

    expect(response).to have_http_status(422)
    expect(response.body).to eq("{\"boat_id\":[\"Boat can only be assigned to one time slot\"]}")
  end
end
