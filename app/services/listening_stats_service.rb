require_relative 'apis/base_api'
require_relative 'apis/lastfm_api'

module ListeningStatsService
  # Interface
  def get_recent_tracks(user = self, *args)
    puts ("I AM getting recent tracks for #{user.name}")
    service.get_recent_tracks(user)
  end

  def get_top_artists(user = self, *args)
    puts "I am getting top artists for #{user}"
    service.get_top_artists(user)
  end

  private

  def service(service_class = LastfmApi)
    @service ||= service_class.new
  end

end
