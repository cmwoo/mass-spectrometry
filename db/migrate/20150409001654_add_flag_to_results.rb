class AddFlagToResults < ActiveRecord::Migration
  def change
    add_column :results, :flag, :boolean
  end
end
