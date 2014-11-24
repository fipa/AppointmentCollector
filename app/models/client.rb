class Client < ActiveRecord::Base
    
	belongs_to :calendar
	delegate :user, to: :calendar

	def full_name
		return "#{self.first_name} #{self.last_name}"
	end
	

	def dates(date_min = nil, date_max = nil, max_results = 15)
		dates = Hash.new
		dates[:entries] = self.calendar.get_dates_from_client_between_dates(self, date_min, date_max)
		dates[:total_ammount] = 0
		dates[:entries].each do |entry|
			dates[:total_ammount]+= ((entry.ending - entry.begining)/3600).round * self.ammount
		end
		return dates
	end
	
end
