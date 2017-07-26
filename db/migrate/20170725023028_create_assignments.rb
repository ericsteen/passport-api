class CreateAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :assignments do |t|
      t.integer :timeslot_id
      t.references :boat

      t.timestamps
    end
  end
end
