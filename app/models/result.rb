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

  def get_url(object_id)
    "https://s3-us-west-2.amazonaws.com/massspec/" + object_id
  end

  def start_ssh

    rand_dir = SecureRandom.uuid
    mass_datum = MassDatum.find(self.mass_data_id)
    mass_param = MassParam.find(self.mass_params_id)

    includes_third_output = false

    Net::SSH.start( 'ec2-52-25-108-244.us-west-2.compute.amazonaws.com', 'root', :password => ENV["EC2_PASSWORD"] ) do|ssh|

      #download data and params files from s3
      ssh.exec!("/cygdrive/c/'Program Files'/Amazon/AWSCLI/aws s3 cp s3://massspec/#{mass_datum.s3id} .")
      ssh.exec!("/cygdrive/c/'Program Files'/Amazon/AWSCLI/aws s3 cp s3://massspec/#{mass_param.s3id} .")

      #run tag_finder
      program_output = ssh.exec!("./tag_finder #{mass_datum.get_title} #{mass_param.get_title}")

      files = ssh.exec!("ls")
      if not files.include?(get_output1_title)
        ssh.exec!("echo '#{program_output}' > #{get_output1_title}")
        ssh.exec!("echo '#{program_output}' > #{get_output2_title}")
      end
      
      if files.include?(get_output3_title)
        includes_third_output = true
      end

      #upload results files to s3
      ssh.exec!("/cygdrive/c/'Program Files'/Amazon/AWSCLI/aws s3 cp #{get_output1_title} s3://massspec/#{self.user_id}/results/#{rand_dir}/#{get_output1_title}")
      ssh.exec!("/cygdrive/c/'Program Files'/Amazon/AWSCLI/aws s3 cp #{get_output2_title} s3://massspec/#{self.user_id}/results/#{rand_dir}/#{get_output2_title}")
      if includes_third_output
        ssh.exec!("/cygdrive/c/'Program Files'/Amazon/AWSCLI/aws s3 cp #{get_output3_title} s3://massspec/#{self.user_id}/results/#{rand_dir}/#{get_output3_title}")
      end

      # remove input and output files
      ssh.exec!("rm #{get_output1_title}")
      ssh.exec!("rm #{get_output2_title}")
      ssh.exec!("rm #{get_output3_title}")
      ssh.exec!("rm #{mass_datum.get_title}")
      ssh.exec!("rm #{mass_param.get_title}")

      # remove any log files that might exist
      ssh.exec!("rm -f #{get_title_without_ending}_filter_log*")


    end

    #update results model
    self.s3id = "#{self.user_id}/results/#{rand_dir}/#{get_output1_title}"
    self.s3id_2 = "#{self.user_id}/results/#{rand_dir}/#{get_output2_title}"

    if includes_third_output
      self.s3id_3 = "#{self.user_id}/results/#{rand_dir}/#{get_output3_title}"
    end
    self.save!

  end

  # gets title of data file without .mzxml ending
  def get_title_without_ending
    mass_datum_title = MassDatum.find(self.mass_data_id).get_title
    str_length = mass_datum_title.length - 6

    return mass_datum_title[0, str_length]
  end

  # returns [data_name]_chart.txt
  def get_output1_title
    return "#{self.get_title_without_ending}_chart.txt"
  end

  # returns [data_name]_massspec.csv
  def get_output2_title
    return "#{self.get_title_without_ending}_massspec.csv"
  end

  # returns [data_name]_filtered.mzxml
  def get_output3_title
    return "#{self.get_title_without_ending}_filtered.mzxml"
  end

end
