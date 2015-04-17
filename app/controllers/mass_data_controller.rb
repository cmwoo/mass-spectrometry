class MassDataController < ApplicationController
  before_filter :authenticate_user!
  def create
    create_model(:MassDatum, :mass_data_id)
  end

  def new
    @disabled_page = true
    current_result = current_user.current_result
    current_mass_data = if current_result then current_result.get_mass_data else nil end
    if current_result && current_mass_data
      @message = "You have already uploaded #{current_mass_data.get_title}."
    else
      @message = "Please choose a .zxml file to upload."
    end
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201)
    @mass_datum = MassDatum.new
  end

  def choose
    @all_data = MassDatum.where(:user_id => current_user.id)
    @disabled_page = true
    @results = current_user.results
    current_result = current_user.current_result
    current_mass_data = if current_result then current_result.get_mass_data else nil end
    if current_result && current_mass_data
      @message = "You have already uploaded #{current_mass_data.get_title}."
    else
      @message = "Please choose a file to upload."
    end
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201)
    @mass_datum = MassDatum.new
  end

  def update_choice
    update_model_choice(params[:data_id], :mass_data_id, :MassDatum, ".zxml")
  end
end
