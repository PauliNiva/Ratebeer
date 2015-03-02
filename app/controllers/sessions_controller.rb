class SessionsController < ApplicationController
  def new
    # render login page
  end

  def create
    user = User.find_by username: params[:username]
    if user && user.disabled
      redirect_to :back, notice: "your account is disabled, please contact an administrator."
    elsif user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Welcome back!"
    else
      redirect_to :back, notice: "Username and/or password mismatch."
    end
  end

  def destroy
    # nullify the session
    session[:user_id] = nil
    # redirect application to main page
    redirect_to :root
  end

  def create_oauth
    user = User.github(env['omniauth.auth'].info)
    if user
      login user
    else
      redirect_to :back, alert: "sign in using Github failed"
    end
  end

  def login(user)
    if user.disabled
      redirect_to :back, notice: "Your account is disabled, please contact an administrator"
    else
      session[:user_id] = user.id
      redirect_to user, notice: "Welcome back!"
    end
  end
end