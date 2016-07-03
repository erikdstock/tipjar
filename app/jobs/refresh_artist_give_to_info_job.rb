class RefreshArtistGiveToInfoJob < ActiveJob::Base
  queue_as :give_to

  def perform(artist_id, *args)
    artist = Artist.find(artist_id)
    Rails.logger.info "checking give.to data for artist #{artist.name}"
    p "checking give.to data for artist #{artist.name}"
    if artist.give_to_url.nil? || !artist.give_to_verified# Should probably figure this out before queueing?
      give_to_data = GiveToApi.check_artist(artist.name)
      p give_to_data
      artist.give_to_url ||= give_to_data[:url]
      artist.give_to_verified ||= give_to_data[:verified]
      artist.image ||= give_to_data[:image]
      if artist.save
        p "#{artist.name} updated"
        p artist
        return true
      else
        return false
      end
    end
    Rails.logger.info "#{artist.name}'s data is up to date"
    p "#{artist.name}'s data is up to date"
  end
end
