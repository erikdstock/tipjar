class User < ActiveRecord::Base
  include ListeningStats
  include TimeHelpers

  devise :omniauthable, omniauth_providers: [:lastfm]

  has_many :monthly_top_artists
  has_many :top_artists, through: :monthly_top_artists, source: :artist

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.password = Devise.friendly_token[0, 20]
      user.email     = auth.info.email
      user.name      = auth.info.name
      user.image     = auth.info.image
    end
  end

  def top_artists_for_month(time, refreshed: false)
    validate_time_in_past(time)
    time_range = time_range_month(time)
    current_artists = current_top_artists(time_range)
    Rails.logger.debug "current_artists are not empty: #{!current_artists.empty?}"
    Rails.logger.debug "current_artists are final: #{current_artists.all?(&:final?)}"
    return current_artists if refreshed
    return current_artists if !current_artists.empty? && current_artists.all?(&:final?)
    new_artists = refresh_monthly_top_artists(time_range)
    if update_top_artists_for_month(current_artists, new_artists, time_range)
      return top_artists_for_month(time, refreshed: true)
    else
      errors = current_artists.filter { |mta| !mta.errors.empty? }
      Rails.logger.error errors
      raise "something went wrong."
    end
  end

  private

  # Update existing monthly_top_artists with new data
  # MVP now- optimize later once we have performance baseline
  # @param current_artists {ActiveRecord Collection}
  # @param new_artists {Array} of data to update
  # @param time_range {Range} Calendar month to update
  # @return {ActiveRecord Collection} of updated artists
  def update_top_artists_for_month(current_artists, new_artists, time_range)
    month = time_range.first
    errors = []
    new_artists.each do |new_data|
      old_data = current_artists.filter { |old| old.name == artist.name }
      if old_data.length == 1
        old_artist = old_data.first
        old_artist.update(new_data.merge(month: month))
      else
        artist = Artist.first_or_create(name: new_data[:name], image: new_data[:image])
        play_count = new_data[:play_count]
        new_monthly_top_artist = MonthlyTopArtist.new(artist: artist, month: month, play_count: play_count)
        errors << new_monthly_top_artist unless current_artists << new_monthly_top_artist
      end
    end
    errors.empty? ? current_artists : false
  end

  # Refresh stale top artists
  # @param {Range} time range from #monthly_top_artists
  # @return {Collection} ActiveRecord Collection of [unsaved?] artists or false/raise?
  def refresh_monthly_top_artists(time_range)
    artists = fetch_top_artists_by_period(from: time_range.first, to: time_range.last)
    # TODO
    # Artists will be a hash, need to save each as an actual MTA
    # if artists can be saved, return artists, else return false
    # also clobber/update the old monthly top artists
  end

  def current_top_artists(time_range)
    MonthlyTopArtist.where(user_id: id, month: time_range).includes(:artist)
  end

  def top_artist_attributes
    [
      "artists.name",
      "artists.image",
      "month",
      "play_count",
      "user_id",
      "artist_id",
      "monthly_top_artists.updated_at"
    ].join(", ")
  end

end
