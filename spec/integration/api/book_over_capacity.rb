require 'rails_helper'

describe "booking over capacity", :integration => true do

  it "should not have timeslot1 open for more bookings" do
    post time_slots_path, params: { timeslot: { start_time: '1501138800', duration: 120 } }
    time_slot1_id = JSON.parse(response.body)["id"]
    post time_slots_path, params: { timeslot: { start_time: '1501142100', duration: 120 } }
    time_slot2_id = JSON.parse(response.body)["id"]

    post boats_path, params: {  boat: { capacity: 8, name: "Amazon Express" } }
    boat1_id = JSON.parse(response.body)["id"]

    post assignments_path, params: { assignment: { timeslot_id: time_slot1_id, boat_id: boat1_id } }
    post assignments_path, params: { assignment: { timeslot_id: time_slot2_id, boat_id: boat1_id } }
    get time_slots_path, params: { date: '2017-07-27' }

    expected = [
      {
        id:  time_slot1_id,
        start_time: 1501138800,
        duration: 120,
        availability: 8,
        customer_count: 0,
        boats: [boat1_id]
      },
      {
        id:  time_slot2_id,
        start_time: 1501142100,
        duration: 120,
        availability: 8,
        customer_count: 0,
        boats: [boat1_id]
      }
    ].as_json
# byebug
    parsed = JSON.parse(response.body)
    expect([JSON.parse(parsed.first), JSON.parse(parsed.second)]).to eq(expected)
    post bookings_path, params: { booking: { timeslot_id: time_slot2_id, size: 2 } }
    get time_slots_path, params: { date: "2017-07-27" }

    expected = [
        {
          id:  time_slot1_id,
          start_time: 1501138800,
          duration: 120,
          availability: 0,
          customer_count: 0,
          boats: [boat1_id]
        },
        {
          id:  time_slot2_id,
          start_time: 1501142100,
          duration: 120,
          availability: 6,
          customer_count: 2,
          boats: [boat1_id]
        }
    ].as_json

    parsed = JSON.parse(response.body)
    expect([JSON.parse(parsed.first), JSON.parse(parsed.second)]).to eq(expected)
   #Explanation: The first party of six goes on the Amazon Express, leaving 2 slots
   #on that boat and 4 on the other. The max party you can now handle is four.
  end
end
