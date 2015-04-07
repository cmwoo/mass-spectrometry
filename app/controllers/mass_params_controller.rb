class MassParamsController < ApplicationController
  before_filter :authenticate_user!
  def create
    if params[:s3_key].nil?
      flash[:warning] = "No file input."
      redirect_to new_mass_datum_path
    else
      mass_datum = MassParam.create(:s3id => params[:s3_key], :user_id => current_user.id)
      debugger
      redirect_to review_path
    end
  end

  def new
    @s3_direct_post = S3_BUCKET.presigned_post(key: "params/#{current_user.id}/${filename}", success_action_status: 201)
    @mass_param = MassParam.new
  end

end
