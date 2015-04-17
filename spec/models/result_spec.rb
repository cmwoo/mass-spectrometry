require 'spec_helper'

describe Result do
  describe "SSH Access" do
    
    it "should send correct commands to the connection" do
      ssh_connection = mock("SSH Connection")
      Net::SSH.stub(:start).and_yield(ssh_connection)
      ssh_connection.should_receive(:exec!).with("echo 'Graph search is successfully running. You will receive an email when your analysis is complete.'")
      Result.start_ssh
    end
  end
end
