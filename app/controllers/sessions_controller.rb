class SessionsController < ApplicationController
  def new
    # render login page
  end

  def create
    # get user that corresponds with username from database
    user = User.find_by username: params[:username]
    # save id of the user thats logged in (if user exists)
    session[:user_id] = user.id if not user.nil?
    # redirect user to ones own page
    redirect_to user
  end

  def destroy
    # nullify the session
    session[:user_id] = nil
    # redirect application to main page
    redirect_to :root
  end
end