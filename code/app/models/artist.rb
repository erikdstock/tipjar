class Artist < ActiveRecord::Base
  has_many :monthly_top_artists
  after_create :queue_give_to_refresh
  # Check whether artist data is complete
  def give_to_incomplete?
    give_to_url.nil? || !give_to_verified
  end

  def queue_give_to_refresh(clobber: false)
    ArtistGiveToRefreshJob.perform_later(id, clobber: clobber) if give_to_incomplete?
  end

  # Update an artist's empty fields
  def update_empty_give_to_fields(data)
    logger.debug "updating #{name} with #{data}:"
    self.give_to_url ||= data[:url]
    self.give_to_verified ||= data[:verified]
    self.image ||= data[:image]
    self.save ? logger.debug('success') : logger.debug('fail')
  end

end
