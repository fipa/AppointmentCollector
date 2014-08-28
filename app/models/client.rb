class Client < ActiveRecord::Base
    
    belongs_to :user

    def dates(time_min = nil, time_max = nil, max_results = 15)
        google_client = Google::APIClient.new
        google_client.authorization.access_token = self.user.current_token
	calendar_service = google_client.discovered_api('calendar', 'v3')
	
	parameters = Hash.new
	parameters[:calendarId] = self.class.calendar_id
	parameters[:timeMin] = time_min unless time_min.nil?
	parameters[:timeMax] = time_max unless time_max.nil?
	parameters[:maxResults] = max_results
        parameters[:fields] = 'items(created,description,end,endTimeUnspecified,id,start,summary)'
	#TODO pendiente filtrar por nombre parameters[:q] = self.full_name

	results = google_client.execute(
          :api_method => google_client.discovered_api('calendar', 'v3').events.list,
		:parameters => parameters,
          :headers => {'Content-Type' => 'application/json'}
	)

          return results
    end

end
