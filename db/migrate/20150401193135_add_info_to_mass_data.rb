class AddInfoToMassData < ActiveRecord::Migration
  def change
    add_column :mass_data, :s3id, :string
    add_column :mass_data, :filename, :string

    add_column :mass_data, :user_id, :integer
    add_index :mass_data, :user_id
    add_foreign_key :mass_data, :users, :dependent => :destroy
  end
end
