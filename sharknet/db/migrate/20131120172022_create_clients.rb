class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :client_name

      t.timestamps
    end
  end
end
