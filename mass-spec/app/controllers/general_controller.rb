class GeneralController < ApplicationController

  def index
  end

  def review
  end

  def upload
    if params[:param_file].nil?
      if params[:xml_file].content_type != 'text/xml'
        redirect_to new_mass_datum_path
      else
        redirect_to new_mass_param_path
      end
    else
      if params[:param_file].content_type != 'text/txt'
        redirect_to new_mass_param_path
      else
        redirect_to review_path
      end
    end
  end

  def examples
  end

  def about
  end

end
