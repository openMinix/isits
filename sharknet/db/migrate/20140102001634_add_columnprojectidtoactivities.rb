class AddColumnprojectidtoactivities < ActiveRecord::Migration
  def change
     add_column :activities, :project_id, :integer 
  end
end
