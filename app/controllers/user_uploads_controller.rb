class UserUploadsController < ApplicationController
  before_filter :authenticate_user!
  def uploads
    @results = current_user.results
  end
end

