module ListeningStatsService
  class BaseApi
    def get_recent_tracks(*args)
      abstract_method!
    end

    def get_top_artists(*args)
      abstract_method!
    end

    private

    def abstract_method!
      raise RuntimeError.new 'called abstract method'
    end
  end
end
