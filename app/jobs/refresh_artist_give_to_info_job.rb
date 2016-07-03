class RefreshArtistGiveToInfoJob < ActiveJob::Base
  queue_as :give_to

  def perform(artist_id, *args)
    artist = Artist.find(id)
    if artist.give_to_url.nil? || artist.give_to_url.empty? # Should probably figure this out before queueing?
      
    end
  end
end
