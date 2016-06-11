module ListeningStats
  # Get a user's recent tracks. Results are individual tracks and may be paginated if
  # the list is more than 200.
  # def api_recent_tracks(from:, to:) > this keyword syntax requires ruby 2.1
  def api_recent_tracks(args = {})
    p 'calling'
    from = args[:from]
    to = args[:to]
    raise "missing required args from: and to:" unless from && to
    parsed_artists = args.fetch(:parsed_artists, Hash.new(1))
    page = args.fetch(:page, 1)
    puts "getting page #{page}"
    response = service.get_recent_tracks(self, limit: 200, from: from, to: to, page: page)
    response = JSON.parse(response)
    result = response['recenttracks']
    parsed_artists = result['track'].reduce(parsed_artists) do |a, track|
      a[track['artist']['#text']] = a[track['artist']['#text']] + 1
      a
    end
    total_pages = result['@attr']['totalPages'].to_i
    puts "Page #{page} of #{total_pages}"
    return parsed_artists if page == total_pages
    api_recent_tracks(from: from, to: to, parsed_artists: parsed_artists, page: page + 1)
    ## Deal with paging- recursive call + reduce?
    parsed_artists.sort_by { |a, number| number }.reverse
  end

  def api_top_artists(args = {})
    response = service.get_top_artists(self, args)
    result = response['topartists']['artist']
    # Sort artists by tipped, accepting and invitable
    result
  end

  private

  def service(service_class = LastfmApi)
    @service ||= service_class.new
  end
end
