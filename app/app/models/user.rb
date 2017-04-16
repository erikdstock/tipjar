class User < ApplicationRecord
  include Concerns::ListeningStats
  include TimeTools
  has_many :authentications
  has_many :monthly_top_artists
  has_many :top_artists, through: :monthly_top_artists, source: :artist

  after_create :queue_initial_refresh

  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, # hashes and stores a password in the database to validate user
         :jwt_authenticatable,      # Auth via jwt
         :omniauthable,             # omniauth.
         :recoverable,              # Password reset
         :registerable,             # handles signing up users through a registration process
         :trackable,                # tracks sign in count, timestamps and IP address.
         :validatable,              # provides validations of email and password.
         omniauth_providers: [:lastfm],
         jwt_revocation_strategy: self # Strategy for revoking jwts exists on user model
  #  :rememberable,             # manages generating and clearing a token for remembering the user from cookie
  # :confirmable,            # sends emails with confirmation instructions and verifies an account is confirmed
  # :lockable,               # lock account after failed signin attempts
  # :timeoutable,            # expires sessions that have not been active in a specified period of time.

  def jwt
    Warden::JWTAuth::UserEncoder.new.call(self, {})
  end

  # Get top artists for month
  # @param {Time}
  def top_artists_for_month(time)
    current_artists = top_artists_for_time(time_range_month(time))
    current_artists
  end

  # Update existing monthly_top_artists with new data
  # TODO: testing.
  # TODO: convey api source [lastfm etc]
  # @param new_artists {Hash} of values to update/create artists
  # @param month {Time} time-like object with month
  # @return {ActiveRecord Relation} of updated artists or false
  def update_top_artists_for_month(new_artists, month)
    top_artists_for_month(month).delete_all
    new_collection = new_artists.map do |name, new_artist_data|
      artist = Artist.find_or_create_by(name: name)
      artist.image = new_artist_data[:image]
      artist.save
      MonthlyTopArtist.new(user: self,
                           artist: artist,
                           month: month,
                           play_count: new_artist_data[:play_count])
    end
    save_collection(new_collection)
  end

  # On create, get top artists for past 3 calendar months.
  def queue_initial_refresh
    3.times do |num|
      LastfmUpdateMonthlyTopArtistsWorker.perform_async(id, num.months.ago) if lastfm_authorized?
    end
  end

  def top_artists_for_time(time_range)
    monthly_top_artists.where(month: time_range).includes(:artist)
  end

  # TODO: Remove?
  def top_artist_attributes
    [
      'artists.name',
      'artists.image',
      'month',
      'play_count',
      'user_id',
      'artist_id',
      'monthly_top_artists.updated_at'
    ].join(', ')
  end

  def save_collection(collection)
    success = collection.map(&:save)
    unless success.all?
      errored = new_collection.reject { |m| m.errors.blank? }
      errored.each { |m| logger.warn m.errors }
      return false
    end
    true
  end

  def lastfm_authorized?
    authentications.map(&:provider).include? 'lastfm'
  end

  ### Devise methods
  def password_required?
    authentications.empty? && super
  end

  def email_required?
    authentications.empty? && super
  end

  def apply_omniauth(omni)
    authentications.build(
      provider: omni['provider'],
      uid: omni['uid'],
      token: omni['credentials'].token,
      token_secret: omni['credentials'].secret
    )
  end
end
