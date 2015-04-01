class MassData < ActiveRecord::Base
  has_many :results
  belongs_to :user

  attr_accessible :title
end
