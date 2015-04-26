class Result < ActiveRecord::Base
  belongs_to :user
  belongs_to :mass_data
  belongs_to :mass_params

  attr_accessible :s3id, :mass_data_id, :mass_params_id, :user_id, :flag, :s3id_2

  def has_been_run?
    return self.flag == true
  end

  def set_as_run
    self.flag = true
    self.save
  end

  def get_mass_data
    if mass_data_id then MassDatum.find(mass_data_id) else nil end
  end

  def get_mass_params
    if mass_params_id then MassParam.find(mass_params_id) end
  end

  def self.start_ssh
    hostname = 'ec2-52-10-218-125.us-west-2.compute.amazonaws.com'
    username = 'root'
    password = 'mass77spec'
    output = ""
    Net::SSH.start( hostname, username, :password => password ) do|ssh|
      #process
      output = ssh.exec!("echo 'Graph search is successfully running. You will receive an email when your analysis is complete.'")
    end
  end
end
