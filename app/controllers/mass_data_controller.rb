class MassDataController < ApplicationController
  before_filter :authenticate_user!
  def create
    if params[:s3_key].nil?
      flash[:warning] = "No file input."
      redirect_to new_mass_datum_path
    else
      mass_datum = MassDatum.create(:s3id => params[:s3_key], :user_id => current_user.id)
    if current_user.current_result
      result = current_user.current_result
      result.mass_data_id = mass_datum.id
    else
      result = Result.create(:mass_data_id => mass_datum.id, :user_id => current_user.id, :flag => false)
    end
      redirect_to new_mass_param_path
    end
  end

  def new
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201)
    @mass_datum = MassDatum.new
  end

end
