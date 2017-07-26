class AddNumOpenToAssignment < ActiveRecord::Migration[5.1]
  def change
    add_column :assignments, :num_open, :integer
  end
end
