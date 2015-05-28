class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :database_authenticatable, :registerable,
  # :recoverable,  :timeoutable and :omniauthable
  devise :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
end
