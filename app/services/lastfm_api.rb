class LastfmApi < BaseApi
  include TimeHelpers
  attr_reader :base

  def initialize
    @base = "http://ws.audioscrobbler.com/2.0/"
  end

  # Paginates through user.getrecenttracks, reducing tracks to artists with track count.
  def top_artists_by_period(user, from: nil, to: nil, parsed_artists: nil, page: 1)
    puts "getting page #{page}"
    response = get_recent_tracks(user, limit: 200, from: from, to: to, page: page)
    parsed_artists = reduce_artists_from_tracks!(response, parsed_artists)
    return parsed_artists if done_paging?(page, response)
    page += 1
    top_artists_by_period(user, from: from, to: to, parsed_artists: parsed_artists, page: page)
  end

  # Restructures artist data with counts
  def reduce_artists_from_tracks!(response, parsed_artists = Hash.new(1))
    data = response['recenttracks']['track']
    data.each_with_object(parsed_artists) do |p_a, track|
      artist_name = track['artist']['#text']
      count = p_a[artist_name]
      count += 1
      p_a
    end
  end

  def done_paging?(page, response)
    total_pages = response['@attr']['totalPages'].to_i
    puts "page #{page} of #{total_pages}"
    page == total_pages
  end

  # lastfm user.recenttracks method
  #
  def get_recent_tracks(user, args = {})
    from = unix_time(args[:from])
    to = unix_time(args[:to])
    page = args.fetch(:page)
    limit = args.fetch(:limit)
    params = {
      user: user.name,
      api_key: lastfm_id,
      method: 'user.getrecenttracks',
      format: 'json',
      from: from,
      to: to,
      page: page,
      limit: limit
    }
    handle_response(RestClient.get(base, params: params))
  end

  # lastfm user.gettopartists method- takes period as a param
  # overall | 7day | 1month | 3month | 6month | 12month > overall is api defaults
  # this might not be good bc always is relative to today.
  def get_top_artists(user, args = {})
    defaults = {
      user: user.name,
      api_key: lastfm_id,
      method: 'user.gettopartists',
      format: 'json',
      period: '1month'
    }
    response = RestClient.get(base, params: defaults.merge(args))
    handle_response(response)
  end

  private

  # Handle response. Probably want to easily reach errors, maybe
  # package in meta or error fields since we want to standardize
  # this contract across multiple apis
  def handle_response(response)
    status_code = response.code.to_s
    if status_code =~ /^4/
      warn 'shits fucked'
      # handle 400-level response
    elsif status_code =~ /^5/
      warn 'lastfms fucked'
      # handle 500-level response
    else
      return JSON.parse(response)
    end
  end

  def lastfm_id
    Rails.application.secrets.lastfm_id
  end

  def lastfm_secret
    Rails.application.secrets.lastfm_secret
  end
end
