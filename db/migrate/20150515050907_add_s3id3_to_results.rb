class AddS3id3ToResults < ActiveRecord::Migration
  def change
    add_column :results, :s3id_3, :string
    add_index :results, :s3id_3
  end
end
