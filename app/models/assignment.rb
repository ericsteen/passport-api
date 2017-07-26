class Assignment < ApplicationRecord
  belongs_to :boat
  belongs_to :time_slot, foreign_key: :timeslot_id

  after_create :set_num_open

  validates :boat_id, uniqueness: { scope: :timeslot_id, message: "Boat can only be assigned to one time slot" }


  def decrement_num_open(size)
    self.num_open -= size
    self.save
  end

  def set_num_open
    self.num_open = boat.capacity
    self.save
  end
end
