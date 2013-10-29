class CreateTimesheets < ActiveRecord::Migration
  def change
    create_table :timesheets do |t|
      t.string :status
      t.date :period

      t.timestamps
    end
  end
end
