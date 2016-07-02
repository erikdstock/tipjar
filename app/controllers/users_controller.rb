class UsersController < ApplicationController

	def show
		@user = User.find_by(id: params[:id])
		@top_artists = @user.top_artists_for_month(1.month.ago)
	end

end
