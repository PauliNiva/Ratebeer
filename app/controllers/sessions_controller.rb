class SessionsController < ApplicationController
  def new
    # render login page
  end

  def create
    user = User.find_by username: params[:username]
    if user.nil?
      redirect_to :back, notice: "User #{params[:username]} does not exist!"
    else
      session[:user_id] = user.id
      redirect_to user, notice: "Welcome back!"
    end
  end

  def destroy
    # nullify the session
    session[:user_id] = nil
    # redirect application to main page
    redirect_to :root
  end
end