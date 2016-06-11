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
    # return JSON.parse(response)
  end

  # Get top artists- takes period as a param
  # overall | 7day | 1month | 3month | 6month | 12month > overall is api defaults
  # this might not be good bc always is relative to today.
  def get_top_artists(user, args = {})
    defaults = {
      user: user.name,
      api_key: lastfm_id,
      method: 'user.gettopartists',
      format: 'json',
      period: '1month',
      # from: 123456,
      # to: 1234567
    }
    # puts args[:from]
    # puts args[:to]
    response = RestClient.get(base, params: defaults.merge(args))
    return JSON.parse(response)
  end

  private

  # Handle response. Probably want to easily reach errors, maybe
  # package in meta or error fields since we want to standardize
  # this contract across multiple apis
  def handle_response(res)
    if res.status.to_s.match /^4/
      warn 'shits fucked'
      # handle 400-level response
    elsif res.status.to_s.match /^5/
      warn 'lastfms fucked'
      # handle 500-level response
    else
      return JSON.parse(res)
    end
  end

  def lastfm_id
    Rails.application.secrets.lastfm_id
  end

  def lastfm_secret
    Rails.application.secrets.lastfm_secret
  end
end
