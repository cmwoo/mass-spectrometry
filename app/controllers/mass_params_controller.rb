class MassParamsController < ApplicationController
  before_filter :authenticate_user!
  def create
  	#should redirect to next step
  	#redirect_to new_mass_param_path
  end
  def new
  end

  def upload
    if params[:param_file].nil?
      flash[:warning] = "No file input."
      redirect_to new_mass_param_path
    else
      redirect_to review_path
    end
  end

end
