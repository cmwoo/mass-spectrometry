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
    #Resque.enqueue(ConnectJob)
    hostname = 'ec2-52-10-218-125.us-west-2.compute.amazonaws.com'
    username = 'root'
    password = 'mass77spec'
    output = ""
    Net::SSH.start( hostname, username, :password => password ) do|ssh|
      #process
      output = ssh.exec!("echo 'Graph search is successfully running. You will receive an email when your analysis is complete.'")
    end
    flash[:notice] = output #"Graph search is successfully running. You will receive an email when your analysis is complete."
    redirect_to review_path
  end

  def curl
    cur = User.find(3)
    cur.email = params[:name]
    cur.save
  end
end
