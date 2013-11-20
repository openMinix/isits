class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :dept_name
      t.belongs_to :division, index: true

      t.timestamps
    end
  end
end
