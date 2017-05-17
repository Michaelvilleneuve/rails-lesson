class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def authenticate
    return redirect_to new_session_path, notice: 'Vous n\'êtes pas connecté(e)' unless session[:user_id]
    @user = User.find(session[:user_id])
  end
end
