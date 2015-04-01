class AddInfoToMassParams < ActiveRecord::Migration
  def change
    add_column :mass_params, :s3id, :string
    add_column :mass_params, :filename, :string
    add_foreign_key :mass_params, :users
  end
end
