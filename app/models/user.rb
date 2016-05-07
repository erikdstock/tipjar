class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :database_authenticatable, :registerable,
  # :recoverable,  :timeoutable and :omniauthable

  ## Commenting the first devise line out because i'm getting an email can't be blank validation
  # devise :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:lastfm]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # byebug
      user.password = Devise.friendly_token[0,20]
      user.email     = auth.info.email
      user.name      = auth.info.name
      user.image     = auth.info.image # assuming the user model has an image
    end
  end
end
