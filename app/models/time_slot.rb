class TimeSlot < ApplicationRecord
  has_many :bookings, foreign_key: :timeslot_id
  has_many :assignments, foreign_key: :timeslot_id
  has_many :boats, through: :assignments

  def availability
    assignments.maximum(:num_open)
  end

  def customer_count
    bookings.sum(:size)
  end

  def to_builder
    Jbuilder.new do |time_slot|
      time_slot.id id
      time_slot.start_time start_time.to_time.to_i
      time_slot.duration duration
      time_slot.availability availability
      time_slot.customer_count customer_count
      time_slot.boats boats.map(&:id)
    end
  end

end
