class SessionsController < ApplicationController


  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_uid(auth["uid"])

	if user.nil?
		redirect_to clients_path, :notice => "No tiene permiso para acceder a esta aplicacion"
	else
		session[:user_id] = user.id
		user.token = Token.new(:token_string => auth["credentials"]["token"])
		user.save
		#google_session = GoogleSession.instance
		#google_session.build_session_from_token(auth["credentials"]["token"])
	    	redirect_to clients_path, :notice => "Bienvenid@ " + user.name
	end
        
	#@auth = request.env["omniauth.auth"]
    #    @result = google_session.client.execute(
    #        :api_method => google_session.calendar_service.calendar_list.list,
    #        :parameters => {},
    #        :headers => {'Content-Type' => 'application/json'})
        
    end
      
      
      
# primera prueba, nos conectamos al calendario
    #calendar_service = client.discovered_api('calendar', 'v3')
    #@result = client.execute(
    #  :api_method => calendar_service.calendar_list.list,
    #  :parameters => {},
    #  :headers => {'Content-Type' => 'application/json'})

# segunda prueba, nos conectamos a gmail
#	gmail_service = client.discovered_api('gmail')
#	@result = client.execute(
#		:api_method => gmail_service.users.drafts.list,
#		:parameters => {'userId' => @auth['info']['email']},
#    		:headers => {'Content-Type' => 'application/json'})
	
#	draft_id = @result.data.drafts.first.id

# tercera prueba, imprimimos el contenido del primer borrador obtenido
#	@result = client.execute(
#	:api_method => gmail_service.users.drafts.get,
#	:parameters => {'userId' => @auth['info']['email'], 'id' => draft_id},
#	:headers => {'Content-Type' => 'application/json'})



    def destroy
        session[:user_id] = nil
        redirect_to clients_path, :notice => "Adios!"
    end

end
