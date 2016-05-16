class User < ActiveRecord::Base
  include ListeningStats
  # Include default devise modules. Others available are:
  # devise :rememberable, :trackable, :validatable,
  # :confirmable, :lockable, :database_authenticatable, :registerable,
  # :recoverable,  :timeoutable and :omniauthable
  devise :omniauthable, omniauth_providers: [:lastfm]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # byebug
      user.password = Devise.friendly_token[0, 20]
      user.email     = auth.info.email
      user.name      = auth.info.name
      user.image     = auth.info.image # assuming the user model has an image
    end
  end


  # def recent_artists(period: :month, json: true)
  #   artists = get_recent_artists(period)
  # end

end
