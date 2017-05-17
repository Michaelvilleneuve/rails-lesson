class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    session[:user_id] = @user.can_log_in?(params[:password]) ? @user.id : false
    redirect_to (session[:user_id] ? root_path : new_session_path)
  rescue => e
    redirect_to new_session_path, notice: e
  end

  def destroy
    session.delete(:user_id) and redirect_to root_path 
  end
end