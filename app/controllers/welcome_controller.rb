class WelcomeController < ApplicationController

	def index
		puts current_user.uid
	end
	
end
