require 'rails_helper'

describe "booking under capacity", :integration => true do

  it "should have openings for more bookings" do
    post time_slots_path, params: { timeslot: { start_time: '1501138800', duration: 120 } }
    time_slot_id = JSON.parse(response.body)["id"]
    post boats_path, params: {  boat: { capacity: 8, name: "Amazon Express" } }
    boat1_id = JSON.parse(response.body)["id"]
    post boats_path, params: { boat: { capacity: 4, name: "Amazon Express Mini" } }
    boat2_id = JSON.parse(response.body)["id"]


    post assignments_path, params: { assignment: { timeslot_id: time_slot_id, boat_id: boat1_id } }
    post assignments_path, params: { assignment: { timeslot_id: time_slot_id, boat_id: boat2_id } }
    get time_slots_path, params: { date: '2017-07-27' }

    expected = {
      id:  1,
      start_time: 1501138800,
      duration: 120,
      availability: 8,
      customer_count: 0,
      boats: [1, 2]
    }.to_json

    expect(JSON.parse(response.body).first).to eq(expected)
    post bookings_path, params: { booking: { timeslot_id: time_slot_id, size: 6 } }
    get time_slots_path, params: { date: "2017-07-27" }

    expected = {
      id:  1,
      start_time: 1501138800,
      duration: 120,
      availability: 4,
      customer_count: 6,
      boats: [1, 2]
    }.to_json

   expect(JSON.parse(response.body).first).to eq(expected)
   #Explanation: The first party of six goes on the Amazon Express, leaving 2 slots
   #on that boat and 4 on the other. The max party you can now handle is four.
  end
end
