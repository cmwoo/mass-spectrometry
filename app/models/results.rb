class Results < ActiveRecord::Base
  belongs_to :user
  belongs_to :mass_data
  belongs_to :params

  attr_accessible :s3id
end
