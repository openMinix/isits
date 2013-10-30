class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :type_activity
      t.string :description
      t.integer :work_hours
      t.boolean :extra

      t.timestamps
    end
  end
end
