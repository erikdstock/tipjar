class LastfmApi < BaseApi
  attr_reader :base, :default_params

  def initialize
    @base = "http://ws.audioscrobbler.com/2.0/"
  end

  def get_recent_tracks(user, args={})
    defaults = {
      user: user.name,
      api_key: lastfm_id,
      method: 'user.getrecenttracks',
      period: '1month',
      format: 'json'
    }
    response = RestClient.get(base, params: defaults.merge(args))
  end

  def get_top_artists(user, args = {})
    defaults = {
      user: user.name,
      api_key: lastfm_id,
      method: 'user.gettopartists',
      format: 'json',
      # from: 123456,
      # to: 1234567
    }
    response = RestClient.get(base, params: defaults.merge(args))
    return JSON.parse(response)
  end

  private

  def lastfm_id
    Rails.application.secrets.lastfm_id
  end

  def lastfm_secret
    Rails.application.secrets.lastfm_secret
  end
end
