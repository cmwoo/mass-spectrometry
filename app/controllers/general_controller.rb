require 'net/ssh'

class GeneralController < ApplicationController
  @@file_downloads = ["graph_search.exe", "sample_params.params"]
  @@downloads_path = File.join(Rails.root, "public", "downloads_page")

  def index
  end

  def review
  end

  def upload
  end

  def download_file
    @file = params[:file]
    puts @file
    if @@file_downloads.include? @file
      send_file(File.join(@@downloads_path, @file), 
        :disposition => 'attachment',
        :filename => @file, 
        type: 'application/octet-stream')
    end
  end

  def about
  end

  def instructions
  end

  def finish
    hostname = 'ec2-52-10-218-125.us-west-2.compute.amazonaws.com'
    username = 'root'
    password = 'mass77spec'
    output = ""
    Net::SSH.start( hostname, username, :password => password ) do|ssh|
      #process
      output = ssh.exec!("echo 'Graph search is successfully running. You will receive an email when your analysis is complete.'")
    end
    flash[:notice] = output
    redirect_to finish_index_path
  end

end
