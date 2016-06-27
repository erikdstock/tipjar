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
    return current_artists if refreshed || !current_artists.empty? && current_artists.all?(&:final?)
    return top_artists_for_month(time, refreshed: true) if update_top_artists_for_month!(current_artists, time_range)
    raise 'Something went wrong on refreshing top artists'
  end

  private

  # Update existing monthly_top_artists with new data
  # MVP now- optimize later once we have performance baseline
  # @param current_artists {ActiveRecord Collection}
  # @param time_range {Range} Calendar month to update
  # @return {ActiveRecord Collection} of updated artists
  def update_top_artists_for_month!(current_artists, time_range)
    month = time_range.first
    fresh_artists = refresh_monthly_top_artists(time_range)
    errors = []
    fresh_artists.each do |new_artist_data|
      artist = Artist.first_or_initialize(name: new_artist_data[:name])
      artist.image = new_artist_data[:image]
      monthly_top_artist = current_artists.first_or_initialize(artist: artist)
      next if monthly_top_artist.update(play_count: new_artist_data[:play_count], month: month, user: self)
      errors << monthly_top_artist
      logger.error "artist failed to save"
    end
    errors.empty?
  end

  # Refresh stale top artists
  # @param {Range} time range from #monthly_top_artists
  # @return {Collection} ActiveRecord Collection of [unsaved?] artists or false/raise?
  def refresh_monthly_top_artists(time_range)
    artists = fetch_top_artists_by_period(from: time_range.first, to: time_range.last)
    artists
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
