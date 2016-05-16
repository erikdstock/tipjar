module ListeningStats
  # Interface
  def get_recent_tracks(user = self, *args)
    service.get_recent_tracks(user)
  end

  def get_top_artists(user = self, *args)
    service.get_top_artists(user)
  end

  private

  def service(service_class = LastfmApi)
    @service ||= service_class.new
  end
end
