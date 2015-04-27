require 'net/ssh'

class GeneralController < ApplicationController
  before_filter :authenticate_user!, only: [:downloads, :examples]
  
  @@file_downloads = ["CWT_PD.exe", 
                      "Graph_search.exe",
                      "ExampleParams.params",
                      "Tag_finder.exe",
                      "ExampleParams.txt"]

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

  def downloads
  end

  def examples
  end

  def about
  end

  def instructions
  end

end
