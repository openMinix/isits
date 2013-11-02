class AddUserRefToTimesheets < ActiveRecord::Migration
  def change
    add_reference :timesheets, :user, index: true
  end
end
