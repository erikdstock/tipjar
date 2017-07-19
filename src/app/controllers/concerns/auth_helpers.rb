module Concerns
  module AuthHelpers
    extend ActiveSupport::Concern

    JWT_MATCHER = /Bearer\s([a-zA-Z0-9\-_]+\.[a-zA-Z0-9\-_]+.[a-zA-Z0-9\-_]+)$/
    
    def current_user
      @_current_user ||= find_current_user
    end

    private

    def find_current_user
      p 'finding user...'
      return nil unless jwt
      p jwt
      p @_current_user = User.find_by(jti: jwt) # hmm actually need to parse jti from jwt!
    end

    def jwt
      return nil unless auth = request.headers['HTTP_AUTHORIZATION']
      p auth
      p @_jwt ||= JWT_MATCHER.match(auth)&.[](1)
    end

  end
end
