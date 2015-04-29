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

  def start_ssh
    hostname = 'ec2-52-10-218-125.us-west-2.compute.amazonaws.com'
    username = 'root'
    password = 'mass77spec'
    output = ""

    rand_dir = SecureRandom.uuid
    mass_datum = MassDatum.find(self.mass_data_id)
    mass_param = MassParam.find(self.mass_params_id)

    Net::SSH.start( hostname, username, :password => password ) do|ssh|

      #download data and params files from s3
      output = ssh.exec!("/cygdrive/c/'Program Files'/Amazon/AWSCLI/aws s3 cp s3://mass-spec-test-bucket/#{mass_datum.s3id} .")
      output = ssh.exec!("/cygdrive/c/'Program Files'/Amazon/AWSCLI/aws s3 cp s3://mass-spec-test-bucket/#{mass_param.s3id} .")

      #run tag_finder
      program_output = ssh.exec!("./tag_finder #{mass_datum.get_title} #{mass_param.get_title}")

      files = ssh.exec!("ls")
      if not files.include?(get_output1_title)
        output = ssh.exec!("echo '#{program_output}' > #{get_output1_title}")
        output = ssh.exec!("echo '#{program_output}' > #{get_output2_title}")
      end
      
      #upload results files to s3
      output = ssh.exec!("/cygdrive/c/'Program Files'/Amazon/AWSCLI/aws s3 cp #{get_output1_title} s3://mass-spec-test-bucket/#{self.user_id}/results/#{rand_dir}/#{get_output1_title}")
      output = ssh.exec!("/cygdrive/c/'Program Files'/Amazon/AWSCLI/aws s3 cp #{get_output2_title} s3://mass-spec-test-bucket/#{self.user_id}/results/#{rand_dir}/#{get_output2_title}")

      ssh.exec!("rm #{get_output1_title}")
      ssh.exec!("rm #{get_output2_title}")
      ssh.exec!("rm #{mass_datum.get_title}")
      ssh.exec!("rm #{mass_param.get_title}")

    end

    #update results model
    self.s3id = "#{self.user_id}/results/#{rand_dir}/#{get_output1_title}"
    self.s3id_2 = "#{self.user_id}/results/#{rand_dir}/#{get_output2_title}"
    self.save!

  end

  def get_title_without_ending
    mass_datum_title = MassDatum.find(self.mass_data_id).get_title
    str_length = mass_datum_title.length - 6

    return mass_datum_title[0, str_length]
  end

  def get_output1_title
    return "#{self.get_title_without_ending}_chart.txt"
  end

  def get_output2_title
    return "#{self.get_title_without_ending}_massspec.csv"
  end
end
