class GeneralController < ApplicationController

  def index
  end

  def review
  end

  def upload
  	if params[:param_file].nil?
  		redirect_to new_mass_param_path
  	else
  		redirect_to review_path
  	end
  end

  def examples
  end

  def about
  end

end
