class CreateTimeSlots < ActiveRecord::Migration[5.1]
  def change
    create_table :time_slots do |t|
      t.date_time :start_time
      t.integer :duration

      t.timestamps
    end
  end
end
