class MassParam < ActiveRecord::Base
  has_many :results
  belongs_to :user

  attr_accessible :title, :s3id, :user_id

  def get_title
    t = /[\d-]\/(.*)$/.match(s3id)
    return t.captures[0]
  end

end
