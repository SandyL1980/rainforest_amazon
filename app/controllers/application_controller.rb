class ApplicationController < ActionController::Base
	helper_method :current_user

	def ensure_logged_in
    unless current_user
      flash[:alert] = "Please log in"
      #we don't need a flash.now, because the alert will display on the redirect
      redirect_to new_session_path
    end
  end

	private
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
end
