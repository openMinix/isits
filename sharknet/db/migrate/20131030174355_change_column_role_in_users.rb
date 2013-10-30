class ChangeColumnRoleInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :role, :user_job
    rename_column :users, :name, :user_fullname
  end
end
