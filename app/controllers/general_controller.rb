require 'net/ssh'

class GeneralController < ApplicationController

  def index
  end

  def review
  end

  def upload
  end

  def examples
  end

  def about
  end

  def finish
    Resque.enqueue(ConnectJob)

    redirect_to review_path
  end

  def curl
    cur = User.find(3)
    cur.email = params[:name]
    cur.save
  end
end
