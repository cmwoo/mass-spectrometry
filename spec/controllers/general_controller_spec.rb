require 'spec_helper'

describe GeneralController do

  describe 'download an executable file' do
    before :each do 
      @@file_downloads = ["test_executable.exe"]
      @@downloads_path = File.join(Rails.root, "spec", "fixtures", "files")
    end

    it "show warning when passed invalid file" do
      get :download_file, :file => 'missingfile.txt'
      expect(response).to redirect_to(downloads_path)
      expect(flash[:warning]).to be_present
    end

    it "can download an existing file" do
      get :download_file, :file => 'test_executable.exe'
      expect(response.status).to eq(200)
    end
  end


end
