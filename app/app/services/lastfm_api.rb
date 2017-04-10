class LastfmApi < BaseApi
  include TimeTools
  attr_reader :base

  def initialize(user)
    @base = 'http://ws.audioscrobbler.com/2.0/'
    @user = user
  end

  # Paginates through user.getrecenttracks, reducing tracks to artists with track count.
  # @return {Hash} with the structure { 'artist name' => {play_count: 5, image: 'http://...'}}
  def top_artists_by_period(from: nil, to: nil, tracks: [], page: 1)
    Rails.logger.debug "getting page #{page}"
    response = get_recent_tracks(limit: 200, from: from, to: to, page: page)
    tracks = tracks + response['recenttracks']['track']
    if done_paging?(response, 'recenttracks', page)
      return reduce_artists_from_tracks(tracks)
    end
    top_artists_by_period(from: from, to: to, tracks: tracks, page: page + 1)
  end


  # lastfm user.recenttracks method
  def get_recent_tracks(from: nil, to: nil, page: 1, limit: 200)
    query_params = {
      from: unix_time(from),
      to: unix_time(to),
      page: page,
      limit: limit
    }
    params = lastfm_params('user.getrecenttracks', query_params)
    handle_response(RestClient.get(base, params: params))
  end

  # lastfm user.gettopartists method- takes period as a param
  # overall | 7day | 1month | 3month | 6month | 12month > overall is api defaults
  # this might not be good bc always is relative to today.
  def get_top_artists(period: '1month')
    query_params = { period: period }
    params = lastfm_params('user.gettopartists', query_params)
    response = RestClient.get(base, params: params)
    handle_response(response)
  end

  private

  # Restructures artist track_data with counts
  def reduce_artists_from_tracks(tracks)
    tracks.group_by { |t| t['artist']['#text']}
      .map { |a, ts| [a, { play_count: ts.length, image: ts.last['image'][1]['#text'] }] }
      .to_h
  end

  def done_paging?(response, method_name, expected_page)
    meta = response[method_name]['@attr']
    page = meta['page'].to_i
    total_pages = meta['totalPages'].to_i
    return true if total_pages == 0
    Rails.logger.debug "total pages to fetch: #{total_pages}" if page == 1
    page == total_pages
  end

  def lastfm_params(method, params)
    {
      api_key: lastfm_id,
      format: 'json',
      user: @user.lastfm_name,
      method: method,
    }.merge(params.compact)
  end


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
    ENV['LASTFM_ID']
  end

  def lastfm_secret
    ENV['LASTFM_SECRET']
  end
end
