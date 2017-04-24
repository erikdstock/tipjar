class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # a before_action for non-api routes
  def load_initial_data(data = {})
    @initial_data = {
      api_path: ENV['API_ROOT'],            # Root for react to talk to
      lastfm_oauth_url: external_facing_lastfm_callback_path,
    }.merge(data)
  end

  def external_facing_lastfm_callback_path
    "https://last.fm/api/auth?api_key=#{ENV['LASTFM_ID']}&cb=#{ENV['API_ROOT'] + user_lastfm_omniauth_callback_path}"
  end

  def initial_data
    @initial_data ||= load_initial_data
  end

  def format_month_year(time)
    time.strftime '%B %Y'
  end

  # CORS stuff we don't need right now
  # before_action :allow_cross_origin_requests

  # def preflight
  #   render nothing: true
  # end

  # private

  # def allow_cross_origin_requests
  #   headers['Access-Control-Allow-Origin'] = '*'
  #   headers['Access-Control-Request-Method'] = '*'
  #   headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
  #   headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  #   headers['Access-Control-Max-Age'] = '1728000'
  # end
end
