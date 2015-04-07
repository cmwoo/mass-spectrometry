class Result < ActiveRecord::Base
  belongs_to :user
  belongs_to :mass_data
  belongs_to :mass_params

  attr_accessible :s3id
end
