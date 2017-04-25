 module Users
   class OmniauthCallbacksController < Devise::OmniauthCallbacksController
     include Concerns::OauthHelpers

    def lastfm
      omni = request.env['omniauth.auth']
      authentication = Authentication.find_by(provider: omni['provider'], uid: omni['uid'])

      # If there is an existing auth for this user, sign them in [return the jwt]
      if authentication
        user = authentication.user
      elsif current_user
      # TODO: Need to redefine current_user, maybe move away from devise?
        Rails.logger.warn 'Already a current_user...'
        user = add_new_oauth(authentication, omni)
      else
        user = create_new_user(omni)
      end

      # Redirect with the jwt header
      redirect_to root_path, 'Authorization' => "Bearer #{user.jwt}"
     end

     def spotify
       omni = request.env['omniauth.auth']
       authentication = Authentication.find_by(provider: omni['provider'], uid: omni['uid'])
       if authentication
         sign_in_user(authentication)
       elsif current_user
         add_new_oauth(authentication, omni)
       else
         create_new_user(omni)
       end
     end
   end
 end
