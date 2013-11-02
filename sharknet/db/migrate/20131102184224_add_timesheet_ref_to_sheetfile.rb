class AddTimesheetRefToSheetfile < ActiveRecord::Migration
  def change
    add_reference :sheetfiles, :timesheet, index: true
  end
end
