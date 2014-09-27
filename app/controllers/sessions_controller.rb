class SessionsController < ApplicationController
	skip_before_action :check_is_logged_and_redirect, only: [:login, :create]

	def login
	end

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_uid(auth["uid"])

	if user.nil?
		redirect_to clients_path, :notice => "No tiene permiso para acceder a esta aplicacion"
	else
		session[:user_id] = user.id
		user.token = Token.new(:token_string => auth["credentials"]["token"])
		user.save
	    	redirect_to calendars_path, :notice => "Bienvenid@ " + user.name
	end
        
        
    end
      

    def destroy
        session[:user_id] = nil
        redirect_to clients_path, :notice => "Adios!"
    end

end
