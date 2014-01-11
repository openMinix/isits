class AddVacationToSheetfile < ActiveRecord::Migration
  def change
    add_column :sheetfiles, :vacation, :integer
  end
end
