class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # a before_action for non-api routes
  def load_initial_data(data = {})
    @initial_data = {
      constants: {
        
        API_PATH: ENV['APP_ROOT'] + '/api',      # Root for react to talk to
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

  def user_top_artist_data(month)
    artists = current_user.top_artists_for_month(month)
    formatted_artists = artists.map do |artist|
      {
        name: artist.artist.name,
        artist_id: artist.artist_id,
        play_count: artist.play_count,
        image: artist.artist.image,
        month: artist.month,
        give_to_url: artist.artist.give_to_url,
        give_to_verified: artist.artist.give_to_verified
      }
    end
    [{
      month: format_month_year(month),
      artists: formatted_artists
    }]
  end
end
