class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :s3id

      t.timestamps
    end
  end
end
