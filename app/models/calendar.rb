class Calendar < ActiveRecord::Base

	belongs_to :user
	has_many :clients, -> { order 'last_name' }

	def get_dates_from_client_between_dates(client, date_min, date_max)

		google_client = Google::APIClient.new
		google_client.authorization.access_token = self.user.current_token
		calendar_service = google_client.discovered_api('calendar', 'v3')

		#TODO averiguar lo del -3 y corregirlo
		parameters = Hash.new
		parameters[:calendarId] = self.calendar_key
		parameters[:timeMin] = date_min + "T00:00:00-03:00"
		parameters[:timeMax] = date_max + "T23:59:59-03:00"
		parameters[:fields] = 'items(created,description,end,id,start,summary)'
		parameters[:singleEvents] = true
		parameters[:q] = client.full_name
		parameters[:orderBy] = "startTime"

		logger.info("parametros para enviar a la API " +  parameters.to_s)

		results = google_client.execute(
			:api_method => google_client.discovered_api('calendar', 'v3').events.list,
			:parameters => parameters,
			:headers => {'Content-Type' => 'application/json'}
		)

		logger.info("respuesta de la API " + results.data.items.to_s)

		#TODO manejar respuesta de invalid credentials

		#TODO averiguar lo del -3 y corregirlo
		parsed_results = Array.new
		results.data.items.each do |item|
			date = CalendarDate.new
			date.summary = item.summary
			date.begining = item.start.dateTime.advance(:hours => -3)
			date.ending = item.end.dateTime.advance(:hours => -3)
			parsed_results << date unless Calendar.filters_apply?(date, client)
		end
		logger.info("resultados de la API " + parsed_results.to_s)
		return parsed_results

	end

	private


	def self.filters_apply?(date, client)
		if Calendar.block_filter_applies(date.summary)
			logger.info("filtro aplica")
			return true
		elsif Calendar.voided_event_filter_applies(date.summary, client.full_name)
			logger.info("filtro aplica")
			return true
		else
			return false
		end
	end

	def self.block_filter_applies(event_summary)
		logger.info("verificando filtro BLOQUE para [#{event_summary}]")
		return /BLOQUE/.match(event_summary)
	end

	def self.voided_event_filter_applies(event_summary, client_name)
		logger.info("verificando filtro voided para [#{event_summary}],[#{client_name}]")
		return /\(#{client_name}\)/.match("#{event_summary}")
	end


end
