class ResultsController < ApplicationController
  before_filter :authenticate_user!
  def index
    # final results
    current_user.current_result.set_as_run
  end

  def review
   # "review and run"
   if !current_user.current_result
     @disabled = true
   elsif
     if !current_user.current_result.mass_params_id || !current_user.current_result.mass_data_id
       @disabled = true
     end
   end
  end
end
