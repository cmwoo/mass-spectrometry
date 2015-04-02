class MassDataController < ApplicationController
  def create
  	#should redirect to next step
  	#redirect_to new_mass_param_path
  end
  def new
  end

  def upload
    if params[:xml_file].nil?
      flash[:warning] = "No file input."
      redirect_to new_mass_datum_path
    else
      redirect_to new_mass_param_path
    end
  end

end
