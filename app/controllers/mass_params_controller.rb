class MassParamsController < ApplicationController
  before_filter :authenticate_user!
  def create
    if params[:s3_key].nil?
      flash[:warning] = "No file input."
      redirect_to new_mass_param_path
    else
      mass_param = MassParam.create(:s3id => params[:s3_key], :user_id => current_user.id)
      debugger
      if current_user.current_result
        result = current_user.current_result
        result.mass_params_id = mass_param.id
        result.save
      else
        result = Result.create(:mass_params_id => mass_param.id, :user_id => current_user.id, :flag => false)
      end
      redirect_to review_path
    end
  end

  def new
    current_result = current_user.current_result
    current_mass_params = if current_result then current_result.get_mass_params end
    if current_result && current_mass_params
      @message = "You have already uploaded #{current_mass_params.get_title}."
    else
      @message = "Please choose a .txt or .params file to upload."
    end
    @s3_direct_post = S3_BUCKET.presigned_post(key: "params/#{current_user.id}/${filename}", success_action_status: 201)
    @mass_param = MassParam.new
  end
  
  def new_file
    file = params[:file]
    filename = file[:title]
    contents = "field = " + file[:field]
    send_data(contents, :filename => filename)
  end

end
