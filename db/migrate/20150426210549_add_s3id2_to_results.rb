class AddS3id2ToResults < ActiveRecord::Migration
  def change
    add_column :results, :s3id_2, :string
  end
end
