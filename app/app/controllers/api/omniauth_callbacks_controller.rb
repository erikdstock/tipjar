module Api
  class OmniauthCallbacksController < ApplicationController
    include Concerns::OauthHelpers
    def lastfm
      p request.env
      omni = request.env['omniauth.auth']
      p omni
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