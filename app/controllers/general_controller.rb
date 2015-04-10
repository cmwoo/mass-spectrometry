require 'net/ssh'

class GeneralController < ApplicationController

  def index
  end

  def review
  end

  def upload
  end

  def examples
  end

  def about
  end

  def finish
    output = ""
    hostname = 'ec2-54-191-52-71.us-west-2.compute.amazonaws.com'
    username = 'ubuntu'
    Net::SSH.start( hostname, username, :keys => "config/key1.pem" ) do|ssh|
      #process
      output = ssh.exec!("./hello.sh")
    end
    flash[:alert] = output
    redirect_to review_path
  end

end
