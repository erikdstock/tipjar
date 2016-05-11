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

  def service(service_class = LastFmApi)
    @service ||= service_class.new
  end


  def last_month_unix(day = DateTime.now.day)
    now = DateTime.now
    last_month = now.month - 1
    last_month_length = DateTime.new(now.year, last_month, -1).day
    if day == :start
      day = 1
    elsif day == :end || (day.class == Fixnum && day > last_month_length)
      day = -1
    elsif day < 0 || day > 31
      throw ArgumentError.new('invalid target day')
    end

    DateTime.new(now.year, last_month, day).to_time.to_i
  end

end
