class MassParamsController < ApplicationController
  before_filter :authenticate_user!
	@@fields = ['charge_min', 'charge_max', 'mz_tolerance', 'mz_tolerance_2', 'scan_tolerance', 'pattern_size', 'min_score', 'retention_time_window', 'include_mass_mod', 'sigma', 'per_sigma', 'log_file', 'search_pattern', 'alt_pattern']
  @@selects = ['full_output', 'inclusion_list', 'mz_charge', 'mz_charge_scan']

  def create
    create_model(:MassParam, :mass_params_id)
  end

  def new
    @disabled_params = true
    current_result = current_user.current_result
    current_mass_params = if current_result then current_result.get_mass_params end
    if current_result && current_mass_params
      @message = "You have already uploaded #{current_mass_params.get_title}."
    else
      @message = "Please choose a .txt or .params file to upload."
    end
    @s3_direct_post = S3_BUCKET.presigned_post(key: "#{current_user.id}/params/#{SecureRandom.uuid}/${filename}", success_action_status: 201)
    @mass_param = MassParam.new
  end
  
  def new_file
    patterns_more = params['alt_pattern_more']
    file = params[:file]
    filename = file[:filename] + ".params"
    contents = ""
    contents = contents + get_fields_str(file)
    patterns_more.each_line {|p| contents = contents + "alt_pattern: " + p}
    contents = contents + "\n" unless contents[-1] === "\n"
    contents = contents + get_selects_str(file)
    send_data(contents, :filename => filename, :disposition => "attachment")
  end
  
  def get_fields_str(file)
    fields_str = ""
    @@fields.each do |f| 
      if !file[f].empty?
        fields_str = fields_str + f + ": " + file[f]
        fields_str = fields_str + ".log" if f === 'log_file'
        fields_str = fields_str + "\n"
      end
    end
    fields_str
  end
  
  def get_selects_str(file)
    selects_str = ""
    @@selects.each { |s| selects_str = selects_str + s + ": " + file[s] + "\n" }
    selects_str
  end
  
  def choose
    @all_params = MassParam.where(:user_id => current_user.id)
    @disabled_params = true
    @results = current_user.results
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

  def update_params
    update_model_choice(params[:data_id], :mass_params_id, :MassParam, "params")
  end
end
