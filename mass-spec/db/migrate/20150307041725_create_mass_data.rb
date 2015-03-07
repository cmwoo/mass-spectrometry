class CreateMassData < ActiveRecord::Migration
  def change
    create_table :mass_data do |t|
      t.string :title

      t.timestamps
    end
  end
end
