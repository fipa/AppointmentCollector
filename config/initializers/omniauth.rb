# the variables ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"] must be set up on an initializer file like this:
#        ENV['GOOGLE_CLIENT_ID'] = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
#        ENV['GOOGLE_CLIENT_SECRET'] = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'


Rails.application.config.middleware.use OmniAuth::Builder do
	provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], {
		scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar https://www.googleapis.com/auth/gmail.compose https://mail.google.com',
		redirect_uri:'http://ufkkdc3b7db4.fpoblete.koding.io:3000/auth/google_oauth2/callback'
	}
end
