class AddReferencesToResults < ActiveRecord::Migration
  def change
  	add_foreign_key :results, :mass_params
  	add_foreign_key :results, :mass_data
  	add_foreign_key :results, :users
  end
end
