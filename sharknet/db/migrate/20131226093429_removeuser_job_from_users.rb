class RemoveuserJobFromUsers < ActiveRecord::Migration
  def change
  remove_column :users, :user_job
  end
end
