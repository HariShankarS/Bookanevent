class AddColumnToEvent < ActiveRecord::Migration
  def change
  	add_column :events, :ticketcost, :float
  end
end
