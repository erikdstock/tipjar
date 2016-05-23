module ListeningStats
  # Interface
  def get_recent_tracks(args = {})
    service.get_recent_tracks(self, args)
  end

  def get_top_artists(args = {})
    response = service.get_top_artists(self, args)
    result = response['topartists']['artist']
  end

  private

  def service(service_class = LastfmApi)
    @service ||= service_class.new
  end
end
