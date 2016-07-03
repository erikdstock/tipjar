class UsersController < ApplicationController

	def show
		@month = 1.month.ago
		@user = User.find_by(id: params[:id])
		@top_artists = @user.top_artists_for_month(@month)
	end

end
