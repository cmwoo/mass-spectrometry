class GeneralController < ApplicationController
  @@file_downloads = ["graph_search.exe", "rwoo_charge1_l.params"]
  @@downloads_path = File.join(Rails.root, "public", "downloads")

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
      send_file File.join(@@downloads_path, @file), :disposition => 'attachment;filename=\"#{@file}\"', :type => 'application/octet-stream'
      redirect_to examples_path
    end
    redirect_to examples_path

  end

  def about
  end

end
