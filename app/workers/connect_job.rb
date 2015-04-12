require 'net/ssh'

class ConnectJob
  @queue = :connect_queue
  def self.perform
    hostname = 'ec2-54-191-52-71.us-west-2.compute.amazonaws.com'
    username = 'ubuntu'
    Net::SSH.start( hostname, username, :keys => "config/key1.pem" ) do|ssh|
      #process
      output = ssh.exec!("./hello.sh")
    end
  end
end