#TODO GOOGLE CLIENT ID and GOOGLE_CLIENT_SECRET should be environment variables and they shouldn't be comitted
Rails.application.config.middleware.use OmniAuth::Builder do
	#provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"]
	provider :google_oauth2, '616679661881-pnn0tseh0q672jg90ophcqis5lb8rdt0.apps.googleusercontent.com', 'FCHSjeGbFNKXEey2D6yi_Yin', {
		scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar',
		redirect_uri:'http://fpoblete.kd.io:3000/auth/google_oauth2/callback'
	}
end
