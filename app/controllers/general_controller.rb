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
    if @@file_downloads.include? @file
      send_file(File.join(@@downloads_path, @file), 
        :disposition => 'attachment',
        :filename => @file, 
        type: 'application/octet-stream')
    else
      flash[:warning] = "Invalid filename"
      redirect_to downloads_path
    end
  end

  def about
  end

  def instructions
  end

end
