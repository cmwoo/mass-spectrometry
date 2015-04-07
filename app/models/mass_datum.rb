class MassDatum < ActiveRecord::Base
  has_many :results
  belongs_to :user

  attr_accessible :title
end
