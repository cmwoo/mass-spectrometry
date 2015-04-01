class AddInfoToMassParams < ActiveRecord::Migration
  def change
    add_column :mass_params, :s3id, :string
    add_column :mass_params, :filename, :string

    add_column :mass_params, :user_id, :integer
    add_index :mass_params, :user_id
    add_foreign_key :mass_params, :users, :dependent => :destroy
  end
end
