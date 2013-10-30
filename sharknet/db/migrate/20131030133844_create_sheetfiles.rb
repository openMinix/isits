class CreateSheetfiles < ActiveRecord::Migration
  def change
    create_table :sheetfiles do |t|
      t.date :day

      t.timestamps
    end
  end
end
