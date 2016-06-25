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
    return parsed_artists if done_paging?(response, 'recenttracks', page)
    page += 1
    top_artists_by_period(user, from: from, to: to, parsed_artists: parsed_artists, page: page)
  end

  # Restructures artist data with counts
  def reduce_artists_from_tracks!(response, parsed_artists)
    parsed_artists ||= Hash.new(1)
    data = response['recenttracks']['track']
    data.each_with_object(parsed_artists) do |track, p_a|
      # begin
        artist_name = track['artist']['#text']
        count = p_a[artist_name]
        count += 1
        p_a
      # rescue NoMethodError => e
        # byebug
      # end
    end
  end

  def done_paging?(response, method_name, expected_page)
    # byebug
    meta = response[method_name]['@attr']
    page = meta['page'].to_i
    total_pages = meta['totalPages'].to_i
    puts "total pages to fetch: #{total_pages}" if page == 1
    raise "expected page #{expected_page}, got #{page}" unless page == expected_page
    # In case total pages is 0 (user has no tracks)
    page >= total_pages
  end

  # lastfm user.recenttracks method
  #
  def get_recent_tracks(user, args = {})
    more_params = {}
    more_params[:from] = unix_time(args[:from]) if args[:from]
    more_params[:to] = unix_time(args[:to]) if args[:to]
    more_params[:page] = args.fetch(:page, 1)
    more_params[:limit] = args.fetch(:limit, 200)
    params = {
      user: user.name,
      api_key: lastfm_id,
      method: 'user.getrecenttracks',
      format: 'json'
    }
    handle_response(RestClient.get(base, params: params.merge(more_params)))
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
    Rails.application.secrets.lastfm_id || ENV['lastfm_secret']
  end

  def lastfm_secret
    Rails.application.secrets.lastfm_secret || ENV['lastfm_secret']
  end
end
