class ResultsController < ApplicationController
  before_filter :authenticate_user!
  def index
    # final results
    if !current_user.current_result
      #error
      flash[:warning] = "Please upload files to run."
    elsif
      if !current_user.current_result.mass_params_id || !current_user.current_result.mass_data_id
        #error
        flash[:warning] = "Please upload files to run."
      else
        current_user.current_result.set_as_run
      end
    end
  end

  def review
   # "review and run"
   current_result = current_user.current_result
   if !current_result
     flash[:warning] = "You've already run these files."
     @disabled = true
   elsif !current_result.mass_params_id || !current_result.mass_data_id
       flash[:warning] = "You haven't uploaded one of the files."
       @disabled = true
   else
       @message = "Data: #{current_result.get_mass_data.get_title} 
                   Parameters: #{current_result.get_mass_params.get_title}"
   end
  end
end
