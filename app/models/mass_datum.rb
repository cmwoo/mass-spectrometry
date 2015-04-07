class MassDatum < ActiveRecord::Base
  has_many :results
  belongs_to :user

  attr_accessible :title, :s3id, :user_id
end
