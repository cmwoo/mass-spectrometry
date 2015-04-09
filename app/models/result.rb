class Result < ActiveRecord::Base
  belongs_to :user
  belongs_to :mass_data
  belongs_to :mass_params

  attr_accessible :s3id, :mass_data_id, :mass_params_id, :user_id, :flag

  def has_been_run?
    return self.flag == true
  end

  def set_as_run
    self.flag = true
    self.save
  end
end
