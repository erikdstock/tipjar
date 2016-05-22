class UsersController < ApplicationController

	def show
		@user = User.find_by(id: params[:id])
		@stats = @user.get_recent_tracks

		puts @stats
		puts "^^^^^^^^^^^^^^"

	end

end
