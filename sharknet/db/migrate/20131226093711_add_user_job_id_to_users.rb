class AddUserJobIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_job_id, :integer
  end
end
