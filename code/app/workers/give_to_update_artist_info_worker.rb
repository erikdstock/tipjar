class GiveToUpdateArtistInfoWorker
  include Sidekiq::Worker

  def perform(artist_id, *_args)
    artist = Artist.find_by(id: artist_id)
    return nil unless artist
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
  end
end
