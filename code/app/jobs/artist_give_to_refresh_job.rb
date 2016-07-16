class ArtistGiveToRefreshJob < ActiveJob::Base
  # queue_as :give_to

  # this method serializes the incoming data to redis so only use artist_id, not whole object
  def perform(artist_id, *args)
    artist = Artist.find(artist_id)
    logger.info "checking give.to data for artist #{artist.name}"
    if artist.give_to_incomplete?
      give_to_data = GiveToApi.new.check_artist(artist.name)
      logger.info "updating:"
      if artist.update_empty_give_to_fields(give_to_data)
        logger.info "success"
        return true
      else
        logger.info "error: save failed"
        return false
      end
    end
    logger.info "#{artist.name}'s data is up to date"
    true
  end
end
