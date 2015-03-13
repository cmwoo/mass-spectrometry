class CreateMassParams < ActiveRecord::Migration
  def change
    create_table :mass_params do |t|
      t.string :title

      t.timestamps
    end
  end
end
