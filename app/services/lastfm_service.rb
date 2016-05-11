class LastFmService

  # class << self
  #   @@keys = {}
  #
  #   # /**
  #   #  * Set api keys for service creation
  #   #  * @param  {Hash} options lastfm_id & lastfm_secret (in initializers)
  #   #  * @return {TrueClass}
  #   #  */
  #   def self.set_keys!(options)
  #     @@keys.merge(options) && true
  #   end
  # end


  def initialize(service: LastFm)
    @service = service.new()
  end

  def getTopArtists(period: :this_month)

  end

end
