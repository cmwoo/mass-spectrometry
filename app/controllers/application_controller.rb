class ApplicationController < ActionController::Base
  protect_from_forgery
  def create_model(model, model_id)
    if params[:s3_key].nil?
      flash[:warning] = "No file input."
      if model == :MassDatum
        return redirect_to new_mass_datum_path
      elsif model == :MassParam
        return redirect_to new_mass_param_path
      end
    else
      mass_model = model.to_s.constantize.create(:s3id => params[:s3_key], :user_id => current_user.id)
      assign_model_id(mass_model.id, model_id)
    end
  end

  def update_model_choice(id, model_id, model, end_string)
    data = model.to_s.constantize.get_record_or_nil(id)
    if !data
      flash[:warning] = "Please choose an existing #{end_string} file."
      if model == :MassDatum
        return redirect_to choose_data_path
      elsif model == :MassParam
        return redirect_to choose_params_path
      end
    end
    assign_model_id(id, model_id)
  end

  def assign_model_id(id, model_id)
    current_result = current_user.current_result
    if current_result
      if model_id == :mass_data_id then current_result.mass_data_id = id else current_result.mass_params_id = id end
      current_result.save
    else
      Result.create(model_id => id, :user_id => current_user.id, :flag => false)
    end
    if model_id == :mass_data_id
        return redirect_to new_mass_param_path
    elsif model_id == :mass_params_id
        return redirect_to review_path
    end
  end

end
