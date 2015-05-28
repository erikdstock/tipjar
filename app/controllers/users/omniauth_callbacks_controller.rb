class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def lastfm
		puts request.env["omniauth.auth"]
		@user = User.from_omniauth(request.env["omniauth.auth"])

		if @user.persisted?
			sign_in_and_redirect @user, event: :authentication
			set_flash_message(:notice, :success, :kind => "lastfm") if is_navigational_format?
		else
			session["devise.lastfm_data"]= request.env["omniauth.auth"]
			
			redirect_to

	end

end