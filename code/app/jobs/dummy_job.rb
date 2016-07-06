class DummyJob < ActiveJob::Base

  # this method serializes the incoming data to redis so only use artist_id, not whole object
  def perform(str)
    logger.info "performing a job. #{str}"
  end
end
