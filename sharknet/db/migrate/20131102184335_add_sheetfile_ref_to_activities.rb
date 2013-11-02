class AddSheetfileRefToActivities < ActiveRecord::Migration
  def change
    add_reference :activities, :sheetfile, index: true
  end
end
