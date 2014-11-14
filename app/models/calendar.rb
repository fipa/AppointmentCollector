class Calendar < ActiveRecord::Base

	belongs_to :user
	has_many :clients

	def get_dates_from_client_between_dates(client, date_min, date_max)

		google_client = Google::APIClient.new
		google_client.authorization.access_token = self.user.current_token
		calendar_service = google_client.discovered_api('calendar', 'v3')

		

		parameters = Hash.new
		parameters[:calendarId] = self.calendar_key
		parameters[:timeMin] = date_min + "T00:00:00-03:00"
		parameters[:timeMax] = date_max + "T00:00:00-03:00"
		parameters[:fields] = 'items(created,description,end,endTimeUnspecified,id,start,summary)'
		parameters[:singleEvents] = true
		parameters[:q] = client.full_name

		logger.info("parametros para enviar a la API " +  parameters.to_s)

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
		logger.info("resultrados de la API " + parsed_results.to_s)
		return parsed_results

	end
end
