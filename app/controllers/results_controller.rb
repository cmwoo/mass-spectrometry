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
   if !current_user.current_result
     flash[:warning] = "You've already run these files."
     @disabled = true
   elsif
     if !current_user.current_result.mass_params_id || !current_user.current_result.mass_data_id
       flash[:warning] = "You haven't uploaded one of the files."
       @disabled = true
     end
   end
  end
end
