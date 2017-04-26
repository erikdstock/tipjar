class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # a before_action for non-api routes
  def load_initial_data(data = {})
    p @initial_data = {
      constants: {
        
        API_PATH: ENV['APP_ROOT'],            # Root for react to talk to
        LASTFM_AUTH_URL: user_lastfm_omniauth_authorize_path,
      },
      session: {},
      user: {},
      artistData: {}
    }.merge(data)
  end

  def lastfm_auth_path
    %Q(#{ENV['APP_ROOT']}#{user_lastfm_omniauth_authorize_path})
  end

  def initial_data
    @initial_data ||= load_initial_data
  end

  def format_month_year(time)
    time.strftime '%B %Y'
  end

end
