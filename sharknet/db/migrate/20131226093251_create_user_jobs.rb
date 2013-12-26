class CreateUserJobs < ActiveRecord::Migration
  def change
    create_table :user_jobs do |t|
      t.string :title

      t.timestamps
    end
  end
end
