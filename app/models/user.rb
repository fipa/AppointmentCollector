class User < ActiveRecord::Base
    
    has_many :calendars

    def current_token
        self.tokens.last.token_string
    end

	private
	has_many :tokens 
	has_one :token
end
