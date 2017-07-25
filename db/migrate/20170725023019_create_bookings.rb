class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.references :timeslot_id
      t.integer :size

      t.timestamps
    end
  end
end
