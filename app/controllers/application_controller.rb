class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_user

  protected

  def authenticate
    return redirect_to new_session_path, notice: 'Vous n\'êtes pas connecté(e)' if @current_user.nil?
  end

  def set_user
    @current_user = User.where(id: session[:user_id]).first
  end
end
