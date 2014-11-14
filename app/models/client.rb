class Client < ActiveRecord::Base
    
	belongs_to :calendar
	delegate :user, to: :calendar

	def dates(date_min = nil, date_max = nil, max_results = 15)
		date_entries = self.calendar.get_dates_from_client_between_dates(self, date_min, date_max)
		return date_entries
	end
	
end
