class Client < ActiveRecord::Base
    
    belongs_to :calendar
	delegate :user, to: :calendar

	def dates(date_min = nil, date_max = nil, max_results = 15)
		date_entries = get_dates_from_calendar(date_min, date_max, max_results)
		return date_entries

	end
	

	private

    def get_dates_from_calendar(date_min, date_max, max_results)
        google_client = Google::APIClient.new
        google_client.authorization.access_token = self.user.current_token
	    calendar_service = google_client.discovered_api('calendar', 'v3')
	
    	parameters = Hash.new
    	parameters[:calendarId] = self.calendar_id
    	parameters[:timeMin] = date_min + "T00:00:00-03:00"
    	parameters[:timeMax] = date_max + "T00:00:00-03:00"
    	parameters[:maxResults] = max_results
        parameters[:fields] = 'items(created,description,end,endTimeUnspecified,id,start,summary)'
    	parameters[:singleEvents] = true 
    	parameters[:q] = self.full_name
    	
    	logger.info "FIPA Request a google calendar " + parameters.to_s
    	
    	results = google_client.execute(
            :api_method => google_client.discovered_api('calendar', 'v3').events.list,
            :parameters => parameters,
            :headers => {'Content-Type' => 'application/json'}
    	)
    
        #TODO manejar respuesta de ivnalid credentials
    	parsed_results = Array.new
    	results.data.items.each do |item|
            	date = CalendarDate.new
    		date.summary = item.summary
    		date.begining = item.start.dateTime
    		date.ending = item.end.dateTime
    		parsed_results << date	
    	end
    	return parsed_results

    end



end
