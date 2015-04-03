class MassDataController < ApplicationController
  before_filter :authenticate_user!
  def create
  	#should redirect to next step
  	#redirect_to new_mass_param_path
  end
  def new
    @s3_direct_post = S3_BUCKET.presigned_post(key: "#{current_user.id}/data/${filename}", success_action_status: 201)
    debugger
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
