
module ListeningStatsService
  class LastfmApi < BaseApi
    attr_reader :api

    def initialize
      # We might not need/want this gem. (lastfm-ruby)
      # it's poorly documented
      # and hard to specify [guess] request params
      # maybe just use httpparty or rest-client
      @api = Lastfm.new(lastfm_id, lastfm_secret)
    end

    def get_recent_tracks(user, args = {})
      api.user.get_recent_tracks(user.name)
    end

    def get_top_artists(user, args = {})
      api.user.get_top_artists(user.name)
    end

    private

    def lastfm_id
      Rails.application.secrets.lastfm_id
    end

    def lastfm_secret
      Rails.application.secrets.lastfm_secret
    end
  end
end
