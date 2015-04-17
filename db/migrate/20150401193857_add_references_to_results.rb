class AddReferencesToResults < ActiveRecord::Migration
  def change
  	add_column :results, :mass_params_id, :integer
  	add_column :results, :mass_data_id, :integer
  	add_column :results, :user_id, :integer

  	add_index :results, :mass_params_id
  	add_index :results, :mass_data_id
  	add_index :results, :user_id

  	add_foreign_key :results, :mass_params
  	add_foreign_key :results, :mass_data
  	add_foreign_key :results, :users
  end
end
