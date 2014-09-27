class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
	before_action :check_is_logged_and_redirect

	def check_is_logged_and_redirect
		redirect_to login_path unless is_logged?
	end
  
  private
  
  def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

	def is_logged?
		return !session[:user_id].nil?
	end
  
end
