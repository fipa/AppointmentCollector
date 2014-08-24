class SessionsController < ApplicationController


  def create     
    #What data comes back from OmniAuth?     
    @auth = request.env["omniauth.auth"]
    #Use the token from the data to request a list of calendars
    @token = @auth["credentials"]["token"]
    client = Google::APIClient.new
    client.authorization.access_token = @token
    calendar_service = client.discovered_api('calendar', 'v3')

# primera prueba, nos conectamos al calendario
    @result = client.execute(
      :api_method => calendar_service.calendar_list.list,
      :parameters => {},
      :headers => {'Content-Type' => 'application/json'})

# segunda prueba, nos conectamos a gmail
	gmail_service = client.discovered_api('gmail')
	@result = client.execute(
		:api_method => gmail_service.users.drafts.list,
		:parameters => {'userId' => @auth['info']['email']},
     		:headers => {'Content-Type' => 'application/json'})
	
	draft_id = @result.data.drafts.first.id

# tercera prueba, imprimimos el contenido del primer borrador obtenido
	@result = client.execute(
	:api_method => gmail_service.users.drafts.get,
	:parameters => {'userId' => @auth['info']['email'], 'id' => draft_id},
	:headers => {'Content-Type' => 'application/json'})


  end

end
