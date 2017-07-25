class CreateAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :assignments do |t|
      t.references :timeslot_id
      t.references :boat_id

      t.timestamps
    end
  end
end
