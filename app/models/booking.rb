class Booking < ApplicationRecord
  belongs_to :time_slot, foreign_key: :timeslot_id

  validate :at_capacity?, on: :create

  after_create :adjust_availability

private

  def adjust_availability
    # adjust assignment capacity
    assignment = time_slot.assignments.detect {|assignment| assignment.num_open >= size }
    assignment.decrement_num_open(size)
    # ensure other assignments using boat are decapacitated
    boat_assigns = Assignment.where(boat_id: assignment.boat_id).where.not(time_slot: time_slot)
    boat_assigns.update_all(num_open: 0)
  end


  def at_capacity?
    unless Bookings::Policies::CapacityPolicy.allowed?(time_slot.assignments, size)
      errors[:base] <<  "There is no remaining capacity for the party size in this time slot"
    end
  end
end
