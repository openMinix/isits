class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :project_name
      t.belongs_to :client, index: true

      t.timestamps
    end
  end
end
