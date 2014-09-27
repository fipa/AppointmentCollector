class HomeController < ApplicationController

	def index
		@calendars = current_user.calendars
	end

end
